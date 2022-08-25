import 'package:cloud_firestore/cloud_firestore.dart';

class RecentConversation {
  String senderId;
  String receiverId;
  String senderName;
  String receiverName;
  String senderBase64Image;
  String receiverBase64Image;
  Timestamp dateTime;
  String message;
  RecentConversation({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderBase64Image,
    required this.receiverBase64Image,
    required this.dateTime,
    required this.message,
  });

  factory RecentConversation.fromJson(Map<String, dynamic> json) {
    return RecentConversation(
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        senderName: json["senderName"],
        receiverName: json["receiverName"],
        senderBase64Image: json["senderImage"],
        receiverBase64Image: json["receiverImage"],
        dateTime: json["dateTime"],
        message: json["message"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "senderName": senderName,
      "receiverName": receiverName,
      "senderBase64Image": senderBase64Image,
      'receiverBase64Image': receiverBase64Image,
      'dateTime': dateTime,
      'message': message,
    };
  }
}
