/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-24 22:31:38
 * @LastEditTime: 2023-02-06 23:46:25
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pe_over_cloud/utilities/user.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ///

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


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     ///将这段文字放置在MyApp 页面的Builder下
//     ///
//     ScreenUtil.init(
//       context,
//       designSize: const Size(
//           PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
//     );
//     return GetMaterialApp(
//       initialRoute: '/main',
//       getPages: namedPages,
//       title: PEOCConfig.APPNAME,
//       debugShowCheckedModeBanner: false,
//       builder: FlutterSmartDialog.init(),
//       theme: ThemeData(
//         primarySwatch: PEOCConfig.createMaterialColor(PEOCConfig.THEMECOLOR),
//         primaryColor: PEOCConfig.THEMECOLOR,
//       ),
//     );
//   }
// }
