import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/backend/models/fav.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/models/product_fav.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:ecommerce/constants.dart';
import 'package:rxdart/rxdart.dart';

import 'db.dart';

class FavDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Delete Data  --------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  @override
  Future<void> deleteData(id) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(favCollectionName)
        .doc(id)
        .delete();
  }

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------  Get Products From Cart  ---------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Stream<List<ProductFav>> getProductsFav() {
    return Rx.combineLatest2(ProductsDB().getData(), FavDB().getData(),
        (List<Product> product, List<Fav> fav) {
      return fav.map((favItem) {
        final prod = product?.firstWhere(
            (element) => element.id == favItem.productId,
            orElse: () => null);
        return ProductFav(
          product: prod,
          isFav: favItem.isFav,
        );
      }).toList();
    });
  }

/*-----------------------------------------------------------------------------------------------------*/
/*--------------------------------------------  Get Id  -----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  getId() {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(favCollectionName)
        .doc()
        .id;
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Update Cart  ---------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Future<void> updateData(fav) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(favCollectionName)
        .doc(fav.productId)
        .update(fav.toMap());
  }

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Save Data  ----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Future<void> saveData(fav) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(favCollectionName)
        .doc(fav.productId)
        .set(fav.toMap());
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Get Data  ----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Stream<List<Fav>> getData() {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(favCollectionName)
        .orderBy('productId', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Fav.fromMap(doc.data())).toList());
  }
}
