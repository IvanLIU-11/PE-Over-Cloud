/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 16:02:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 11:41:51
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCButton.dart
 * @Description: 没有点击效果的文字按钮
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PEOCButton {
  // static Widget timeButton = timerButton();
  static Widget textButton({
    Key? key,
    String? msg,
    double fontsize = 14,
    required Function() ontap,
    Widget? text,
  }) {
    return InkWell(
      key: key,
      highlightColor: Colors.black,
      onTap: ontap,
      child: text ??
          Text(
            msg!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PEOCConfig.THEMECOLOR,
              fontSize: fontsize,
              fontWeight: FontWeight.normal,
              fontFamily: "syhtFamily",
              height: 1.0,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
    );
  }

  static Widget iconButton({
    Key? key,
    double? width,
    double? height,
    required Icon icon,
    required Function() ontap,
  }) {
    return InkWell(
      key: key,
      onTap: ontap,
      child: Container(
        width: width ?? 35.w,
        height: height ?? 43.h,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }

  static Widget text_iconButton({
    Key? key,
    double? width,
    double? height,
    required Icon icon,
    required Widget text,
    required Function() ontap,
  }) {
    return InkWell(
      key: key,
      onTap: ontap,
      child: Container(
        width: width ?? 35.w,
        height: height ?? 43.h,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              text,
            ]),
      ),
    );
  }

  static Widget selectedButton(
      {required int index,
      required width,
      required height,
      required int indexctrl,
      required String text,
      required double fontsize,
      required Function() ontap}) {
    return selectedbtn(
        index: index,
        width: width,
        height: height,
        indexctrl: indexctrl,
        text: text,
        fontsize: fontsize,
        ontap: ontap);
  }
}

class selectedbtn extends StatefulWidget {
  int index;
  int indexctrl;
  String text;
  double height;
  double width;
  double fontsize;
  Function() ontap;
  selectedbtn(
      {super.key,
      required this.width,
      required this.height,
      required this.indexctrl,
      required this.index,
      required this.text,
      required this.fontsize,
      required this.ontap});

  @override
  State<selectedbtn> createState() => _selectedbtnState();
}

class _selectedbtnState extends State<selectedbtn> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
            onTap: widget.ontap,
            child: Container(
              alignment: Alignment.center,
              height: widget.height,
              width: widget.width,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.indexctrl == widget.index
                      ? PEOCConfig.THEMECOLOR
                      : Colors.grey[400],
                  fontSize: widget.fontsize,
                  fontWeight: FontWeight.normal,
                  fontFamily: "syhtFamily",
                  height: 1.0,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            )));
  }
}
