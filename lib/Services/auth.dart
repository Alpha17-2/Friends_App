import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authservice {
  // Create an instance of firebase authentication.
  final FirebaseAuth _auth;

  authservice(this._auth);
  //auth is an private property !!

  // ignore: non_constant_identifier_names

  Stream<User> get austhStateChanges => _auth.authStateChanges();

//sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

//sign in with email and password  !!
  Future<String> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "valid";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User currentUser = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection(currentUser.uid.toString())
          .doc('details')
          .set({
        'firstName': "NA",
        "lastName": "NA",
        "education": "NA",
        "dp": "NA",
        "email": email,
      }).then((value) {
        currentUser.sendEmailVerification();
      });
      return "valid";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return 'ok';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}