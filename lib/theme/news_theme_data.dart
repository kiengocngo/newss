import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class NewsThemeData {
  NewsThemeData();

  late TextStyle textAppBar;
  late TextStyle textNewsTitle;
  late TextStyle textHotNews;
  late TextStyle textDescription;
  late TextStyle textButton;
  late TextStyle textSetting;
  late TextStyle textAuth;
  late TextStyle textNameChat;
  late TextStyle textButtonDialog;
  late TextStyle textTutorial;

  factory NewsThemeData.fromContext(BuildContext context) {
    final NewsThemeData theme = NewsThemeData();
    theme.textAppBar = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: NewsColor.textBlack,
    );
    theme.textNewsTitle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: NewsColor.textBlack,
    );
    theme.textHotNews = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: NewsColor.textWhite,
    );
    theme.textDescription = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: NewsColor.textBlack,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      decorationColor: Colors.green,
      letterSpacing: 0.5,
    );
    theme.textButton = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: NewsColor.textWhite,
      fontStyle: FontStyle.normal,
    );
    theme.textSetting = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: NewsColor.textBlack,
    );
    theme.textAuth = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 15,
      fontStyle: FontStyle.normal,
      color: NewsColor.textBlack,
    );
    theme.textAuth = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      color: NewsColor.textBlack,
    );
    theme.textTutorial = const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Color.fromARGB(255, 36, 210, 94),
      fontStyle: FontStyle.italic,
    );
    return theme;
  }
}
