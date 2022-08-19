class Chat {
  String senderId;
  String receiverId;

  String message;
  Chat({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toMap() {
    return {"senderId": senderId, "receiverId": receiverId, "message": message};
  }
}
