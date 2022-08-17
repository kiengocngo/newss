import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

  addNewUser(String uid, String email, String password, String name,
      String phoneNumber, String address, String base64Image) async {
    await _fireStoreService.collection("Users").doc(uid).set({
      "email": email,
      "password": password,
      "name": name,
      "phoneNumber": phoneNumber,
      "address":address,
      "base64Image": base64Image,
    });
  }
}
