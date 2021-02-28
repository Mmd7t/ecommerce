import 'package:ecommerce/backend/models/product.dart';

class ProductFav {
  Product product;
  bool isFav;

  ProductFav({
    this.product,
    this.isFav,
  });

  factory ProductFav.fromMap(Map<String, dynamic> data) {
    return ProductFav(
      product: data['product'],
      isFav: data['isFav'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product': product,
      'isFav': isFav,
    };
  }
}
