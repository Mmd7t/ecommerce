import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_cart.dart';
import 'package:ecommerce/backend/services/db_fav.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:rxdart/rxdart.dart';

import 'cart.dart';
import 'fav.dart';

class ProductWithAttachs {
  Product product;
  bool isFav;
  bool isAddedToCart;

  ProductWithAttachs({
    this.product,
    this.isFav,
    this.isAddedToCart,
  });

  factory ProductWithAttachs.fromMap(Map<String, dynamic> data) {
    return ProductWithAttachs(
      product: data['product'],
      isFav: data['isFav'],
      isAddedToCart: data['isAddedToCart'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'isFav': isFav,
      'isAddedToCart': isAddedToCart,
    };
  }
}

class ProductsListWithAttachs {
  Stream<List<ProductWithAttachs>> getProductsWithAttachs() {
    return Rx.combineLatest3(
        ProductsDB().getData(), FavDB().getData(), CartDB().getData(),
        (List<Product> product, List<Fav> fav, List<Cart> cart) {
      return product.map((prod) {
        final cartData = cart?.firstWhere(
            (element) => element.productId == prod.id,
            orElse: () => null);
        final favData = fav?.firstWhere(
            (element) => element.productId == prod.id,
            orElse: () => null);

        return ProductWithAttachs(
          product: prod,
          isAddedToCart: cartData?.isAddToCart ?? false,
          isFav: favData?.isFav ?? false,
        );
      }).toList();
    });
  }

  // ProductsDB() {}
}
