import 'dart:async';

import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/services/auth_service.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _passwordAgain = BehaviorSubject<String>();
  final _errorMessage = BehaviorSubject<String>();

  final authService = AuthService();
  final fb = FacebookLogin();
  final _user = BehaviorSubject<ApplicationUser>();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  //final _user = BehaviorSubject<User>();

//Get
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get passwordAgain =>
      _password.stream.transform(validatePassword);
  Stream<String> get errorMessage => _errorMessage.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<User> get currentUser => authService.currentUser;
  Stream<ApplicationUser> get user => _user.stream;

//Set

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePasswordAgain => _passwordAgain.sink.add;

//Validation

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp regExpEmail = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Must be valid email adress');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('Must be at least 8 character long');
    }
  });

  //DISPOSE
  dispose() {
    _user.close();
    _email.close();
    _password.close();
    _passwordAgain.close();
    _errorMessage.close();
  }

  // ------ Register with credentials ------
  loginEmail() async {
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = await _firestoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error.message);
      _errorMessage.sink.add(error.message);
    }
  }

  Future registerWithEmailAndPassword() async {
    try {
      final AuthResult = await authService.registerUser(
          _email.value.trim(), _password.value.trim());
      var user = ApplicationUser(
        uid: AuthResult.user.uid,
        email: AuthResult.user.email,
        photoURL: AuthResult.user.photoURL,
        displayName: AuthResult.user.displayName,
      );
      _user.sink.add(user);
      updateUserData(user);
    } on PlatformException catch (error) {
      _errorMessage.sink.add(error.message);
    }
  }

// ------ Google Login ------
  googleLogin() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final AuthResult = await authService.signInWithCredentail(credential);

    var user = ApplicationUser(
      uid: AuthResult.user.uid,
      email: AuthResult.user.email,
      photoURL: AuthResult.user.photoURL,
      displayName: AuthResult.user.displayName,
    );
    _user.sink.add(user);
    updateUserData(user);
  }

// ------ Facebook Login ------
  loginFacebook() async {
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);

    switch (res.status) {
      case FacebookLoginStatus.Success:
        print('It worked');
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredentail(credential);

        print('${result.user.displayName} is now logged in');
        var user = ApplicationUser(
          uid: result.user.uid,
          email: result.user.email,
          photoURL: result.user.photoURL,
          displayName: result.user.displayName,
        );
        _user.sink.add(user);
        updateUserData(user);

        break;
      case FacebookLoginStatus.Cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.Error:
        print('There was an error');
        break;
    }
  }

// ------ Add user to Firestore ------

  void updateUserData(ApplicationUser user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
      },
    );
  }

  logout() {
    authService.logout();
    _user.sink.add(null);
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = _auth.currentUser;

    if (firebaseUser == null) return false;

    var user = await _firestoreService.fetchUser(firebaseUser.uid);
    if (user == null) return false;

    _user.sink.add(user);
    return true;
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }
}
