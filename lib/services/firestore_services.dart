import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/auth_response.dart';

import 'package:news_app/src/models/my_user.dart';

class FireStoreService {
  final FirebaseFirestore _fireStoreService = FirebaseFirestore.instance;

  Future<UpdateResponse> addNewUser(MyUser myUser) async {
    try {
      final DocumentReference<Map<String, dynamic>> docId =
          await _fireStoreService.collection("Users").add(myUser.toJson());
      return UpdateResponse(isSuccess: true, message: docId.id);
    } on FirebaseException catch (e) {
      return UpdateResponse(isSuccess: false, message: e.code);
    }
  }

  Future<UpdateResponse> addChatMessage(
      String sender, String receiver, String message, DateTime time) async {
    try {
      final DocumentReference<Map<String, dynamic>> docId =
          await _fireStoreService.collection("Chats").add({
        "sender": sender,
        "receiver": receiver,
        "message": message,
        "dateTime": time,
      });
      return UpdateResponse(isSuccess: true, message: docId.id);
    } on FirebaseException catch (e) {
      return UpdateResponse(isSuccess: false, message: e.code);
    }
  }
}
