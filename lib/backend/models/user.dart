class Users {
  String id;
  String name;
  String img;
  String email;
  String phoneNum;

  Users({
    this.id,
    this.name,
    this.img,
    this.email,
    this.phoneNum,
  });

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      id: data['id'],
      name: data['name'],
      img: data['img'],
      email: data['email'],
      phoneNum: data['phoneNum'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'email': email,
      'phoneNum': phoneNum,
    };
  }
}
