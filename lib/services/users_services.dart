import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/src/models/my_users.dart';

class GetUsersData {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  Future<MyUser> getUsersData(String uid) async {
    var data =
        await _instance.collection("Users").where("uid", isEqualTo: uid).get();
    var usersData = MyUser.fromJson(data.docs[0].data());
    return usersData;
  }
}
