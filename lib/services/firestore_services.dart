import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/my_user.dart';

class FireStoreService {
  final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

  Future<bool> addNewUser(MyUser myUser) async {
    try {
      await _fireStoreService.collection("Users").add(myUser.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addChatMessage(
      String sender, String receiver, String message, DateTime time) async {
    try {
      await _fireStoreService.collection("Chats").add({
        "sender": sender,
        "receiver": receiver,
        "message": message,
        "dateTime": time,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
