/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 20:58:28
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-01-04 18:43:25
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\verifycodeloginpage.dart
 * @Description: 使用验证码登录的页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:pe_over_cloud/widgets/toastDialog.dart';
import 'package:pe_over_cloud/widgets/PEOCAppBar.dart';
import 'package:pe_over_cloud/utilities/user.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class VerifyCodeLoginPage extends StatefulWidget {
  const VerifyCodeLoginPage({super.key});

  @override
  State<VerifyCodeLoginPage> createState() => _VerifyCodeLoginPageState();
}

class _VerifyCodeLoginPageState extends State<VerifyCodeLoginPage> {
  bool _phonefocus = true;
  final FocusNode _focusNodephone = FocusNode();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      phoneController.text = Get.arguments;
    }

    // phone输入框焦点
    _focusNodephone.addListener(() {
      if (!_focusNodephone.hasFocus) {
        // 失去焦点
        setState(() {
          _phonefocus = false;
        });
        if (phoneController.text.isNotEmpty) {
          if (!isphonenum(phoneController.text)) {
            // 手机号格式不正确
            showmessage(msg: "手机号格式错误", fontsize: ScreenUtil().setSp(14));
          }
        }
      } else {
        setState(() {
          _phonefocus = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return Scaffold(
      appBar: PEOCAppBar.easyAppBar(
        ontap: () {
          Get.back();
        },
      ),
      body: GestureDetector(
        onTap: (() {
          _focusNodephone.unfocus();
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
                      child: PEOCText.easyText(text: "验证码登录", fontsize: 24.sp),
                    ),
                    SizedBox(
                      width: 328.w,
                      height: 11.h,
                    ),
                    SizedBox(
                      width: 328.w,
                      height: 24.h,
                      child: PEOCText.easyText(
                        text: "请输入您注册时使用的手机号",
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
              Container(
                width: 328.w,
                height: 56.h,
                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: !_phonefocus
                        ? const Color.fromRGBO(156, 163, 175, 1)
                        : PEOCConfig.THEMECOLOR,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextField(
                        controller: phoneController,
                        focusNode: _focusNodephone,
                        autofocus: true,
                        style: TextStyle(
                          color: const Color.fromRGBO(17, 24, 39, 1),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.normal,
                          fontFamily: "syhtFamily",
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          prefixText: "+86 ",
                          prefixStyle: TextStyle(
                            color: !_phonefocus
                                ? const Color.fromARGB(255, 138, 144, 154)
                                : PEOCConfig.THEMECOLOR,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "syhtFamily",
                          ),
                        ),
                        cursorColor: PEOCConfig.THEMECOLOR,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(
                      // height: 24.h,
                      width: 83.w,
                      child: PEOCButton.textButton(
                          msg: "获取验证码",
                          fontsize: 16.sp,
                          ontap: () {
                            if (!isphonenum(phoneController.text)) {
                              // 手机号格式不正确
                              showmessage(
                                  msg: "请输入正确的手机号",
                                  fontsize: ScreenUtil().setSp(14));
                            } else {
                              // debugPrint("发送验证码");
                              // 发送验证码
                              sendUserVerifycode(phoneController.text)
                                  .then((res) {
                                var code = res["code"];
                                var message = res["message"];
                                SmartDialog.dismiss(
                                    status: SmartStatus.loading);
                                if (code == 200) {
                                  Get.toNamed('/verifycodeinput',
                                      arguments: phoneController.text);
                                } else {
                                  showmessage(msg: message, fontsize: 14.sp);
                                }
                              });
                            }
                          }),
                    ),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
