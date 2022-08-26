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
      requestUid: json["requestUid"] ?? "null",
      acceptUid: json["acceptUid"] ?? "null",
      status: json["status"] ?? false,
    );
  }

  toMap() {
    return {"requestUid": requestUid, "acceptUid": acceptUid, "status": status};
  }
}
