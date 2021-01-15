import 'dart:async';
import 'package:buffit_beta/models/application_user.dart';
import 'package:buffit_beta/services/auth_service.dart';
import 'package:buffit_beta/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  final _profession = BehaviorSubject<String>();
  final _passwordAgain = BehaviorSubject<String>();

  final _errorMessage = BehaviorSubject<String>();
  final _infoStream = BehaviorSubject<String>();
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
  Stream<String> get name => _name.stream.transform(validateName);
  Stream<String> get lastName => _lastName.stream.transform(validateLastName);
  Stream<String> get profession =>
      _profession.stream.transform(validateProfession);
  Stream<String> get passwordAgain =>
      _passwordAgain.stream.transform(validatePassword).doOnData((String c) {
        if (0 != _password.value.compareTo(c)) {
          _passwordAgain.sink.addError('Hesla se neshodují!');
        }
      });

  Stream<bool> get isMatchingandValid => CombineLatestStream.combine3(
      password, passwordAgain, email, (password, passwordAgain, email) => true);

  Stream<bool> get register1IsValid => CombineLatestStream.combine3(
      name, lastName, profession, (a, b, c) => true);

  Stream<String> get errorMessage => _errorMessage.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<User> get currentUser => authService.currentUser;
  Stream<ApplicationUser> get user => _user.stream;
  Stream<String> get infoStream => _infoStream.stream;
//Set

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeLastName => _lastName.sink.add;
  Function(String) get changeProfession => _profession.sink.add;
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
      sink.addError('Email musí být ve správném formátu');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('Musí být alespoň 8 znaků dlouhé');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 3) {
      sink.add(name.trim());
    } else {
      sink.addError('Musí být alespoň 3 znaky dlouhé');
    }
  });

  final validateLastName = StreamTransformer<String, String>.fromHandlers(
      handleData: (lastname, sink) {
    if (lastname.length >= 3) {
      sink.add(lastname.trim());
    } else {
      sink.addError('Musí být alespoň 3 znaky dlouhé');
    }
  });

  final validateProfession = StreamTransformer<String, String>.fromHandlers(
      handleData: (profession, sink) {
    if (profession.length >= 3) {
      sink.add(profession.trim());
    } else {
      sink.addError('Musí být alespoň 3 znaky dlouhé');
    }
  });

  //DISPOSE
  dispose() {
    _user.close();
    _email.close();
    _name.close();
    _lastName.close();
    _profession.close();
    _password.close();
    _infoStream.close();
    _passwordAgain.close();
    _errorMessage.close();
  }

  // ------ Register with credentials ------
  loginEmail() async {
    try {
      var authResult =
          await authService.signIn(_email.value.trim(), _password.value.trim());
      var user = await _firestoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
      clearErrorMessage();
    } on PlatformException catch (error) {
      print(error.message);
      _errorMessage.sink.add('Špatný email nebo heslo. Zkuste to znovu.');
    }
  }

  Future<String> resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: _email.value.trim());
      return 'Email Zaslán!';
    } catch (e) {
      return 'Špatná emailová adresa.';
    }
  }

  Future registerWithEmailAndPassword() async {
    try {
      final AuthResult = await authService.registerUser(
          _email.value.trim(), _password.value.trim());
      var user = ApplicationUser(
        uid: AuthResult.user.uid,
        name: _name.value,
        lastName: _lastName.value,
        profession: _profession.value,
        email: AuthResult.user.email,
        photoURL: AuthResult.user.photoURL,
        displayName: AuthResult.user.displayName,
      );
      _user.sink.add(user);
      clearErrorMessage();
      updateUserData(user);
    } on PlatformException catch (error) {
      print(error.message);
      _errorMessage.sink.add('Tento email je už používán.');
    } catch (error) {
      print(error.message);
      _errorMessage.sink.add('Tento email je už používán.');
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
    clearErrorMessage();
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
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredentail(credential);

        var user = ApplicationUser(
          uid: result.user.uid,
          email: result.user.email,
          photoURL: result.user.photoURL,
          displayName: result.user.displayName,
        );
        _user.sink.add(user);
        clearErrorMessage();
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
        'name': (user.name == '' && null) ? '' : user.name,
        'lastname': (user.lastName == '' && null) ? '' : user.lastName,
        'profession': (user.profession == '' && null) ? '' : user.profession,
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
