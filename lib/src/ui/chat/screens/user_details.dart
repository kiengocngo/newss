import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/blocs/friend_request_bloc/friend_request_bloc.dart';
import 'package:news_app/src/models/chats/recent_conversation.dart';
import 'package:news_app/src/models/chats/user_details_screen_model.dart';

class UserDetails extends StatelessWidget {
  final UserDetailsModel userDetailsModel;
  const UserDetails({
    Key? key,
    required this.userDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          userDetailsModel.detailsUserName,
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
                    userDetailsModel.detailsUserImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              userDetailsModel.detailsUserName,
              style: const TextStyle(fontSize: 30, color: Colors.white),
            ),
            BlocBuilder<FriendRequestBloc, FriendRequestState>(
              builder: (context, state) {
                switch (state.status) {
                  case FriendState.noRequest:
                    return ElevatedButton(
                        onPressed: () {
                          context.read<FriendRequestBloc>().add(
                              FriendRequestEventSubmit(
                                  currentUserUid:
                                      userDetailsModel.currentUserUid,
                                  targetUserUid:
                                      userDetailsModel.detailsUserUid));
                        },
                        child: const Text(
                          "Add to friend list",
                        ));
                  case FriendState.firstRequest:
                    return const Text(
                      "Request has sended",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    );

                  case FriendState.seccondRequest:
                    return ElevatedButton(
                      onPressed: () {
                        context.read<FriendRequestBloc>().add(
                            FriendRequestEventSubmit(
                                currentUserUid: userDetailsModel.currentUserUid,
                                targetUserUid:
                                    userDetailsModel.detailsUserUid));
                        context
                            .read<ConversationsBloc>()
                            .add(ConversationsAddNewMessage(
                              recentConversation: RecentConversation(
                                  senderId: userDetailsModel.currentUserUid,
                                  receiverId: userDetailsModel.detailsUserUid,
                                  senderName: userDetailsModel.currentUserName,
                                  receiverName:
                                      userDetailsModel.detailsUserName,
                                  senderBase64Image: userDetailsModel.image,
                                  receiverBase64Image:
                                      userDetailsModel.detailsUserImage,
                                  message: "You guys are friends, have a chat",
                                  dateTime: Timestamp.now()),
                            ));
                      },
                      child: const Text(
                        "Accept ?",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    );
                  case FriendState.accept:
                    {
                      return const Text(
                        "you guys are friend",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      );
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
