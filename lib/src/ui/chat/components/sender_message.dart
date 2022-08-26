import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SenderMessage extends StatelessWidget {
  final String sendMessage;
  final Timestamp timeStamp;
  const SenderMessage({
    Key? key,
    required this.sendMessage,
    required this.timeStamp,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.purple, Colors.blue]),
                    color: Colors.blue[300]),
                constraints: BoxConstraints(maxWidth: size.width * 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    sendMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                )),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.yMd().add_jm().format(timeStamp.toDate()),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
