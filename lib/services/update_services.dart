
import 'package:cloud_firestore/cloud_firestore.dart';

import '../src/models/auth_response.dart';

class UpdateServices {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<UpdateResponse> updateUser(
    String uid,
    String name,
    String phone,
    String address,
    String base64Image,
  ) async {
    try {
      var data = await _instance
          .collection("Users")
          .where("uid", isEqualTo: uid)
          .get();
      if (data.docs.isNotEmpty) {
        String docId = data.docs.first.id;

        _instance.collection('Users').doc(docId).update({
          'name': name,
          'phoneNumber': phone,
          'address': address,
          'base64Image': base64Image,
        });
        return UpdateResponse(isSuccess: true, message: 'Success');
      } else {
        return UpdateResponse(isSuccess: false, message: 'Error');
      }
    } on FirebaseException catch (e) {
      return UpdateResponse(isSuccess: false, message: e.code);
    } catch (e) {
      return UpdateResponse(isSuccess: false, message: e.toString());
    }
  }
}
