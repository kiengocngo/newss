import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  getUserByName(String name) async {
    var data = await _instance
        .collection("Users")
        .where("name", isEqualTo: name)
        .get();
    log(data.docs[0].data()["name"]);
  }

  addNewChat(String sender, String receiver, String message) async {
    await _instance.collection("Chats").add(
      {
        "senderId": sender,
        "receiverId": receiver,
        "message": message,
        "dateTime": DateTime.now(),
      },
    );
  }

  getChats(String sender, String receiver) async {
  }

  getConversations(String userId) async {
  }
}
