import 'dart:convert';

import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  String userName;
  String userImage;
  UserInfo({
    Key? key,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size(50, 50), // Image radius
              child: Image.memory(
                base64.decode(
                  userImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              userName,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
