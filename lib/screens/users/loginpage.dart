/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:53:32
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 16:38:34
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\loginpage.dart
 * @Description: 登录页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../widgets/PEOCButton.dart';
import '../../PEOCiconFont.dart';
import '../../widgets/toastDialog.dart';
import '../../utilities/user.dart';

// import 'package:get/get.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 维护单选状态
  bool _checkboxSelected = true;
  bool _phonefocus = true;
  bool _pwdfocus = false;
  bool _showpwd = false;
  FocusNode focusNodephone = FocusNode();
  final phoneController = TextEditingController();
  FocusNode focusNodepwd = FocusNode();
  final pwdController = TextEditingController();
  DateTime _lastPopTime = DateTime.now();
  bool isKeyboardActived = true;

  @override
  void initState() {
    super.initState();
    // 这里可以设置输入框默认值
    phoneController.text = "";
    // phone输入框焦点
    focusNodephone.addListener(() {
      if (!focusNodephone.hasFocus) {
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

    // pwd输入框失去焦点
    pwdController.text = "";
    // phone输入框焦点
    focusNodepwd.addListener(() {
      if (!focusNodepwd.hasFocus) {
        // 失去焦点
        setState(() {
          _pwdfocus = false;
        });
      } else {
        setState(() {
          _pwdfocus = true;
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: 375.w,
          height: 812.h,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  width: 328.w,
                  height: 69.h,
                  margin: EdgeInsets.fromLTRB(0, 16.h, 0, 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 328.w,
                        height: 34.h,
                        child: Text(
                          "嗨，欢迎回来",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(24),
                            fontWeight: FontWeight.normal,
                            fontFamily: "syhtFamily",
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 328.w,
                        height: 11.h,
                      ),
                      SizedBox(
                        width: 328.w,
                        height: 24.h,
                        child: Text(
                          "登录到您的账户",
                          style: TextStyle(
                            color: const Color.fromRGBO(107, 114, 128, 1),
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.normal,
                            fontFamily: "syhtFamily",
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                width: 328.w,
                height: 29.h,
              ),
              SizedBox(
                width: 328.w,
                height: 77.h,
                child: Column(children: [
                  Container(
                    width: 328.w,
                    height: 21.h,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "手机号码",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(17, 24, 39, 1),
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.normal,
                        fontFamily: "syhtFamily",
                      ),
                    ),
                  ),
                  Container(
                    width: 327.w,
                    height: 56.h,
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !_phonefocus
                            ? const Color.fromRGBO(156, 163, 175, 1)
                            : PEOCConfig.THEMECOLOR,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: phoneController,
                      focusNode: focusNodephone,
                      autofocus: true,
                      style: TextStyle(
                        color: const Color.fromRGBO(17, 24, 39, 1),
                        fontSize: ScreenUtil().setSp(18),
                        fontWeight: FontWeight.normal,
                        fontFamily: "syhtFamily",
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: "+86 ",
                        prefixStyle: TextStyle(
                          color: !_phonefocus
                              ? const Color.fromARGB(255, 138, 144, 154)
                              : PEOCConfig.THEMECOLOR,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.normal,
                          fontFamily: "syhtFamily",
                        ),
                      ),
                      cursorColor: PEOCConfig.THEMECOLOR,
                      keyboardType: TextInputType.phone,
                    ),
                  )
                ]),
              ),
              SizedBox(
                width: 328.w,
                height: 16.h,
              ),
              SizedBox(
                width: 328.w,
                height: 77.h,
                child: Column(children: [
                  Container(
                    width: 328.w,
                    height: 21.h,
                    alignment: Alignment.topLeft,
                    child: Text(
                      "密码",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: const Color.fromRGBO(17, 24, 39, 1),
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.normal,
                        fontFamily: "syhtFamily",
                      ),
                    ),
                  ),
                  Container(
                    width: 327.w,
                    height: 56.h,
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: !_pwdfocus
                            ? const Color.fromRGBO(156, 163, 175, 1)
                            : PEOCConfig.THEMECOLOR,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            // 输入框
                            controller: pwdController,
                            focusNode: focusNodepwd,
                            obscureText: !_showpwd, // 是否隐藏文本，即密码类型
                            style: TextStyle(
                              color: const Color.fromRGBO(17, 24, 39, 1),
                              fontSize: ScreenUtil().setSp(18),
                              fontWeight: FontWeight.normal,
                              fontFamily: "syhtFamily",
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            cursorColor: PEOCConfig.THEMECOLOR,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Container(
                          // height: 24.h,
                          width: 24.w,
                          margin: EdgeInsets.fromLTRB(5.w, 4.5.h, 5.w, 0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _showpwd = !_showpwd;
                              });
                            },
                            child: Icon(
                              _showpwd
                                  ? PEOCiconFont.closeeyeFont
                                  : PEOCiconFont.eyeFont,
                              color: !_pwdfocus
                                  ? const Color.fromRGBO(156, 163, 175, 1)
                                  : PEOCConfig.THEMECOLOR,
                              size: ScreenUtil().setSp(22),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              SizedBox(
                width: 328.w,
                height: 19.h,
              ),
              SizedBox(
                width: 328.w,
                height: 21.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 21.h,
                          width: 33.w,
                          child: Checkbox(
                            value: _checkboxSelected,
                            activeColor: PEOCConfig.THEMECOLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.w)),
                            onChanged: (value) {
                              setState(() {
                                _checkboxSelected = value!;
                              });
                            },
                          ),
                        ),
                        Text(
                          "记住密码",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(14),
                            fontWeight: FontWeight.normal,
                            fontFamily: "syhtFamily",
                          ),
                        ),
                      ],
                    ),
                    PEOCButton.textButton(
                        msg: "忘记密码?",
                        fontsize: ScreenUtil().setSp(14),
                        ontap: () {
                          print("点击忘记密码了");
                        })
                  ],
                ),
              ),
              SizedBox(
                width: 328.w,
                height: 32.5.h,
              ),
              SizedBox(
                width: 327.w,
                height: 56.h,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.h)))),
                  onPressed: () {
                    if (DateTime.now().difference(_lastPopTime) >
                        const Duration(seconds: 2)) {
                      _lastPopTime = DateTime.now();
                      if (phoneController.text.isEmpty) {
                        showmessage(
                            msg: "请输入手机号", fontsize: ScreenUtil().setSp(14));
                      } else if (!isphonenum(phoneController.text)) {
                        showmessage(
                            msg: "手机号格式错误", fontsize: ScreenUtil().setSp(14));
                      } else if (pwdController.text.isEmpty) {
                        showmessage(
                            msg: "请输入密码", fontsize: ScreenUtil().setSp(14));
                      } else {
                        // TODO: 登录
                        userPhonenumPwdLogin(
                            phoneController.text, pwdController.text);
                      }
                    } else {
                      _lastPopTime = DateTime.now();
                      showmessage(
                          msg: "请勿重复点击！", fontsize: ScreenUtil().setSp(14));
                    }
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.normal,
                      fontFamily: "syhtFamily",
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 328.w,
                height: 27.h,
              ),
              Container(
                width: 328.w,
                height: 21.h,
                alignment: Alignment.center,
                child: PEOCButton.textButton(
                    msg: "账号注册",
                    fontsize: ScreenUtil().setSp(14),
                    ontap: () {
                      // 跳转如果有手机号就携带上
                      if (!isphonenum(phoneController.text)) {
                        Fluttertoast.cancel();
                        Get.toNamed('/register', arguments: "");
                      } else {
                        Get.toNamed('/register',
                            arguments: phoneController.text);
                      }
                    }),
              ),
              SizedBox(
                height: 114.h,
              ),
              Container(
                width: 328.w,
                height: 22.h,
                alignment: Alignment.center,
                child: Text(
                  "其它方式登录",
                  style: TextStyle(
                    color: const Color.fromRGBO(156, 163, 175, 1),
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.normal,
                    fontFamily: "syhtFamily",
                  ),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                alignment: Alignment.center,
                height: 24.h,
                width: 130.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        print("微信登录");
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.h,
                        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                        child: const Icon(
                          PEOCiconFont.weixin,
                          color: Color.fromRGBO(40, 196, 69, 1),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("QQ登录");
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.h,
                        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                        child: const Icon(
                          PEOCiconFont.QQ,
                          color: Color.fromRGBO(89, 173, 248, 1),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("验证码登录");
                      },
                      child: Container(
                        height: 24.h,
                        width: 24.h,
                        margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                        child: const Icon(
                          PEOCiconFont.message,
                          color: Color.fromRGBO(171, 227, 255, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                  height: 18.h,
                  child: PEOCButton.textButton(
                    ontap: () {},
                    text: Text(
                      "登录软件视为您同意我们的服务条款",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: PEOCConfig.THEMECOLOR,
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.normal,
                        fontFamily: "syhtFamily",
                      ),
                    ),
                  ))
            ]),
          )),
    );

    @override
    void dispose() {
      phoneController.dispose();
      pwdController.dispose();
      super.dispose();
    }
  }
}
