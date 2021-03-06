import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/backend/models/product_cart.dart';
import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:ecommerce/constants.dart';
import 'package:rxdart/rxdart.dart';

import 'db.dart';

class CartDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Delete Data  --------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  @override
  Future<void> deleteData(id) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .doc(id)
        .delete();
  }

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------  Get Products From Cart  ---------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Stream<List<ProductCart>> getProductsCart() {
    return Rx.combineLatest2(ProductsDB().getData(), CartDB().getData(),
        (List<Product> product, List<Cart> cart) {
      return cart.map((cartItem) {
        final prod = product?.firstWhere(
            (element) => element.id == cartItem.productId,
            orElse: () => null);
        return ProductCart(
          product: prod,
          quantity: cartItem.quantity,
          isAddedToCart: cartItem.isAddToCart,
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
        .collection(cartCollectionName)
        .doc()
        .id;
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-----------------------------------------  Update Cart  ---------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Future<void> updateData(cart) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .doc(cart.productId)
        .update(cart.toMap());
  }

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Save Data  ----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Future<void> saveData(cart) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .doc(cart.productId)
        .set(cart.toMap());
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Get Data  ----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  Stream<List<Cart>> getData() {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .orderBy('productId', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Cart.fromMap(doc.data())).toList());
  }
}
