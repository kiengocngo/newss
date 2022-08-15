import 'package:flutter/material.dart';
import 'package:news_app/src/ui/bottom_navigator/bottom_navigator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const BottomNavigationScreen(),
    );
  }
}
