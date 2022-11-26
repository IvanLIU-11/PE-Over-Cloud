/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 16:02:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 16:36:29
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCButton.dart
 * @Description: 没有点击效果的文字按钮
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import '../config/peocdesign.dart';

class PEOCButton {
  static Widget textButton(
      {String? msg,
      double fontsize = 14,
      required Function() ontap,
      Widget? text}) {
    return InkWell(
      highlightColor: Colors.black,
      onTap: ontap,
      child: text ??
          Text(
            msg!,
            style: TextStyle(
              color: PEOCConfig.THEMECOLOR,
              fontSize: fontsize,
              fontWeight: FontWeight.normal,
              fontFamily: "syhtFamily",
            ),
          ),
    );
  }
}
