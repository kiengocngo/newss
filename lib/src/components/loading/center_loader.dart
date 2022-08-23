import 'package:flutter/material.dart';
import 'package:news_app/theme/news_colors.dart';

class CenterLoader extends StatelessWidget {
  const CenterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5, color: NewsColor.button1,),
      ),
    );
  }
}
