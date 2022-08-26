import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ReceiverMessage extends StatelessWidget {
final  String sendMessage;
 final   String base64Image;
 final   Timestamp timestamp;
const  ReceiverMessage({
    Key? key,
    required this.timestamp,
    required this.sendMessage,
    required this.base64Image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Text(
              DateFormat.yMd().add_jm().format(timestamp.toDate()),
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size(15, 15), // Image radius
                      child: Image.memory(
                        base64.decode(
                          base64Image,
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
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color: Colors.grey),
                        constraints: BoxConstraints(maxWidth: size.width * 0.8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sendMessage,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
