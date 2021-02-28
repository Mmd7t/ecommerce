class Cart {
  String quantity;
  String productId;
  bool isAddToCart;

  Cart({
    this.quantity,
    this.productId,
    this.isAddToCart,
  });

  factory Cart.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Cart(
      productId: data['productId'],
      quantity: data['quantity'],
      isAddToCart: data['isAddToCart'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'productId': productId,
      'isAddToCart': isAddToCart,
    };
  }
}
