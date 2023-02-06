/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:53:32
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-02-06 23:22:38
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\loginpage.dart
 * @Description: 登录页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
// ignore: depend_on_referenced_packages
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/utilities/storage.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:pe_over_cloud/widgets/toastDialog.dart';
import 'package:pe_over_cloud/utilities/user.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 记住密码的选框
  bool _rememberPwdSelected = true;
  // 维护手机号，密码的聚焦状态
  bool _phonefocus = true;
  bool _pwdfocus = false;
  // 是否显示密码
  bool _showpwd = false;
  final FocusNode _focusNodephone = FocusNode();
  final phoneController = TextEditingController();
  final FocusNode _focusNodepwd = FocusNode();
  final pwdController = TextEditingController();
  // 防止频繁点击
  DateTime _lastPopTime = DateTime.now();
  // 是否加载登录按钮
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 这里可以设置输入框默认值
    phoneController.text = "";
    // phone输入框焦点
    _focusNodephone.addListener(() async {
      if (!_focusNodephone.hasFocus) {
        // 失去焦点
        setState(() {
          _phonefocus = false;
        });
        if (phoneController.text.isNotEmpty) {
          if (!isphonenum(phoneController.text)) {
            // 手机号格式不正确
            showmessage(msg: "手机号格式错误", fontsize: ScreenUtil().setSp(14));
          } else {
            //手机号正确，检查本地存储有没有保存密码
            String? pwd = await getPwd(phoneController.text);
            if (pwd.isNotEmpty) {
              //有存过的密码
              pwdController.text = pwd;
            }
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
    _focusNodepwd.addListener(() {
      if (!_focusNodepwd.hasFocus) {
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
        body: GestureDetector(
          onTap: () {
            _focusNodephone.unfocus();
            _focusNodepwd.unfocus();
          },
          child: Container(
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
                            child: PEOCText.easyText(
                                text: "嗨，欢迎回来", fontsize: 24.sp),
                          ),
                          SizedBox(
                            width: 328.w,
                            height: 11.h,
                          ),
                          SizedBox(
                            width: 328.w,
                            height: 24.h,
                            child: PEOCText.easyText(
                              text: "登录到您的账户",
                              fontsize: 16.sp,
                              color: const Color.fromRGBO(107, 114, 128, 1),
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
                        child: PEOCText.easyText(text: "手机号码", fontsize: 14.sp),
                      ),
                      Container(
                        width: 327.w,
                        height: 56.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: !_phonefocus
                                ? const Color.fromRGBO(156, 163, 175, 1)
                                : PEOCConfig.THEMECOLOR,
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
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
                        child: PEOCText.easyText(text: "密码", fontsize: 14.sp),
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
                                focusNode: _focusNodepwd,
                                obscureText: !_showpwd, // 是否隐藏文本，即密码类型
                                style: TextStyle(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "syhtFamily",
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isCollapsed: true,
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
                                  size: 22.sp,
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
                                value: _rememberPwdSelected,
                                activeColor: PEOCConfig.THEMECOLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.w)),
                                onChanged: (value) {
                                  setState(() {
                                    _rememberPwdSelected = value!;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              // height: 21.h,E
                              // width: 33.w,
                              child: PEOCText.easyText(
                                  text: "记住密码", fontsize: 14.sp),
                            ),
                          ],
                        ),
                        PEOCButton.textButton(
                            msg: "忘记密码?",
                            fontsize: 14.sp,
                            ontap: () {
                              // TODO: 忘记密码以后呢？
                              Get.toNamed('/forget');
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
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (DateTime.now().difference(_lastPopTime) >
                            const Duration(seconds: 2)) {
                          _lastPopTime = DateTime.now();
                          if (phoneController.text.isEmpty) {
                            showmessage(msg: "请输入手机号", fontsize: 14.sp);
                          } else if (!isphonenum(phoneController.text)) {
                            showmessage(msg: "手机号格式错误", fontsize: 14.sp);
                          } else if (pwdController.text.isEmpty) {
                            showmessage(msg: "请输入密码", fontsize: 14.sp);
                          } else {
                            userPhonenumPwdLogin(
                                    phoneController.text, pwdController.text)
                                .then((res) async {
                              var code = res["code"];
                              var message = res["message"];
                              SmartDialog.dismiss(status: SmartStatus.loading);
                              if (code == 200) {
                                var data = res["data"];
                                var token = data["access_token"];

                                //存储token到本地
                                storeLocalToken(token);
                                // 存储当前登录账户
                                storeCurrenLoginAccount(
                                phoneController.text, pwdController.text);

                                if (_rememberPwdSelected) {
                                  //记住密码
                                  storePwd(
                                      phoneController.text, pwdController.text);
                                } else {
                                  //不记住密码，查一下本地记过没有，记过要删掉
                                  deletePwd(phoneController.text);
                                }

                                showmessage(msg: "登录成功", fontsize: 14.sp);
                                //周期性获得token，每过29min获取一次
                                getTokenPeriodic(phoneController.text, pwdController.text);
                                Get.offAllNamed('/usertype');
                              } else {
                                showmessage(msg: message, fontsize: 14.sp);
                              }
                            });
                          }
                        } else {
                          _lastPopTime = DateTime.now();
                          showmessage(msg: "请勿重复点击！", fontsize: 14.sp);
                        }
                      },
                      child: PEOCText.easyText(
                          text: "登录", fontsize: 16.sp, color: Colors.white),
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
                        fontsize: 14.sp,
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
                    child: PEOCText.easyText(
                      text: "其它方式登录",
                      fontsize: 14.sp,
                      color: const Color.fromRGBO(156, 163, 175, 1),
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
                            // TODO：拉起微信登录
                            debugPrint("微信登录");
                          },
                          child: Container(
                            height: 24.h,
                            width: 24.h,
                            margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                            child: Icon(
                              PEOCiconFont.weixin,
                              color: const Color.fromRGBO(40, 196, 69, 1),
                              size: 24.sp,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //TODO: 拉起QQ登录
                            debugPrint("QQ登录");
                          },
                          child: Container(
                            height: 24.h,
                            width: 24.h,
                            margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                            child: Icon(
                              PEOCiconFont.QQ,
                              color: const Color.fromRGBO(89, 173, 248, 1),
                              size: 24.sp,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // 如果填了手机号，就带着手机号过去
                            if (!isphonenum(phoneController.text)) {
                              Fluttertoast.cancel();
                              Get.toNamed('/verifycodelogin');
                            } else {
                              Get.toNamed('/verifycodelogin',
                                  arguments: phoneController.text);
                            }
                          },
                          child: Container(
                            height: 24.h,
                            width: 24.h,
                            margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                            child: Icon(
                              PEOCiconFont.message,
                              color: const Color.fromRGBO(171, 227, 255, 1),
                              size: 24.sp,
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
                        ontap: () {
                          Get.toNamed("/clause");
                        },
                        text: PEOCText.easyText(
                            text: "登录软件视为您同意我们的服务条款",
                            fontsize: 12.sp,
                            color: PEOCConfig.THEMECOLOR,
                            decoration: TextDecoration.underline),
                      ))
                ]),
              )),
        ));
  }

  @override
  void dispose() {
    phoneController.dispose();
    pwdController.dispose();
    super.dispose();
  }
}
