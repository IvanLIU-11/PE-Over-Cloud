/*
 * @Author: YJR-1100
 * @Date: 2022-11-28 14:56:16
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-05 10:52:20
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCAppBar.dart
 * @Description: 封装一个简单的AppBar
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PEOCAppBar {
  static PreferredSizeWidget easyAppBar(
      {required Function() ontap,
      Widget? title,
      Widget? leading,
      double? height,
      List<Widget>? action}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? 64.h),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: title,
        leading: leading ??
            Container(
              height: height ?? 64.h,
              margin: EdgeInsets.fromLTRB(0, 16.h, 0, 8.h),
              // color: Colors.yellow,
              child: InkWell(
                // 前面左侧的图标
                onTap: ontap,
                // 前面左侧的图标
                child: SizedBox(
                  height: 40.w,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
        actions: action,
      ),
    );
  }
}
