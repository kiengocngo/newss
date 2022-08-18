import 'package:flutter/material.dart';

import '../../components/constant.dart';
import 'components/receiver_message.dart';
import 'components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  final TextEditingController _sendController = TextEditingController();
  String userUid;
  String friendUid;
  DetailsScreen({
    Key? key,
    required this.userUid,
    required this.friendUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.75,
              child: ListView(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _sendController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                enableInteractiveSelection: false,
                obscureText: false,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                  fillColor: Colors.grey,
                  contentPadding: const EdgeInsets.only(left: 4),
                  hintText: "type here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
