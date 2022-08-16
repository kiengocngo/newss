import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/src/components/constant.dart';

// ignore: must_be_immutable
class ReceiverMessage extends StatelessWidget {
  String sendMessage;
  String base64Image;
  ReceiverMessage({
    Key? key,
    required this.sendMessage,
    required this.base64Image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size(15, 15), // Image radius
                  child: Image.memory(
                    base64.decode(
                      Constant.base64Image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.blue[300]),
                    constraints: BoxConstraints(maxWidth: size.width * 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(sendMessage),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
