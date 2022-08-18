import 'package:flutter/material.dart';
import 'package:news_app/src/ui/chat/conversation.dart';
import 'package:news_app/src/ui/chat/details.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {

    '/sign_up': (context) => SignUpMailPass(),
    '/add_info': (context) => SignUpScreen(
          args: const {},
        ),
    '/log_in': (context) => LoginScreen(),
    '/conversations': (context) => const ConversationScreen(),

    '/conversations': (context) => ConversationScreen(),
    '/details': (context) => DetailsScreen(userUid: "", friendUid: ""),
  };
}
