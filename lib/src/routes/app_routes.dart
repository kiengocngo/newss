import 'package:flutter/material.dart';
import 'package:news_app/src/ui/bottom_navigator/bottom_navigator_screen.dart';
import 'package:news_app/src/ui/home/home_screen.dart';
import 'package:news_app/src/ui/home/news/detail_news_screen.dart';
import 'package:news_app/src/ui/home/news/news_topic_screen.dart';

import 'package:news_app/src/ui/login/login_screen.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';
import 'package:news_app/src/ui/sign_up/sign_up_info.dart';
import 'package:news_app/src/ui/sign_up/sign_up_name_pass.dart';
import 'package:news_app/src/ui/splash/splash_screen.dart';
import 'package:news_app/src/ui/splash/tutorial_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/sign_up': (context) => SignUpMailPass(),
    '/add_info': (context) => SignUpScreen(
          args: const {},
        ),
    '/log_in': (context) => LoginScreen(),
    '/home': (context) => const HomeScreen(),
    '/detail_news': (context) => const DetailNewsScreen(),
    '/splash': (context) => const SplashScreen(),
    '/tutorial': (context) => const TutorialScreen(),
    '/news_topic': (context) => const NewsTopicScreen(),
    'settings': ((context) => const SettingsScreen()),
    '/login': (context) => LoginScreen(),
    '/bottom': (context) => const MainScreen(),
  };
}
