/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 18:20:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-02 19:49:17
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PECOVideoItem.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';

class PECOVideoItem {
  static Widget homeItem({required String lable, required Widget child}) {
    return Container(
      width: 138.w,
      margin: EdgeInsets.only(
        right: 7.w,
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 138.w,
          height: 135.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 150, 81, 81), //背景色
            borderRadius: BorderRadius.circular((12.r)), //圆角
          ),
          child: child,
        ),
        Container(
          width: 138.w,
          height: 18.h,
          padding: EdgeInsets.only(
            left: 2.w,
          ),
          child: PEOCText.easyText(
              text: lable, fontsize: 12.sp, color: Colors.black),
        ),
      ]),
    );
  }
}
