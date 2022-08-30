import 'package:cloud_firestore/cloud_firestore.dart';

class RecentConversation {
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String senderBase64Image;
  final String receiverBase64Image;
  final Timestamp dateTime;
  final String message;
  const RecentConversation({
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
        senderId: json["senderId"] ?? "null",
        receiverId: json["receiverId"] ?? "null",
        senderName: json["senderName"] ?? "null",
        receiverName: json["receiverName"] ?? "null",
        senderBase64Image: json["senderBase64Image"] ?? "null",
        receiverBase64Image: json["receiverBase64Image"] ?? "null",
        dateTime: json["dateTime"] ?? Timestamp.now(),
        message: json["message"] ?? "null");
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
