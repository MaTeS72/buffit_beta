import 'package:buffit_beta/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();
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

    print("User Name: ${user.displayName}");
    print("User Email ${user.email}");
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

        break;
      case FacebookLoginStatus.Cancel:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.Error:
        print('There was an error');
        break;
    }
  }

  logout() {
    authService.logout();
  }
}
