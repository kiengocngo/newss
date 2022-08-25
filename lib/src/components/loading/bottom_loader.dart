import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: NewsColor.button1,
      ),
    );
  }
}
