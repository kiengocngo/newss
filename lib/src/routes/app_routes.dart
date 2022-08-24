import 'package:flutter/material.dart';
import 'package:news_app/src/ui/chat/screens/conversation.dart';
import 'package:news_app/src/ui/chat/screens/details.dart';
import 'package:news_app/src/ui/chat/screens/enter_chat_room.dart';
import 'package:news_app/src/ui/chat/screens/friend_search.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/conversations': (context) => const ConversationScreen(
          uid: "",
        ),
    '/details': (context) => DetailsScreen(
          userUid: "",
          friendUid: "",
          friendImage: '',
          friendName: '',
          userImage: '',
          userName: '',
        ),
    "/friends_search": (context) => FriendSearch(
          uid: "",
        ),
    "/enter_chat_room": (context) => EnterChatRoom(),
  };
}
