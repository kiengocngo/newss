// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/src/models/details_screen_model.dart';
import 'package:news_app/src/ui/chat/screens/details.dart';

import '../../../../services/firebase_services/firestore_services.dart';

// ignore: must_be_immutable
class RecentConversationScreen extends StatelessWidget {
  String userImage;
  String senderId;
  String receiverId;
  String message;
  String conversationsUserName;
  RecentConversationScreen({
    Key? key,
    required this.userImage,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.conversationsUserName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocListener<ChatsBloc, ChatsState>(
        listener: (context, state) {},
        child: InkWell(
          onTap: () async {
            var tmp = await FireStoreService().getUserByUid(senderId);

            // ignore: use_build_context_synchronously
            context
                .read<ChatsBloc>()
                .add(ChatInitEvent(senderId: senderId, receiverId: receiverId));
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        detailsModel: DetailsModel(
                          userUid: senderId,
                          friendUid: receiverId,
                          userName: tmp.data[0].name,
                          friendName: conversationsUserName,
                          friendImage: userImage,
                          userImage: tmp.data[0].base64Image,
                        ),
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            conversationsUserName,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        message,
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
