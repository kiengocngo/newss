

import 'package:flutter/material.dart';
import 'package:news_app/src/ui/chat/conversation.dart';
import 'package:news_app/src/ui/chat/details.dart';
import 'package:news_app/src/ui/login/login_screen.dart';
import 'package:news_app/src/ui/sign_up/sign_up_info.dart';
import 'package:news_app/src/ui/sign_up/sign_up_name_pass.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/sign_up': (context) => SignUpMailPass(),
    '/add_info': (context) => SignUpScreen(args: const {},),
    '/log_in': (context) => LoginScreen(),
    '/conversations': (context) => const ConversationScreen(),
    '/details':(context) =>DetailsScreen(userUid: "", friendUid: ""),
  };
}
