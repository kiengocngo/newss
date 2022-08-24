import 'package:flutter/material.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/chat/screens/conversation.dart';

class EnterChatRoom extends StatelessWidget {
  final _controller = TextEditingController();
  EnterChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter uid"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextInputField(
                text: "Enter user uid",
                type: TextInputType.text,
                prefixIcon: Icon(Icons.text_fields),
                controller: _controller),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConversationScreen(
                              uid: '0L2W03YyfVLauXtTJWLQ',
                            )),
                  );
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
