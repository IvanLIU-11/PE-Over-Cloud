/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 20:58:55
 * @LastEditors: IvanLiu
 * @LastEditTime: 2022-11-27 23:00:11
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\verifycodeinputpage.dart
 * @Description: 验证码的输入页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import '../../config/peocdesign.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeInputPage extends StatefulWidget {
  const VerifyCodeInputPage({Key? key}) : super(key: key);

  @override
  State<VerifyCodeInputPage> createState() => _VerifyCodeInputPageState();
}

class _VerifyCodeInputPageState extends State<VerifyCodeInputPage> {
  TextEditingController textEditingController = TextEditingController();
  String _currentText = "";
  //获取验证码的计时器
  Timer? _verifyTimer;
  //获取验证码的倒计时时间，同时也是能否获得验证码的标志，=0即可
  int _verifyTimeCounter = 60;

  @override
  void initState() {
    super.initState();
    startCountdownTimer(); //进入此页面就表示已经发送验证码，直接开始倒计时
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
          child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(
                height: 64.h,
                margin: EdgeInsets.fromLTRB(0, 16.h, 0, 8.h),
                // color: Colors.yellow,
                child: InkWell(
                  // 前面左侧的图标
                  child: SizedBox(
                    height: 40.w,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                  onTap: () {
                    Get.offNamed('/verifycodelogin');
                  },
                ),
              ))),
      body: GestureDetector(
        onTap: (() {
          // _focusNodephone.unfocus();
        }),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: 375.w,
          height: 812.h,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 328.w,
                  height: 69.h,
                  margin: EdgeInsets.fromLTRB(0, 16.h, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 328.w,
                        height: 34.h,
                        child:
                            PEOCText.easyText(text: "验证码登录", fontsize: 24.sp),
                      ),
                      SizedBox(
                        width: 328.w,
                        height: 11.h,
                      ),
                      SizedBox(
                        width: 328.w,
                        height: 24.h,
                        child: PEOCText.easyText(
                          text: "我们已经发送验证码到您的手机号",
                          fontsize: 16.sp,
                          color: const Color.fromRGBO(107, 114, 128, 1),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 69.h,
                  width: 328.w,
                ),
                SizedBox(
                  width: 300.w,
                  height: 56.h,
                  child: PinCodeTextField(
                    autoFocus: true,
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
                      fieldWidth: 56.h,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveColor: const Color.fromARGB(255, 209, 214, 219),
                      activeColor: const Color.fromARGB(255, 209, 214, 219),
                      selectedColor: PEOCConfig.THEMECOLOR,
                      borderWidth: 1.w,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: textEditingController,
                    onCompleted: (v) {
                      //TODO: 输入完验证码的回调
                      debugPrint("全部输完的回调函数");
                    },
                    onChanged: (value) {
                      //TODO：内容改变的回调
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
                SizedBox(
                  height: 35.h,
                  width: 328.w,
                ),
                Container(
                  width: 328.w,
                  height: 21.h,
                  alignment: Alignment.center,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 21.h,
                          alignment: Alignment.center,
                          child: PEOCText.easyText(
                            text: "没有收到验证码? ",
                            fontsize: 14.sp,
                            color: const Color.fromRGBO(107, 114, 128, 1),
                          ),
                        ),
                        SizedBox(
                          height: 21.h,
                          child: TextButton(
                            onPressed: _verifyTimeCounter != 0
                                ? null
                                : () {
                                    //按下获取验证码按钮，让验证码输入框聚焦,且暂时不能获得验证码
                                    startCountdownTimer();
                                    setState(() {
                                      _verifyTimeCounter = 60;
                                    });
                                  },
                            style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(1, 1)),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            child: Text(
                              //根据可否获得验证码更改textbutton的显示字符和颜色
                              _verifyTimeCounter != 0
                                  ? "请稍等${_verifyTimeCounter}s"
                                  : "重新发送",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(14),
                                color: _verifyTimeCounter != 0
                                    ? Colors.grey
                                    : PEOCConfig.THEMECOLOR,
                                fontFamily: 'syhtFamily',
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.normal,
                                height: 1.0,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //启动验证码倒计时
  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);

    var callback = (timer) => {
          setState(() {
            if (_verifyTimeCounter < 1) {
              _verifyTimer?.cancel();
            } else {
              _verifyTimeCounter = _verifyTimeCounter - 1;
            }
          })
        };
    _verifyTimer = Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    super.dispose();

    _verifyTimer?.cancel();
  }
}
