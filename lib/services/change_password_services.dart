import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangePasswordServices {
  final FirebaseAuth _user = FirebaseAuth.instance;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  void changePassword(String password) async {
    final user = _user.currentUser;
    user!.updatePassword(password);

    var data = await _instance
        .collection("Users")
        .where("uid", isEqualTo: _user.currentUser!.uid)
        .get();

    String docId = data.docs[0].id;
    _instance.collection('Users').doc(docId).update({'password': password});
  }
}
