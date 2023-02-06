/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 19:58:54
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 12:15:12
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCBottomNavigarionBar.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PEOCBottomNavigationBar extends StatefulWidget {
  Function(int) ontap;
  int currentindex;
  PEOCBottomNavigationBar(
      {super.key, required this.ontap, required this.currentindex});
  @override
  State<PEOCBottomNavigationBar> createState() =>
      _PEOCBottomNavigationBarState();
}

class _PEOCBottomNavigationBarState extends State<PEOCBottomNavigationBar> {
  _PEOCBottomNavigationBarState();
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.h),
      child: BottomNavigationBar(
          onTap: widget.ontap,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.currentindex,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0.0, // 去掉阴影
          unselectedFontSize: 10.sp,
          selectedFontSize: 12.sp,
          unselectedItemColor: const Color.fromRGBO(166, 166, 166, 1),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(PEOCiconFont.zhoubian), label: "周边"),
            BottomNavigationBarItem(
                icon: Icon(PEOCiconFont.kangfu), label: "康复"),
            BottomNavigationBarItem(
                icon: Icon(PEOCiconFont.shouye), label: "首页"),
            BottomNavigationBarItem(
                icon: Icon(PEOCiconFont.xiaoxi), label: "训练房"),
            BottomNavigationBarItem(
                icon: Icon(PEOCiconFont.userwode), label: "我的"),
          ]),
    );
  }
}
