import 'package:cloud_firestore/cloud_firestore.dart';

// response duoc ket noi voi firestore snapshots de thay doi ngay
// khi co data moi
class FireStoreResponse {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      String firstUser, secondUser) {
    final CollectionReference<Map<String, dynamic>> database =
        _instance.collection("Chats");

    database
        .where("senderId", isEqualTo: firstUser)
        .where("receiverId", isEqualTo: secondUser);
    database
        .where("senderId", isEqualTo: secondUser)
        .where("receiverId", isEqualTo: firstUser);

    return database.orderBy("dateTime", descending: false).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversations(
      String currentUser) {
    final CollectionReference<Map<String, dynamic>> database =
        _instance.collection("Conversations");
    database..where("senderId", isEqualTo: currentUser);
    database.where("receiverId", isEqualTo: currentUser);
    return database.orderBy("dateTime", descending: false).snapshots();
  }
}
