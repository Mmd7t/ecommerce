import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/constants.dart';

import 'db.dart';

class ProductsDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<void> deleteData(product) {
    return _db.collection(productCollectionName).doc(product.id).delete();
  }

  @override
  getId() {
    return _db.collection(productCollectionName).doc().id;
  }

  @override
  Stream<List<Product>> getData() {
    return _db
        .collection(productCollectionName)
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList());
  }

  Future getDataById(productId) async {
    return await _db
        .collection(productCollectionName)
     .doc(productId).get().then((value) => Product.fromMap(value.data()));

  }

  @override
  Future<void> saveData(product) {
    return _db
        .collection(productCollectionName)
        .doc(product.id)
        .set(product.toMap());
  }

  @override
  Future<void> updateData(product) {
    return _db
        .collection(productCollectionName)
        .doc(product.id)
        .update(product.toMap());
  }
}
