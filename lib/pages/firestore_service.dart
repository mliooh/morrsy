

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getUsers() async {
    QuerySnapshot snapshot = await _db.collection('users').get();
    List<Map<String, dynamic>> users = snapshot.docs.map((doc) {
      return {
        'username': doc['username'],
        
        'email': doc['email'],
      };
    }).toList();

    return users;
  }
}