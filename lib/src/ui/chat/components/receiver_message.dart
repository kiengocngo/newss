import 'dart:convert';

import 'package:flutter/material.dart';

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
          children: [
            CircleAvatar(
              radius: 15,
              // ignore: unnecessary_null_comparison
              backgroundImage: 1 != 0 ? Image.network(
                      "https://vi.wikipedia.org/wiki/Lionel_Messi",
                      fit: BoxFit.cover,
                    ) 
                    as ImageProvider: Image.network(
                      "https://vi.wikipedia.org/wiki/Lionel_Messi",
                      fit: BoxFit.cover,
                    ) as ImageProvider

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
