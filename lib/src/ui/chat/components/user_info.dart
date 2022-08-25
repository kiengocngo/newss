// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/services/firebase_services/firestore_services.dart';
import 'package:news_app/src/ui/chat/screens/user_details.dart';

// ignore: must_be_immutable
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
      onTap: () async {
        context.read<FriendRequestBloc>().add(FriendRequestEventInit(
            firstUid: userUid, secondUid: detailUserUid));
        final tmp = await FireStoreService().getUserByUid(userUid);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(
                    currentUserUid: userUid,
                    image: tmp.data[0].base64Image,
                    currentUserName: tmp.data[0].name,
                    detailsUserUid: detailUserUid,
                    detailsUserImage: userImage,
                    detailsUserName: userName,
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
