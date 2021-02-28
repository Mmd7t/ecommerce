import 'package:ecommerce/backend/models/product.dart';

class ProductCart {
  Product product;
  String quantity;
  bool isAddedToCart;

  ProductCart({
    this.quantity,
    this.product,
    this.isAddedToCart,
  });

  factory ProductCart.fromMap(Map<String, dynamic> data) {
    return ProductCart(
      quantity: data['quantity'],
      product: data['product'],
      isAddedToCart: data['isAddedToCart'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'product': product,
      'isAddedToCart': isAddedToCart,
    };
  }
}
