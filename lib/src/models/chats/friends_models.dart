import 'dart:ffi';

class FriendModel {
  final String requestUid;
  final String acceptUid;
  final bool status;

  FriendModel(
      {required this.requestUid,
      required this.acceptUid,
      required this.status});

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
        requestUid: json["requestUid"],
        acceptUid: json["acceptUid"],
        status: json["status"]);
  }

  toMap() {
    return {"requestUid": requestUid, "acceptUid": acceptUid, "status": status};
  }
}
