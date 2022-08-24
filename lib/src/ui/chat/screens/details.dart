import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/ui/chat/components/receiver_message.dart';
import 'package:news_app/src/ui/chat/components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  final ScrollController _scrollController = ScrollController();
  String userUid;
  String friendUid;
  String userName;
  String friendName;
  String userImage;
  String friendImage;
  DetailsScreen({
    Key? key,
    required this.userUid,
    required this.friendUid,
    required this.userName,
    required this.friendName,
    required this.userImage,
    required this.friendImage,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController _sendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log(widget.userUid);
    log(widget.friendUid);
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
                  if (state.chatStatus == ChatStatus.loaded) {
                    return ListView.builder(
                      reverse: false,
                      controller: widget._scrollController,
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) {
                        if (state.chats[index].senderId == widget.userUid) {
                          {
                            return Column(
                              children: [
                                SenderMessage(
                                    sendMessage: state.chats[index].message),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    DateFormat.yMd().add_jm().format(
                                        state.chats[index].timeStamp.toDate()),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Column(
                            children: [
                              Text(
                                DateFormat.yMd().add_jm().format(
                                    state.chats[index].timeStamp.toDate()),
                                style: const TextStyle(color: Colors.white),
                              ),
                              ReceiverMessage(
                                  sendMessage: state.chats[index].message,
                                  base64Image: Constant.base64Image),
                            ],
                          );
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

                        context.read<ConversationsBloc>().add(
                            ConversationsAddNewMessage(
                                senderId: widget.userUid,
                                receiverId: widget.friendUid,
                                senderName: widget.userName,
                                receiverName: widget.friendName,
                                senderImage: widget.userImage,
                                receiverImage: widget.friendImage,
                                message: _sendController.text,
                                timestamp: Timestamp.now()));
                        context.read<ChatsBloc>().add(
                              ChatAddGetMessageEvent(
                                sender: widget.userUid,
                                receiver: widget.friendUid,
                                message: _sendController.text,
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
