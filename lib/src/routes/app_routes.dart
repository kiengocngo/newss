import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/news_topic_screen.dart';
import 'package:news_app/src/ui/splash/splash_screen.dart';
import 'package:news_app/src/ui/splash/tutorial_screen.dart';
import 'package:news_app/src/ui/chat/screens/conversation.dart';
import 'package:news_app/src/ui/chat/screens/enter_chat_room.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/conversations': (context) => const ConversationScreen(
          uid: "",
        ),
    "/enter_chat_room": (context) => EnterChatRoom(),
    '/home': (context) => const HomeScreen(),
    '/detail_news': (context) => const DetailNewsScreen(),
    '/splash': (context) => const SplashScreen(),
    '/tutorial': (context) => const TutorialScreen(),
    '/news_topic': (context) => const NewsTopicScreen(),
  };
}
