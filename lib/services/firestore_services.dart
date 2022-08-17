import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

  Future<bool> addNewUser(
      String uid,
      String email,
      String password,
      String name,
      String phoneNumber,
      String address,
      String base64Image) async {
    try {
      await _fireStoreService.collection("Users").add({
        "email": email,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "base64Image": base64Image,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
