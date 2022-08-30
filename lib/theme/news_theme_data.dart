import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class NewsThemeData {
  NewsThemeData();

  late TextStyle textAppBar;
  late TextStyle textSetting;

  factory NewsThemeData.fromContext(BuildContext context) {
    final NewsThemeData theme = NewsThemeData();
    theme.textAppBar = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: NewsColor.textBlack,
    );
    theme.textSetting = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: NewsColor.textBlack,
    );
    return theme;
  }
}
