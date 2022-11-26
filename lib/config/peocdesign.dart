//有关设计稿的信息
import 'dart:ui';
import 'package:flutter/material.dart';

class PEOCConfig {
  // ignore: constant_identifier_names
  static const String APPNAME = '云上体教';

  //设计稿长宽
  static const double DESIGNEDWIDTH = 375;
  static const double DESIGNEDHEIGHT = 812;

  //主题色
  static const Color THEMECOLOR = Color.fromRGBO(254, 112, 64, 1);

  //按传值生成primaryswatch
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
