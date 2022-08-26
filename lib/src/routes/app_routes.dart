import 'package:flutter/material.dart';
import 'package:news_app/src/ui/favorite/favorite_screen.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/home/news/news_topic_screen.dart';
import 'package:news_app/src/ui/home/news/topic/load_more_screen.dart';
import 'package:news_app/src/ui/splash/splash_screen.dart';
import 'package:news_app/src/ui/splash/tutorial_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/home': (context) => const HomeScreen(),
    '/splash': (context) => const SplashScreen(),
    '/tutorial': (context) => const TutorialScreen(),
    '/news_topic': (context) => const NewsTopicScreen(),
<<<<<<< HEAD
    '/news_list': (context) => const LoadMoreScreen(),
=======
    '/favorite': (context) => const FavoriteScreen(),
>>>>>>> main
  };
}
