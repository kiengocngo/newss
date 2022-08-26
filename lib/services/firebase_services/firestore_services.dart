import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/auth_response.dart';
import 'package:news_app/src/models/chat.dart';
import 'package:news_app/src/models/my_user.dart';
import 'package:news_app/src/models/recent_conversation.dart';

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
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach(
        (element) => tmp.add(MyUser.fromJson(element.data())),
      );
      return SearchResponse(isSuccess: true, data: tmp);
    } catch (e) {
      return SearchResponse(isSuccess: false, data: []);
    }
  }

  addNewChat(String sender, String receiver, String message) async {
    final Chat chat = Chat(
      senderId: sender,
      receiverId: receiver,
      message: message,
      timeStamp: Timestamp.now(),
    );
    await _instance.collection("Chats").add(
          chat.toMap(),
        );
  }

  fixConversation(String uid, String message) async {
    await _instance
        .collection("Conversations")
        .doc(uid)
        .update({"message": message, "dateTime": Timestamp.now()});
  }

  addNewConversations(RecentConversation recentConversation) async {
    await _instance.collection("Conversations").add(recentConversation.toMap());
  }

  getChats(String sender, String receiver) async {}

  Future<QuerySnapshot<Map<String, dynamic>>> getConversations(
      // check lai query
      String senderId,
      String receiverId) async {
    var database = _instance.collection("Conversations");
    return await database
        .where("senderId", whereIn: [senderId, receiverId]).get();
  }
}
