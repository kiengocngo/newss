import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomeScreen(),
    '/detail_news': (context) => const DetailNewsScreen()
  };
}
