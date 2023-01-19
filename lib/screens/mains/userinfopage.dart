/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 20:47:26
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-02 20:49:00
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\userinfopage.dart
 * @Description: 我的页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class UserinfoPage extends StatefulWidget {
  const UserinfoPage({super.key});

  @override
  State<UserinfoPage> createState() => _UserinfoPageState();
}

class _UserinfoPageState extends State<UserinfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("我的页面"),
    );
  }
}
