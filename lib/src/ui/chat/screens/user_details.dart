import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';

class UserDetails extends StatelessWidget {
  String image;
  String senderName;
  String currentUserUid;
  String detailsUserUid;
  String userName;
  String userImage;
  List<String> currentUserList;
  List<String> userNameFriends;
  UserDetails({
    Key? key,
    required this.image,
  required  this.senderName ,
    required this.currentUserUid,
    required this.detailsUserUid,
    required this.userName,
  required  this.userImage ,
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
            Text(currentUserUid),
            Text(detailsUserUid),
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
            BlocBuilder<FriendRequestBloc, FriendRequestState>(
              builder: (context, state) {
                switch (state.status) {
                  case FriendState.noRequest:
                    return InkWell(
                      onTap: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                firstUid: currentUserUid,
                                secondUid: detailsUserUid));
                      },
                      child: Text("Add"),
                    );
                  case FriendState.firstRequest:
                    return Text("Request has sended");

                  case FriendState.seccondRequest:
                    return InkWell(
                      onTap: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                firstUid: currentUserUid,
                                secondUid: detailsUserUid));
                                context.read<ConversationsBloc>().add(
                          ConversationsAddNewMessage(
                              senderId: currentUserUid,
                              receiverId: detailsUserUid,
                              senderName: senderName,
                              receiverName: userName,
                              senderImage: userImage,
                              receiverImage: image,
                              message: "You guys are friends, have a a chat",
                              timestamp: Timestamp.now()));
                      },
                      child: Text("Accept ?"),
                    );
                  case FriendState.accept:
                    {
                      
                      return Text("you guys are friend");
                    }
                  default:
                    return Icon(Icons.error);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
