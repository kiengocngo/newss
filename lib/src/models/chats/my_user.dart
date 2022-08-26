class MyUser {
  String uid;
  String name;
  String email;
  String password;
  String phoneNumber;
  String address;
  String base64Image;

  List<dynamic> friends;

  MyUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.address,
    required this.base64Image,
    required this.friends,
  });

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        uid: json["uid"] ?? "null",
        name: json["name"] ?? "null",
        email: json["email"] ?? "null",
        password: "no",
        friends: json["friends"] ?? "null",
        phoneNumber: json["phoneNumber"] ?? "null",
        address: json["address"] ?? "null",
        base64Image: json["base64Image"] ?? "null");
  }
}