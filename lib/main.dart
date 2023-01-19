/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-24 22:31:38
 * @LastEditTime: 2023-01-18 20:53:02
 * @Descripttion: 
 */

/*
 * @Author: YJR-1100
 * @Date: 2022-11-24 22:34:27
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-27 14:44:43
 * @FilePath: \PE-Over-Cloud\Client\lib\main.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/peocdesign.dart';
import 'package:get/get.dart';
import 'router/router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //设置状态栏颜色,本是灰色，现在完全为沉浸式
    statusBarColor: Colors.transparent,
  ));
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
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
        primarySwatch: PEOCConfig.createMaterialColor(PEOCConfig.THEMECOLOR),
        primaryColor: PEOCConfig.THEMECOLOR,
      ),
    );
  }
}
