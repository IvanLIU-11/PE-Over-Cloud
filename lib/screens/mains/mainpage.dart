/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 20:45:09
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 14:46:06
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\mainpage.dart
 * @Description: 一个盒子，根据bottomnavigationbar切换内容
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:pe_over_cloud/widgets/PEOCBottomNavigarionBar.dart';
import 'package:pe_over_cloud/screens/allscreens.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    getgoodspage(), // 周边
    gethealthrecoverypage(), // 康复
    gethomepage(), // 首页
    gettrainingroompage(), // 训练房
    getuserinfopage() // 我的
  ];
  int _currentindex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentindex],
      bottomNavigationBar: PEOCBottomNavigationBar(
          ontap: (index) {
            setState(() {
              _currentindex = index;
            });
          },
          currentindex: _currentindex),
    );
  }
}
