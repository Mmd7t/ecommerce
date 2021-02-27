import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce/backend/models/user.dart';
import 'package:ecommerce/backend/services/db.dart';

import '../../constants.dart';

class UsersDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  @override
  Future<void> deleteData(user) async {
    return await _db.collection(userCollectionName).doc(user.id).delete();
  }

  @override
  Stream<Users> getData() {
    return _db
        .collection(userCollectionName)
        .doc(getId())
        .snapshots()
        .map((event) => Users.fromMap(event.data()));
  }

  @override
  getId() {
    return FirebaseAuth.instance.currentUser.uid;
  }

  @override
  Future<void> saveData(user) async {
    return await _db
        .collection(userCollectionName)
        .doc(getId())
        .set(user.toMap());
  }

  @override
  Future<void> updateData(user) async {
    return await _db
        .collection(userCollectionName)
        .doc(user.id)
        .update(user.toMap());
  }
}
