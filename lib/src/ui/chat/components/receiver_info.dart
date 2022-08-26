import 'dart:convert';

import 'package:flutter/material.dart';

class ReceiverInfo extends StatelessWidget {
  final String friendImage;
  final String friendName;
  const ReceiverInfo({
    Key? key,
    required this.friendImage,
    required this.friendName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Column(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size(100, 100), // Image radius
                child: Image.memory(
                  base64.decode(
                    friendImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              friendName,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
