/*
 * @Author: YJR-1100
 * @Date: 2022-11-27 11:36:47
 * @LastEditors: IvanLiu
 * @LastEditTime: 2022-11-27 15:07:42
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCText.dart
 * @Description: 一个没有奇怪边距的text
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-27 14:35:25
 * @LastEditTime: 2022-11-27 14:46:17
 * @Descripttion: 
 */

import 'package:flutter/material.dart';

class PEOCText {
  // 没有奇怪边框的text，默认黑色
  static Widget easyText({
    required String text,
    required double fontsize,
    Color? color,
    TextAlign? textAlign,
    String? fontFamily,
    FontWeight? fontWeight,
    dynamic? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      style: TextStyle(
        fontSize: fontsize,
        color: color ?? const Color.fromRGBO(17, 24, 39, 1),
        fontWeight: fontWeight ?? FontWeight.normal,
        fontFamily: fontFamily ?? "syhtFamily",
        height: 1.0,
        leadingDistribution: TextLeadingDistribution.even,
        decoration: decoration ?? TextDecoration.none,
      ),
    );
  }
}
