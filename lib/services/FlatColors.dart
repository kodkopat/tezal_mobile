import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:ui' show Color;

import 'package:flutter/painting.dart';

class FlatColors {
  static const Color orange_light = Color.fromRGBO(243, 156, 18, 1);
  static const Color orange_dark = Color.fromRGBO(211, 84, 0, 1);

  static const Color grey_light = Color.fromRGBO(248, 249, 250, 1);
  static const Color grey_dark = Color.fromRGBO(127, 140, 141, 1);

  static const Color midnight_light = Color.fromRGBO(52, 73, 94, 1);
  static const Color midnight_dark = Color.fromRGBO(44, 62, 80, 1);

  static const Color blue_light = Color.fromRGBO(52, 152, 219, 1);
  static const Color blue_dark = Color.fromRGBO(41, 128, 185, 1);

  static const Color green_light = Color.fromRGBO(46, 204, 113, 1);
  static const Color green_dark = Color.fromRGBO(39, 174, 96, 1);

  static const Color red_light = Color.fromRGBO(231, 76, 60, 1);
  static const Color red_dark = Color.fromRGBO(192, 57, 43, 1);

  static const Color pink_light = Color.fromRGBO(253, 121, 168, 1);
  static const Color pink_dark = Color.fromRGBO(232, 67, 147, 1);

  static const Color white_light = Color.fromRGBO(245, 246, 250, 1);
  static const Color background1 = Color.fromRGBO(248, 249, 250, 1);
  static MaterialColor toMaterialColor(Color color) {
    Map<int, Color> colorCodes = {
      100: Color.fromRGBO(color.red, color.green, color.blue, 1),
    };
    return MaterialColor(color.value, colorCodes);
  }
}
