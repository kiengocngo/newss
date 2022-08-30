import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';
import 'package:news_app/theme/news_theme_data.dart';

class FavoriteItems extends StatelessWidget {
  final String category;
  final VoidCallback? onTap;
  const FavoriteItems({Key? key, required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: NewsColor.kGradient,
        ),
        child: Center(
            child: Text(
          category,
          style: NewsThemeData.fromContext(context).textHotNews,
        )),
      ),
    );
  }
}
