/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 20:45:09
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-02 21:28:03
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\mainpage.dart
 * @Description: 一个盒子，根据bottomnavigationbar切换内容
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:pe_over_cloud/widgets/PECOBottomNavigarionBar.dart';
import 'package:pe_over_cloud/screens/allscreens.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    getgoodspage(), // 周边
    getsocialpage(), // 圈子
    gethomepage(), // 首页
    gethealthrecoverypage(), // 康复
    getuserinfopage() // 我的
  ];
  int _currentindex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentindex],
      bottomNavigationBar: PECOBottomNavigationBar(
          ontap: (index) {
            setState(() {
              _currentindex = index;
            });
          },
          currentindex: _currentindex),
    );
  }
}
