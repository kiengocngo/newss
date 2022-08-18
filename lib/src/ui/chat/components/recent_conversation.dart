import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/src/components/constant.dart';

class RecentConversation extends StatelessWidget {
  const RecentConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size(50, 50), // Image radius
              child: Image.memory(
                base64.decode(
                  Constant.base64Image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const Text(
              "Hello",
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
