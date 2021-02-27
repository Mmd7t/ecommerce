class Cart {
  String id;
  String productId;
  String quantity;
  String price;

  Cart({
    this.id,
    this.productId,
    this.quantity,
    this.price,
  });

  factory Cart.fromMap(Map<String, dynamic> data) {
    return Cart(
      id: data['id'],
      productId: data['productId'],
      quantity: data['quantity'],
      price: data['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}
