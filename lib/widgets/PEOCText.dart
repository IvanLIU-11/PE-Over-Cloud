/*
 * @Author: YJR-1100
 * @Date: 2022-11-27 11:36:47
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-05 10:21:04
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
// 引入官方插件

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
    TextOverflow? overflow,
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
        overflow: overflow ?? TextOverflow.clip,
      ),
    );
  }

  static Widget richText({
    required String text,
    required double fontsize,
    double linelenght = 100,
    int mMaxLine = 2,
    String fontfamily = 'syhtFamily',
    Color color = const Color.fromRGBO(17, 24, 39, 1),
    Color textbuttoncolor = const Color.fromRGBO(86, 156, 214, 1),
  }) {
    return MyRichText(
      text,
      linelenght,
      mMaxLine: mMaxLine,
      fontsize: fontsize,
      fontFamily: fontfamily,
      color: color,
      textbuttoncolor: textbuttoncolor,
    );
  }
}

class MyRichText extends StatefulWidget {
  String text;
  int mMaxLine; // 最大显示行数
  double lineLength;
  bool mIsExpansion; // 全文、收起 的状态
  double fontsize; // 字体大小
  FontWeight fontWeight; // 字体粗细
  String fontFamily;
  Color color;
  Color textbuttoncolor;
  MyRichText(this.text, this.lineLength,
      {this.mMaxLine = 3,
      this.mIsExpansion = false,
      this.fontsize = 16,
      this.color = const Color.fromRGBO(17, 24, 39, 1),
      this.fontWeight = FontWeight.normal,
      this.fontFamily = "syhtFamily",
      this.textbuttoncolor = const Color.fromRGBO(86, 156, 214, 1),
      Key? key})
      : super(key: key);

  @override
  State<MyRichText> createState() => _RichTextState();
}

class _RichTextState extends State<MyRichText> {
  @override
  Widget build(BuildContext context) {
    if (IsExpansion(widget.text)) {
      //是否截断
      if (widget.mIsExpansion) {
        return Column(
          children: <Widget>[
            Text(
              widget.text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: widget.fontsize,
                color: widget.color,
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontFamily,
                // height: 1.0,
                leadingDistribution: TextLeadingDistribution.even,
                // decoration: decoration ?? TextDecoration.none,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _isShowText();
                },
                child: Container(
                  child: Text(
                    "收起",
                    style: TextStyle(
                      fontSize: widget.fontsize,
                      color: widget.textbuttoncolor,
                      fontWeight: widget.fontWeight,
                      fontFamily: widget.fontFamily,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        return Column(
          children: <Widget>[
            Text(
              widget.text,
              maxLines: widget.mMaxLine,
              textAlign: TextAlign.left,
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: widget.fontsize,
                color: widget.color,
                fontWeight: widget.fontWeight,
                fontFamily: widget.fontFamily,
                // height: 1.0,
                leadingDistribution: TextLeadingDistribution.even,
                // decoration: decoration ?? TextDecoration.none,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _isShowText();
                },
                child: Container(
                  child: Text(
                    "展开",
                    style: TextStyle(
                      fontSize: widget.fontsize,
                      color: widget.textbuttoncolor,
                      fontWeight: widget.fontWeight,
                      fontFamily: widget.fontFamily,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Text(
        widget.text,
        maxLines: widget.mMaxLine,
        textAlign: TextAlign.left,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: widget.fontsize,
          color: widget.color,
          fontWeight: widget.fontWeight,
          fontFamily: widget.fontFamily,
          // height: 1.0,
          leadingDistribution: TextLeadingDistribution.even,
          // decoration: decoration ?? TextDecoration.none,
        ),
      );
    }
  }

  bool IsExpansion(String text) {
    TextPainter textPainter = TextPainter(
        maxLines: widget.mMaxLine,
        textAlign: TextAlign.left,
        text: TextSpan(
          text: text,
          style: TextStyle(
            fontSize: widget.fontsize,
            color: widget.color,
            fontWeight: widget.fontWeight,
            fontFamily: widget.fontFamily,
            // height: 1.0,
            leadingDistribution: TextLeadingDistribution.even,
            // decoration: decoration ?? TextDecoration.none,
          ),
        ),
        textDirection: TextDirection.ltr)
      ..layout(maxWidth: widget.lineLength, minWidth: 50);
    if (textPainter.didExceedMaxLines) {
      //判断 文本是否需要截断
      return true;
    } else {
      return false;
    }
  }

  void _isShowText() {
    if (widget.mIsExpansion) {
      //关闭
      setState(() {
        widget.mIsExpansion = false;
      });
    } else {
      //打开
      setState(() {
        widget.mIsExpansion = true;
      });
    }
  }
}
