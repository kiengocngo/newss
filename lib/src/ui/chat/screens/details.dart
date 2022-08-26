import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/blocs/chats_bloc/chats_bloc.dart';
import 'package:news_app/blocs/conversations_bloc/conversations_bloc.dart';
import 'package:news_app/src/components/constant.dart';
import 'package:news_app/src/models/chat.dart';
import 'package:news_app/src/models/details_screen_model.dart';
import 'package:news_app/src/models/recent_conversation.dart';
import 'package:news_app/src/ui/chat/components/receiver_info.dart';
import 'package:news_app/src/ui/chat/components/receiver_message.dart';
import 'package:news_app/src/ui/chat/components/sender_message.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
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
  final ScrollController _scrollController = ScrollController();

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
                  switch (state.chatStatus) {
                    case CustomStatus.loading:
                      return const SpinKitFadingCircle(
                        color: Colors.blue,
                        size: 50.0,
                      );

                    case CustomStatus.loaded:
                      return ListView.builder(
                        reverse: false,
                        controller: _scrollController,
                        itemCount: state.chats.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // index  = 0 --> render ra avatar + ten user
                            return ReceiverInfo(
                                friendImage: widget.detailsModel.friendImage,
                                friendName: widget.detailsModel.friendName);
                          } else {
                            if (state.chats[index - 1].senderId ==
                                widget.detailsModel.userUid) {
                              {
                                //sender message
                                return SenderMessage(
                                    timeStamp: state.chats[index - 1].timeStamp,
                                    sendMessage:
                                        state.chats[index - 1].message);
                              }
                            } else {
                              //receiver message
                              return ReceiverMessage(
                                  timestamp: state.chats[index - 1].timeStamp,
                                  sendMessage: state.chats[index - 1].message,
                                  base64Image: Constant.base64Image);
                            }
                          }
                        },
                      );
                    default:
                      return const Icon(
                        Icons.error,
                        color: Colors.white,
                      );
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
                        _addConversation(context);
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

  _addConversation(BuildContext context) {
    final RecentConversation recentConversation = RecentConversation(
      senderId: widget.detailsModel.userUid,
      receiverId: widget.detailsModel.friendUid,
      senderName: widget.detailsModel.userName,
      receiverName: widget.detailsModel.friendName,
      senderBase64Image: widget.detailsModel.userImage,
      receiverBase64Image: widget.detailsModel.friendImage,
      message: _sendController.text,
      dateTime: Timestamp.now(),
    );
    //tin moi nhat se duoc add vao conversation
    context.read<ConversationsBloc>().add(
        ConversationsAddNewMessage(recentConversation: recentConversation));
    final Chat chat = Chat(
        senderId: widget.detailsModel.userUid,
        receiverId: widget.detailsModel.friendUid,
        message: _sendController.text,
        timeStamp: Timestamp.now());
    context.read<ChatsBloc>().add(
          ChatAddGetMessageEvent(chat: chat),
        );

    _sendController.clear();
    setState(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }
}
