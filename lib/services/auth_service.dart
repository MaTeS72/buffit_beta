import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  Stream<User> get currentUser => _auth.authStateChanges();
  Future<UserCredential> signInWithCredentail(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
  Future<UserCredential> registerUser(email, password) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);
  Future<UserCredential> signIn(email, password) {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
