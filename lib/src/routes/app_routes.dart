import 'package:flutter/material.dart';
import 'package:news_app/src/ui/chat/conversation.dart';
import 'package:news_app/src/ui/chat/details.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/conversations': (context) => ConversationScreen(),
    '/details': (context) => DetailsScreen(userUid: "", friendUid: ""),
  };
}
