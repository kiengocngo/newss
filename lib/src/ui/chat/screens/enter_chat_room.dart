import 'package:flutter/material.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/chat/screens/conversation.dart';

Map<String, String> userMap = {
  "1": "cZRLuMBnsdRkfPBOaIcKfI8sZBi1",
  "2": "wRfJLxGkvUSooyVfzRDGI8TQDsy2",
  "3": "6Is7Y6uNqIU2TuFd8bGC36fgtTg1",
};

class EnterChatRoom extends StatelessWidget {
  final _controller = TextEditingController();
  EnterChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter uid"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextInputField(
                text: "Enter user uid",
                type: TextInputType.text,
                prefixIcon: const Icon(Icons.text_fields),
                controller: _controller),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConversationScreen(
                              uid: userMap[_controller.text] ?? "no user",
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
