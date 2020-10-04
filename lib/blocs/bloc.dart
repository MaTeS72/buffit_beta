import 'package:buffit_beta/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Stream<User> get currentUser => authService.currentUser;

  googleLogin() async {
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final AuthResult = await authService.signInWithCredentail(credential);

    var user = AuthResult.user;
    updateUserData(user);
  }

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
        updateUserData(result.user);

        break;
      case FacebookLoginStatus.Cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.Error:
        print('There was an error');
        break;
    }
  }

  void updateUserData(User user) async {
    DocumentReference ref = _db.collection('users').doc(user.uid);

    return ref.set(
      {
        'uid': user.uid,
        'email': user.email,
        'photoURL': user.photoURL,
        'displayName': user.displayName,
        'lastSeen': DateTime.now()
      },
    );
  }

  logout() {
    authService.logout();
  }
}
