// todo routes manager
import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/splash/splash_screen.dart';
import 'package:news_app/src/ui/splash/tutorial_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/splash': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/tutorial': (context) => const TutorialScreen(),
  };
}
