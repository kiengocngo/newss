import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/auth_response.dart';
import 'package:news_app/src/models/my_user.dart';

class FireStoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

 Future<SearchResponse> getUserByUid(String uid) async {
    try {
      var data = await _instance
          .collection("Users")
          .where("uid", isEqualTo: uid)
          .get();
      List<MyUser> tmp = [];
      tmp.add(MyUser.fromJson(data.docs[0].data()));
      tmp[0].uid = data.docs[0].id;
      return SearchResponse(isSuccess: true, data: tmp);
    } catch (e) {
      return SearchResponse(isSuccess: false, data: []);
    }
  }

  fixUserInfo(String uid, String field, dynamic data) {
    _instance.collection("Users").doc(uid).update({field: data});
  }

  getUserByName(String name) async {
    try {
      var data = await _instance
          .collection("Users")
          .where("name", isEqualTo: name)
          .get();
      List<MyUser> tmp = [];
      data.docs.forEach(
        (element) => tmp.add(MyUser.fromJson(element.data())),
      );
      return SearchResponse(isSuccess: true, data: tmp);
    } catch (e) {
      return SearchResponse(isSuccess: false, data: []);
    }
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

  fixConversation(String uid, String message) async {
    await _instance
        .collection("Conversations")
        .doc(uid)
        .update({"message": message, "dateTime": Timestamp.now()});
  }

  addNewConversations(
      String senderId,
      String receiverId,
      String senderName,
      String receiverName,
      String senderImage,
      String receiverImage,
      String message,
      Timestamp timestamp) async {
    await _instance.collection("Conversations").add({
      "senderId": senderId,
      "receiverId": receiverId,
      "senderName": senderName,
      "receiverName": receiverName,
      "senderImage": senderImage,
      "receiverImage": receiverImage,
      "message": message,
      "dateTime": Timestamp.now()
    });
  }

  getAllUser() async {
    return _instance.collection("Users").get();
  }

  getChats(String sender, String receiver) async {}

  Future<QuerySnapshot<Map<String, dynamic>>> getConversations(
      // check lai query
      String senderId,
      String receiverId) async {
    var database = _instance.collection("Conversations");
    return await database. where("senderId",whereIn: [senderId,receiverId]).get();
  }
}
