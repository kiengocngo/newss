// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';

import '../../../components/constant.dart';

class RecentConversation extends StatelessWidget {
  const RecentConversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          FireStoreService().getUserByName("weqwe");
          Navigator.pushNamed(context, "/details");
        },
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
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Name",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Hello, this is a very long text that cant be display in screen, please click into detailssdasdasdasdasdasdasdasdasda",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
