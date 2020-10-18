import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/services/auth_service.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();
  final _user = BehaviorSubject<ApplicationUser>();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  //final _user = BehaviorSubject<User>();

  Stream<User> get currentUser => authService.currentUser;
  Stream<ApplicationUser> get user => _user.stream;

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

  dispose() {
    _user.close();
  }
//DISPOSE

// ------ Register with credentials ------
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final AuthResult = await authService.signIn(email, password);
    } catch (error) {
      print(error.toString());
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    final AuthResult = await authService.registerUser(email, password);
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
}
