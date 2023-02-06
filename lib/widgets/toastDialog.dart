/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 10:51:21
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-05 20:12:47
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\toastDialog.dart
 * @Description: 消息弹框
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showmessage({required String msg, required double fontsize}) {
  Fluttertoast.cancel();

  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP, // 显示的位置
      timeInSecForIosWeb: 1, // 提示的时间，这个针对 ios，
      toastLength: Toast.LENGTH_SHORT, //　android 中这个可以配置显示的时间长短
      backgroundColor: PEOCConfig.THEMECOLOR, // 背景颜色
      textColor: Colors.white, // 字体颜色
      fontSize: fontsize // 字体大小
      );
}

void showicontoast({Widget? widget}) {
  SmartDialog.show(
      alignmentTemp: Alignment.center,
      isPenetrateTemp: false,
      maskColorTemp: const Color.fromRGBO(0, 0, 0, 0.25),
      keepSingle: true,
      widget: Container(
        height: 150.h,
        width: 150.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 111, 111, 111),
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(126, 96, 96, 96).withOpacity(0.1),
                spreadRadius: 0.0,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ]),
        child: Center(child: widget),
      ),
      isUseAnimationTemp: false);
}
