/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 20:58:55
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 21:37:17
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\verifycodeinputpage.dart
 * @Description: 验证码的输入页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/peocdesign.dart';

class VerifyCodeInputPage extends StatefulWidget {
  const VerifyCodeInputPage({Key? key}) : super(key: key);

  @override
  State<VerifyCodeInputPage> createState() => _VerifyCodeInputPageState();
}

class _VerifyCodeInputPageState extends State<VerifyCodeInputPage> {
  TextEditingController textEditingController = TextEditingController();
  String _currentText = "";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: PinCodeTextField(
            length: 4,
            obscureText: false,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(18),
              fontWeight: FontWeight.bold,
              fontFamily: "syhtFamily",
            ),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8.w),
              fieldHeight: 56.h,
              fieldWidth: 56.w,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              inactiveColor: const Color.fromRGBO(229, 235, 240, 1),
              activeColor: const Color.fromRGBO(229, 235, 240, 1),
              selectedColor: PEOCConfig.THEMECOLOR,
              borderWidth: 1.w,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v) {
              debugPrint("全部输完的回调函数");
            },
            onChanged: (value) {
              //内容改变的回调
              debugPrint(value);
              setState(() {
                _currentText = value;
              });
            },
            beforeTextPaste: (text) {
              // 用于验证是否可以粘贴文本的回调函数，返回true 原样
              return true;
            },
            appContext: context,
          ),
        ),
      ),
    );
  }
}
