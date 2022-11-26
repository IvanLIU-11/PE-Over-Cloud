/*
 * @Author: YJR-1100
 * @Date: 2022-11-24 22:34:27
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 21:07:30
 * @FilePath: \PE-Over-Cloud\Client\lib\main.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'config/peocdesign.dart';
import 'package:get/get.dart';
import 'router/router.dart';

void main() {
// 设计图尺寸
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: namedPages,
      title: PEOCConfig.APPNAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: PEOCConfig.createMaterialColor(PEOCConfig.THEMECOLOR),
        primaryColor: PEOCConfig.THEMECOLOR,
      ),
    );
  }
}
