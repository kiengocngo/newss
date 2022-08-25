import 'package:flutter/material.dart';
import 'package:news_app/src/ui/home/news/topic/news_list.dart';

class LoadMoreScreen extends StatelessWidget {
  const LoadMoreScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NewsList(),
    );
  }
}
