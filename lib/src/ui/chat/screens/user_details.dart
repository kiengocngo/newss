import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';

// ignore: must_be_immutable
class UserDetails extends StatelessWidget {
  String image;
  String currentUserName;
  String currentUserUid;
  String detailsUserUid;
  String detailsUserName;
  String detailsUserImage;

  UserDetails({
    Key? key,
    required this.image,
    required this.currentUserName,
    required this.currentUserUid,
    required this.detailsUserUid,
    required this.detailsUserName,
    required this.detailsUserImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          detailsUserName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size(100, 100), // Image radius
                child: Image.memory(
                  base64.decode(
                    detailsUserImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              detailsUserName,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            BlocBuilder<FriendRequestBloc, FriendRequestState>(
              builder: (context, state) {
                switch (state.status) {
                  case FriendState.noRequest:
                    return ElevatedButton(
                        onPressed: () {
                          log(currentUserUid);
                          log(detailsUserUid);
                          context.read<FriendRequestBloc>().add(
                              FriendRequestEventSubmit(
                                  firstUid: currentUserUid,
                                  secondUid: detailsUserUid));
                        },
                        child: const Text("Add"));
                  case FriendState.firstRequest:
                    return const Text("Request has sended");

                  case FriendState.seccondRequest:
                    return ElevatedButton(
                      onPressed: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                firstUid: currentUserUid,
                                secondUid: detailsUserUid));
                        context.read<ConversationsBloc>().add(
                            ConversationsAddNewMessage(
                                senderId: currentUserUid,
                                receiverId: detailsUserUid,
                                senderName: currentUserName,
                                receiverName: detailsUserName,
                                senderImage: image,
                                receiverImage: detailsUserImage,
                                message: "You guys are friends, have a chat",
                                timestamp: Timestamp.now()));
                      },
                      child: const Text("Accept ?"),
                    );
                  case FriendState.accept:
                    {
                      return const Text("you guys are friend");
                    }
                  default:
                    return const Icon(Icons.error);
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
