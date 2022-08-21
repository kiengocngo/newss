import 'package:cloud_firestore/cloud_firestore.dart';

class RecentConversation {
  String senderId;
  String receiverId;
  String senderName;
  String receiverName;
  String senderBase64Image;
  String receiverBase64Image;
  Timestamp timeStamp;
  String message;
  RecentConversation({
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderBase64Image,
    required this.receiverBase64Image,
    required this.timeStamp,
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
        timeStamp: json["dateTime"],
        message: json["message"]);
  }
}
