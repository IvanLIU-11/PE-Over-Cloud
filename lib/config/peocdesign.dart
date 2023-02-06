/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-24 22:31:38
 * @LastEditTime: 2023-02-06 17:29:47
 * @Descripttion: 
 */
//有关设计稿的信息
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pe_over_cloud/utilities/storage.dart';

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
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static const String SERVERIP = "47.110.82.236:8080";

  static Dio dio = Dio(BaseOptions(
    baseUrl: 'http://47.110.82.236:8080',
    headers: {
      "content-type": "application/json",
      'accept': '*/*',
      'accept-language': 'zh-CN',
      'accept-encoding': 'gzip,deflate,br',
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ));
}
