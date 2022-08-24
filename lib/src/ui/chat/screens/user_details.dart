import 'dart:convert';

import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  String image;
  String currentUserUid;
  String detailsUserUid;
  String userName;
  List<String> currentUserList;
  List<String> userNameFriends;
  UserDetails({
    Key? key,
    required this.image,
    required this.currentUserUid,
    required this.detailsUserUid,
    required this.userName,
    required this.currentUserList,
    required this.userNameFriends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size(50, 50), // Image radius
                child: Image.memory(
                  base64.decode(
                    image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (currentUserList.contains(detailsUserUid) == true &&
                userNameFriends.contains(currentUserUid) == true)
              Icon(Icons.done,color: Colors.green,)
            else if (currentUserList.contains(detailsUserUid) == false &&
                userNameFriends.contains(currentUserUid) == true)
              Icon(Icons.circle)
            else if(currentUserList.contains(detailsUserUid)== true && userNameFriends.contains(currentUserUid) ==false)
             ElevatedButton(child: const Text("Accept Request"),onPressed: () {
               
             },)
             else
               ElevatedButton(child: const Text("Add Friend"),onPressed: () {
               
             },)
          ]),
        ),
      ),
    );
  }
}
