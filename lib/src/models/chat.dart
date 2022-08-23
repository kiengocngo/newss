class Chat {
  String senderId;
  String receiverId;
  String dateTime;
  String message;
  Chat({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.message,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      dateTime: json["dateTime"],
      message: json["message"],
    );
  }

  Map<String, String> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "message": message
    };
  }
}
