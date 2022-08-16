import 'package:flutter/material.dart';
import 'package:news_app/src/ui/chat/details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: DetailsScreen(
        userUid: '',
        friendUid: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
