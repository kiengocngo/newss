import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class NewsThemeData {
  NewsThemeData();

  late TextStyle textAppBar;
  late TextStyle textNewsTitle;
  late TextStyle textHotNews;
  late TextStyle textDescription;

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
    return theme;
  }
}
