class Product {
  String id;
  String name;
  String img;
  String description;
  String price;
  String amount;
  String category;
  bool isFav;
  bool isAddedToCart;

  Product({
    this.id,
    this.name,
    this.img,
    this.category,
    this.description,
    this.price,
    this.amount,
    this.isFav,
    this.isAddedToCart,
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      id: data['id'],
      name: data['name'],
      img: data['img'],
      description: data['description'],
      category: data['category'],
      price: data['price'],
      amount: data['amount'],
      isFav: data['isFav'],
      isAddedToCart: data['isAddedToCart'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'description': description,
      'category': category,
      'price': price,
      'amount': amount,
      'isFav': isFav,
      'isAddedToCart': isAddedToCart,
    };
  }
}
