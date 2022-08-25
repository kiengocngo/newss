import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/chat.dart';
import 'package:news_app/src/models/details_screen_model.dart';
import 'package:news_app/src/models/recent_conversation.dart';
import 'package:news_app/src/ui/chat/components/receiver_message.dart';
import 'package:news_app/src/ui/chat/components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  DetailsModel detailsModel;
  DetailsScreen({
    Key? key,
    required this.detailsModel,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _sendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.75,
              child: BlocBuilder<ChatsBloc, ChatsState>(
                buildWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, state) {
                  if (state.chatStatus == CustomStatus.loaded) {
                    return ListView.builder(
                      reverse: false,
                      controller: widget._scrollController,
                      itemCount: state.chats.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Center(
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: SizedBox.fromSize(
                                      size:
                                          const Size(100, 100), // Image radius
                                      child: Image.memory(
                                        base64.decode(
                                          widget.detailsModel.friendImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    widget.detailsModel. friendName,
                                    style: const TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          if (state.chats[index - 1].senderId ==
                              widget.detailsModel. userUid) {
                            {
                              return SenderMessage(
                                  timeStamp: state.chats[index - 1].timeStamp,
                                  sendMessage: state.chats[index - 1].message);
                            }
                          } else {
                            return Column(
                              children: [
                                Text(
                                  DateFormat.yMd().add_jm().format(state
                                      .chats[index - 1].timeStamp
                                      .toDate()),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                ReceiverMessage(
                                    sendMessage: state.chats[index - 1].message,
                                    base64Image: Constant.base64Image),
                              ],
                            );
                          }
                        }
                      },
                    );
                  } else {
                    return Text(state.chats.toString());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _sendController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                enableInteractiveSelection: false,
                obscureText: false,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(
                      onPressed: () {
                        //tin moi nhat se duoc add vao conversations

                        context
                            .read<ConversationsBloc>()
                            .add(ConversationsAddNewMessage(
                                recentConversation: RecentConversation(
                              senderId: widget.detailsModel.userUid,
                              receiverId:widget.detailsModel.friendUid,
                              senderName: widget.detailsModel.userName,
                              receiverName: widget.detailsModel.friendName,
                              senderBase64Image:widget.detailsModel.userImage,
                              receiverBase64Image: widget.detailsModel.friendImage,
                              message: _sendController.text,
                              dateTime: Timestamp.now(),
                            )));
                        context.read<ChatsBloc>().add(
                              ChatAddGetMessageEvent(
                                chat: Chat(
                                    senderId: widget.detailsModel.userUid,
                                    receiverId: widget.detailsModel.friendUid,
                                    message: _sendController.text,
                                    timeStamp: Timestamp.now()),
                              ),
                            );

                        _sendController.clear();
                        setState(() {
                          widget._scrollController.jumpTo(widget
                              ._scrollController.position.maxScrollExtent);
                        });
                      },
                      icon: const Icon(Icons.send)),
                  fillColor: Colors.grey,
                  contentPadding: const EdgeInsets.only(left: 4),
                  hintText: "type here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
