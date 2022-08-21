import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String senderId;
  String receiverId;
  String message;
  Timestamp timeStamp;
  Chat({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeStamp,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        message: json["message"],
        timeStamp: json["dateTime"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "message": message,
      "dateTime": timeStamp
    };
  }
}
