import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/chats/my_user.dart';

class GetUserData {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  Future<MyUser> getUsersData(String uid) async {
    var data =
        await _instance.collection("Users").where("uid", isEqualTo: uid).get();
    var usersData = MyUser.fromJson(data.docs.first.data());
    return usersData;
  }
}
