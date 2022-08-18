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

  getChats(String sender, String receiver) async {
    var data = await _instance
        .collection("Chats")
        .where("sender", isEqualTo: sender)
        .where("receiver", isEqualTo: receiver)
        .orderBy("dateTime", descending: true)
        .get();
  }

  getConversations(String userId) async {
    var data = await _instance
        .collection("Conversations")
        .where("receiver", isNotEqualTo: userId)
        .get();
  }
}
