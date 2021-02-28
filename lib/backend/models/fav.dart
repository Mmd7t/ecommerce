class Fav {
  String productId;
  bool isFav;

  Fav({
    this.productId,
    this.isFav,
  });

  factory Fav.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Fav(
      productId: data['productId'],
      isFav: data['isFav'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'isFav': isFav,
    };
  }
}
