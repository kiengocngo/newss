import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ReceiverMessage extends StatelessWidget {
  final String sendMessage;
  final String base64Image;
  final Timestamp timestamp;
  const ReceiverMessage({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMd().add_jm().format(timestamp.toDate()),
              style: const TextStyle(color: Colors.black),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size(30, 30), // Image radius
                    child: Image.memory(
                      base64.decode(
                        base64Image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6.0,
                ),
                Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        color: Color.fromARGB(255, 66, 64, 64)),
                    constraints: BoxConstraints(maxWidth: size.width * 0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sendMessage,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
