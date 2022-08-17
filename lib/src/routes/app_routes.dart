import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/home_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomeScreen(),
  };
}
