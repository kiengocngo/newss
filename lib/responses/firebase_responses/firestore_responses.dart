import 'package:cloud_firestore/cloud_firestore.dart';

// response duoc ket noi voi firestore snapshots de thay doi ngay
// khi co data moi
class FireStoreResponse {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      String firstUser, secondUser) {
    final CollectionReference<Map<String, dynamic>> database =
        _instance.collection("Chats");

    return database
        .where("senderId", whereIn: [firstUser, secondUser])
        .orderBy("dateTime", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations(
      String currentUser) {
    final CollectionReference<Map<String, dynamic>> database =
        _instance.collection("Conversations");
    return database.orderBy("dateTime", descending: false).snapshots();
  }
}
