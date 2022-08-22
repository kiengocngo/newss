import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/src/components/constant.dart';
import '../../../blocs/conversations_bloc/conversations_bloc.dart';
import 'components/recent_conversation.dart';

class ConversationScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ConversationsBloc>().add(ConversationSubmit(currentUser: "1"));
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
              TextFormField(
                controller: _searchController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                enableInteractiveSelection: false,
                obscureText: false,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.only(left: 4),
                  hintText: "Find a friend",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
                        return RecentConversation(
                          conversationsUserName: state.conversations[index].receiverId,
                          userImage: state.conversations[index].receiverBase64Image,
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
