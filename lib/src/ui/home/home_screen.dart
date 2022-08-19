import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class HomeScreen extends StatelessWidget {
  final int indexNoti;
  const HomeScreen({Key? key, required this.indexNoti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: NewsColor.textWhite,
        centerTitle: true,
        title: Text(
          'HOME',
          style: NewsThemeData.fromContext(context).textAppBar,
        ),
      ),
    );
  }
}
