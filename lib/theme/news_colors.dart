import 'package:flutter/material.dart';

class NewsColor {
  NewsColor._();

  //text
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);
  //background

  //gradient

  static const LinearGradient tuGradient = LinearGradient(
      colors: [
        Color(0xFF3366FF),
        Color(0xFF00CCFF),
      ],
      begin: FractionalOffset(0.0, 0.0),
      end: FractionalOffset(1.0, 0.0),
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
  static const Color newsGrey = Color.fromARGB(255, 103, 101, 101);
}
