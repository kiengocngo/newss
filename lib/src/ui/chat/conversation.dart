import 'package:flutter/material.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/chat/components/recent_conversation.dart';

class ConversationScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          TextInputField(
              text: "Enter name here",
              type: TextInputType.text,
              prefixIcon: const Icon(Icons.search),
              controller: _searchController),
          RecentConversation(),
          RecentConversation(),
          RecentConversation(),
          RecentConversation(),
          RecentConversation(),
        ],
      ),
    );
  }
}
