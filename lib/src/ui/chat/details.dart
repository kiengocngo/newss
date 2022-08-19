import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/responses/firebase_responses/firestore_responses.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/ui/chat/components/receiver_message.dart';
import 'package:news_app/src/ui/chat/components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  ScrollController _scrollController = ScrollController();
  String userUid;
  String friendUid;
  DetailsScreen({
    Key? key,
    required this.userUid,
    required this.friendUid,
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
                buildWhen: (previous, current) => previous!=current,
                builder: (context, state) {
                  
                  if (state.chatStatus == ChatStatus.loaded) {
                    return ListView.builder(
                      controller: widget._scrollController,
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          return SenderMessage(
                              sendMessage: state.chats[index].message);
                        } else {
                          return ReceiverMessage(
                              sendMessage: state.chats[index].message,
                              base64Image: Constant.base64Image);
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
                        FireStoreResponse().getChats("1", "2");
                        //tin moi nhat se duoc add vao conversations

                        context.read<ChatsBloc>().add(
                              ChatAddGetMessageEvent(
                                sender: "2",
                                receiver: "1",
                                message: _sendController.text,
                              ),
                            );

                        _sendController.clear();
                        setState(() {
                          widget._scrollController.jumpTo(widget
                              ._scrollController.position.maxScrollExtent);
                        });
                      },
                      icon: Icon(Icons.send)),
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
