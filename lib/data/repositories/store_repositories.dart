import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoreRepositories {
  final _store = FirebaseFirestore.instance;

  Future<void> saveUser(User user) async {
    try {
      final isUserExists = await _store
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => value.exists);

      if (!isUserExists) {
        await _store.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName,
          'photoUrl': user.photoURL,
          'createdAt': DateTime.now(),
        });
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<QuerySnapshot> getUsers() {
    return _store
        .collection('users')
        .where('uid', isNotEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
  }
}
