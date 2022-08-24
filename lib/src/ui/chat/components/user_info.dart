import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/src/ui/chat/screens/user_details.dart';

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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(
                    currentUserUid: "0L2W03YyfVLauXtTJWLQ",
                    detailsUserUid: "",
                    userName: userName,
                    image: userImage,
                    currentUserList: [],
                    userNameFriends: [],
                  )),
        );
      },
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
          BlocBuilder<FriendRequestBloc, FriendRequestState>(
            builder: (context, state) {
              return Text(
                userName,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
