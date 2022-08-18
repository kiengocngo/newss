import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  getUserByName( String name) async {
    var data = await _instance
        .collection("Users")
        .where("name", isEqualTo: name)
        .get();
    print(data.docs[0].data());
  }
}
