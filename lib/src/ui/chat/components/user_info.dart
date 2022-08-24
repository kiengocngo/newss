import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/src/ui/chat/screens/user_details.dart';

import '../../../components/constant.dart';

class UserInfo extends StatelessWidget {
  String userName;
  String userImage;
  String userUid;
  String detailUserUid;
  UserInfo({
    Key? key,
    required this.userName,
    required this.userImage,
    required this.userUid,
    required this.detailUserUid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        log(userUid);
        context.read<FriendRequestBloc>().add(FriendRequestEventInit(
            firstUid: userUid, secondUid: detailUserUid));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(
                    currentUserUid: userUid,
                    detailsUserUid: detailUserUid,
                    userName: userName,
                    image: userImage,
                    currentUserList: [],
                    userNameFriends: [],
                    senderName: 'adsadá',
                    userImage: Constant.base64Image,
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
                detailUserUid,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
