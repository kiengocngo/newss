import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/src/ui/chat/screens/friend_search.dart';
import '../../../../blocs/conversations_bloc/conversations_bloc.dart';
import '../components/recent_conversation.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ConversationsBloc>().add(ConversationSubmit(
        currentUser: context.read<LogInBloc>().state.message));
    String uid = context.read<LogInBloc>().state.message;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FriendSearch(uid: uid)));
                  },
                  child: Container(
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.red,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Find your friend",
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      )
                    ]),
                  ),
                ),
              ),
              BlocBuilder<ConversationsBloc, ConversationsState>(
                builder: (context, state) {
                  return SizedBox(
                    height: size.height * 0.7,
                    child: ListView.builder(
                      itemCount: state.conversations.length,
                      itemBuilder: ((context, index) {
                        return RecentConversationScreen(
                          senderId: uid,
                          receiverId: state.currentUser ==
                                  state.conversations[index].senderId
                              ? state.conversations[index].receiverId
                              : state.conversations[index].senderId,
                          conversationsUserName: state.currentUser ==
                                  state.conversations[index].senderId
                              ? state.conversations[index].receiverName
                              : state.conversations[index].senderName,
                          userImage: state.currentUser ==
                                  state.conversations[index].senderId
                              ? state.conversations[index].receiverBase64Image
                              : state.conversations[index].senderBase64Image,
                          message: state.conversations[index].message,
                        );
                      }),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
