import 'package:flutter/material.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/ui/chat/components/receiver_message.dart';
import 'package:news_app/src/ui/chat/components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  String userUid;
  String friendUid;
  DetailsScreen({
    Key? key,
    required this.userUid,
    required this.friendUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SenderMessage(sendMessage: "Hello Im Quoc Anh"),
            SenderMessage(sendMessage: "Hello Im Quoc Anh"),
            SenderMessage(
                sendMessage:
                    "Hello Im Quoc Anh,3123sadasdawe131312323123edasdsafgeww42134123213sadase12312dsadasda"),
            SenderMessage(sendMessage: "Hello Im Quoc Anh"),
            SenderMessage(sendMessage: "Hello Im Quoc Anh"),
            SenderMessage(sendMessage: "Hello Im Quoc Anh"),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
            ReceiverMessage(
                sendMessage: "Hello", base64Image: Constant.base64Image),
          ],
        ),
      ),
    );
  }
}
