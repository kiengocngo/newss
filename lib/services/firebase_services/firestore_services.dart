import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/chats/auth_response.dart';
import 'package:news_app/src/models/chats/chat.dart';
import 'package:news_app/src/models/chats/friends_models.dart';
import 'package:news_app/src/models/chats/my_user.dart';
import 'package:news_app/src/models/chats/recent_conversation.dart';

class FireStoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  addFriendsRequest(String currentUserUid, String targetUserUid) {
    FriendModel friendModel = FriendModel(
        requestUid: currentUserUid, acceptUid: targetUserUid, status: false);
    _instance.collection("Friends").add(friendModel.toMap());
  }

  fixFriendRequest(String uid) {
    _instance.collection("Friends").doc(uid).update({"status": true});
  }

  getFriends(String currentUserUid, String targetUserUid) {
    return _instance
        .collection("Friends")
        .where("requestUid", whereIn: [currentUserUid, targetUserUid]).get();
  }

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
      return const SearchResponse(isSuccess: false, data: []);
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

      for (var element in data.docs) {
        tmp.add(MyUser.fromJson(element.data()));
      }
      return SearchResponse(isSuccess: true, data: tmp);
    } catch (e) {
      return const SearchResponse(isSuccess: false, data: []);
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
