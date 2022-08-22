
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
                buildWhen: (previous, current) {
                  return previous != current;
                },
                builder: (context, state) {
                  if (state.chatStatus == ChatStatus.loaded) {
                    bool showDate = true;
                    return ListView.builder(
                      reverse: false,
                      controller: widget._scrollController,
                      itemCount: state.chats.length,
                      itemBuilder: (context, index) {
                        if (state.chats[index].senderId == "1") {
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
                                senderId: "1",
                                receiverId: "2",
                                senderName: "qa1",
                                receiverName: "qa2",
                                senderImage: Constant.base64Image,
                                receiverImage: Constant.base64Image,
                                message: _sendController.text,
                                timestamp: Timestamp.now()));
                        context.read<ChatsBloc>().add(
                              ChatAddGetMessageEvent(
                                sender: "1",
                                receiver: "2",
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
