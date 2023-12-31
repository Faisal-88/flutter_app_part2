import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String?> signIn(String email, String password);
  Future<String?> signUp(String email, String password);
  Future<User?> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool?> isEmailVerified();  
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signIn (String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
      email: email, password: password);
      return user.user?.uid;
  }

  Future<String?> signUp (String email, String password) async {
    UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password);
      return user.user?.uid;
  }

  Future<User?> getCurrentUser() async {
    User? user = await _firebaseAuth.currentUser;
    return user;
  }

  Future<void> sendEmailVerification() async {
    User? user = await _firebaseAuth.currentUser;
    user?.sendEmailVerification();
  }

  Future<void> signOut() async {
   return _firebaseAuth.signOut();
  }

  Future<bool?> isEmailVerified() async {
    User? user = await _firebaseAuth.currentUser;
    return user?.emailVerified;
  }

}
