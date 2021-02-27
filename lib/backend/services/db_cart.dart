import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:ecommerce/constants.dart';

import 'db.dart';

class CartDB extends DB {
  FirebaseFirestore _db = FirebaseFirestore.instance;

/*-----------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Delete Data  --------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  @override
  Future<void> deleteData(cart) {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .doc(cart.id)
        .delete();
  }

  Future<bool> getDataById(id) async {
    List<Cart> carts = await _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .where('productId', isEqualTo: id)
        .get()
        .then(
            (value) => value.docs.map((e) => Cart.fromMap(e.data())).toList());

    for (var i = 0; i < carts.length; i++) {
      if (carts[i].productId == id) {
        return true;
      } else {
        return false;
      }
    }
    return null;
  }

/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Get Cart List  --------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  Future<List<Cart>> getCartList() {
    return _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .orderBy('id', descending: true)
        .get()
        .then(
            (value) => value.docs.map((e) => Cart.fromMap(e.data())).toList());
  }

/*-----------------------------------------------------------------------------------------------------*/
/*-------------------------------------  Get Product From Cart  ---------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  Future<List<Product>> getProductsFromCart() async {
    List<Product> productCartItems = List();
    List<Cart> cartItems;
    List productIdsList = List();
    int itemLength;
    await _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .orderBy('id', descending: true)
        .get()
        .then((value) {
      itemLength = value.docs.length;
      if (itemLength != 0) {
        cartItems = value.docs.map((e) => Cart.fromMap(e.data())).toList();
      }
    });
    productIdsList = cartItems.map((e) => e.productId).toList();

    for (int i = 0; i < productIdsList.length; i++) {
      Product docRef;
      await _db
          .collection(productCollectionName)
          .doc(productIdsList[i])
          .get()
          .then((value) {
        docRef = Product.fromMap(value.data());
        productCartItems.add(docRef);
      });
    }
    return productCartItems;
  }

/*-----------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Get ProductsCart  ------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  Stream<List<Product>> getProductsCart() async* {
    List<Product> productCartItems = List();
    List<Cart> cartItems;
    List productIdsList = List();
    int itemLength;
    await _db
        .collection(userCollectionName)
        .doc(UsersDB().getId())
        .collection(cartCollectionName)
        .orderBy('id', descending: true)
        .get()
        .then((value) {
      itemLength = value.docs.length;
      if (itemLength != 0) {
        cartItems = value.docs.map((e) => Cart.fromMap(e.data())).toList();
      }
    });
    productIdsList = cartItems.map((e) => e.productId).toList();
    for (int i = 0; i < productIdsList.length; i++) {
      Product docRef;
      await _db
          .collection(productCollectionName)
          .doc(productIdsList[i])
          .get()
          .then((value) {
        docRef = Product.fromMap(value.data());
        productCartItems.add(docRef);
      });
    }
    yield productCartItems;
  }


/*-----------------------------------------------------------------------------------------------------*/
/*--------------------------------------------  Get Id  -----------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/

  @override
  getId() {
    return _db.collection(cartCollectionName).doc().id;
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
        .doc(cart.id)
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
        .doc(cart.id)
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
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Cart.fromMap(doc.data())).toList());
  }
}
