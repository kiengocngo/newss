class MyUser {
  String uid;
  String name;
  String email;
  String password;
  String phoneNumber;
  String address;
  String base64Image;

  MyUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.base64Image,
  });

  factory MyUser.defaultUser() {
    return MyUser(
        uid: "uid",
        name: "name",
        email: "email",
        password: "password",
        phoneNumber: "phoneNumber",
        address: "address",
        base64Image: "base64Image");
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        base64Image: json["base64Image"]);
  }

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "address": address,
      "base64Image": base64Image
    };
  }
}
