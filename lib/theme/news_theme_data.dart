import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class NewsThemeData {
  NewsThemeData();

  late TextStyle textAppBar;
  late TextStyle textSettings;
  late TextStyle textTButton;

  factory NewsThemeData.fromContext(BuildContext context) {
    final NewsThemeData theme = NewsThemeData();
    theme.textAppBar = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: NewsColor.textBlack,
    );
    theme.textSettings = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: NewsColor.textBlack,
    );
    theme.textTButton = const TextStyle(
      fontSize: 14,
      color: NewsColor.textBlack,
      fontWeight: FontWeight.normal,
    );
    return theme;
  }
}
