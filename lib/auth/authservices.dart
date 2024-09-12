import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authservices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// sign in

  Future<User?> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return null;
      } else {
        throw Exception(e.code);
      }
    }
  }
// sign up

  Future<User?> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
          
          // generate username from email
User? user = userCredential.user;
          String username = email.split('@') [0];

          // create user database in firestore
 
          await _db.collection('users').doc(user!.uid).set({
            'email':email,
            'username': username,
          });
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

// sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
