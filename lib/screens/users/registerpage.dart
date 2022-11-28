/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-25 15:50:20
 * @LastEditTime: 2022-11-28 17:31:48
 * @Descripttion: 
 */

import 'package:flutter/material.dart';
import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:pe_over_cloud/utilities/user.dart';
import 'package:pe_over_cloud/widgets/toastDialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //分别是手机号，验证码，密码的焦点
  final FocusNode _fnphone = FocusNode();
  final FocusNode _fnverify = FocusNode();
  final FocusNode _fnpaswd = FocusNode();

  bool isPhoneFocused = false;
  bool isVerifyFocused = false;
  bool isPaswdFocused = false;

  final phoneController = TextEditingController(); //控制手机号输入内容
  final pwdController = TextEditingController(); //控制密码输入内容

  //获取验证码的计时器
  Timer? _verifyTimer;
  //获取验证码的倒计时时间，同时也是能否获得验证码的标志，=0即可
  int _verifyTimeCounter = 0;

  // 是否显示密码
  bool _showpwd = false;

  @override
  void initState() {
    super.initState();
    phoneController.text = "";
    pwdController.text = "";
    //焦点添加监听器相应焦点变化
    _fnphone.addListener(() {
      if (_fnphone.hasFocus) {
        setState(() {
          isPhoneFocused = true;
        });
      } else {
        if (phoneController.text.isNotEmpty) {
          if (!isphonenum(phoneController.text)) {
            // 手机号格式不正确
            showmessage(msg: "手机号格式错误", fontsize: ScreenUtil().setSp(14));
          }
        }
        setState(() {
          isPhoneFocused = false;
        });
      }
    });
    _fnverify.addListener(() {
      if (_fnverify.hasFocus) {
        setState(() {
          isVerifyFocused = true;
        });
      } else {
        setState(() {
          isVerifyFocused = false;
        });
      }
    });
    _fnpaswd.addListener(() {
      if (_fnpaswd.hasFocus) {
        setState(() {
          isPaswdFocused = true;
        });
      } else {
        if (pwdController.text.isNotEmpty) {
          if (!isrightpwd(pwdController.text)) {
            // 密码格式不正确
            showmessage(msg: "密码格式错误", fontsize: ScreenUtil().setSp(14));
          }
        }
        setState(() {
          isPaswdFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _fnphone.unfocus();
        _fnverify.unfocus();
        _fnpaswd.unfocus();
      },
      child: Container(
        color: Colors.white,
        width: PEOCConfig.DESIGNEDWIDTH.w,
        height: PEOCConfig.DESIGNEDHEIGHT.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            //带返回箭头的顶部bar
            Positioned(
              top: 0.h,
              child: Container(
                  width: 375.w,
                  height: 108.h,
                  color: Colors.white,
                  child: Scaffold(
                    backgroundColor: Colors.white,
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
                                  Get.offNamed('/login');
                                },
                              ),
                            ))),
                  )),
            ),
            //提示信息
            Positioned(
              top: 108.h,
              left: 24.w,
              child: Container(
                color: Colors.white,
                height: 69.h,
                width: 375.w,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PEOCText.easyText(
                      text: '嗨，注册一个账户',
                      fontsize: 24.sp,
                    ),
                    PEOCText.easyText(
                      text: '输入您的手机号和登录密码',
                      fontsize: 16.sp,
                      color: const Color.fromRGBO(107, 114, 128, 1),
                    ),
                  ],
                ),
              ),
            ),
            //手机号
            Positioned(
              left: 26.w,
              top: 222.h,
              child: Container(
                width: 327.w,
                height: 77.h,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '手机号码',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.black,
                        fontFamily: 'syhtFamily',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Material(
                        child: Container(
                          height: 56.h,
                          width: 327.w,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  //选中与否觉得边框颜色
                                  color: isPhoneFocused
                                      ? PEOCConfig.THEMECOLOR
                                      : const Color.fromRGBO(107, 114, 128, 1),
                                  width: ScreenUtil().setSp(1)),
                              borderRadius: BorderRadius.circular(
                                  (ScreenUtil().setSp(12)))),
                          child: TextField(
                            controller: phoneController,
                            focusNode: _fnphone,
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
                                color: !isPhoneFocused
                                    ? const Color.fromARGB(255, 138, 144, 154)
                                    : PEOCConfig.THEMECOLOR,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "syhtFamily",
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //验证码
            Positioned(
              left: 26.w,
              top: 315.h,
              child: Container(
                width: 327.w,
                height: 77.h,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '验证码',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.black,
                        fontFamily: 'syhtFamily',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Material(
                        child: Container(
                          height: 56.h,
                          width: 327.w,
                          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: isVerifyFocused
                                      ? PEOCConfig.THEMECOLOR
                                      : const Color.fromRGBO(107, 114, 128, 1),
                                  width: ScreenUtil().setSp(1)),
                              borderRadius: BorderRadius.circular(
                                  (ScreenUtil().setSp(12)))),
                          child: TextField(
                            style: TextStyle(
                              color: const Color.fromRGBO(17, 24, 39, 1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                              fontFamily: "syhtFamily",
                            ),
                            focusNode: _fnverify,
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //密码
            Positioned(
              left: 26.w,
              top: 408.h,
              child: Container(
                width: 327.w,
                height: 77.h,
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '密码',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: Colors.black,
                        fontFamily: 'syhtFamily',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Expanded(
                      child: Material(
                        child: Container(
                          width: 327.w,
                          height: 56.h,
                          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isPaswdFocused
                                  ? PEOCConfig.THEMECOLOR
                                  : const Color.fromRGBO(107, 114, 128, 1),
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
                                  focusNode: _fnpaswd,
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
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                              Container(
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
                                    color: !isPaswdFocused
                                        ? const Color.fromRGBO(156, 163, 175, 1)
                                        : PEOCConfig.THEMECOLOR,
                                    size: 22.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //注册按钮
            Positioned(
              left: 26.w,
              top: 543.h,
              child: Container(
                width: 327.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    print("注册");
                  },
                  style: ButtonStyle(
                    //去除阴影
                    elevation: MaterialStateProperty.all(0),
                    //将按钮背景设置为透明
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    '注册',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.white,
                      fontFamily: 'syhtFamily',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            //底部返回登陆提示
            Positioned(
              top: 756.h,
              child: Container(
                width: 327.w,
                height: 22.h,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '已有账号？',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(14),
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontFamily: 'syhtFamily',
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offNamed('/login');
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(1, 1)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        "去登录",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          color: PEOCConfig.THEMECOLOR,
                          fontFamily: 'syhtFamily',
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //获取验证码按钮
            Positioned(
              top: 259.h,
              left: 259.w,
              child: SizedBox(
                height: 24.h,
                width: 83.w,
                child: TextButton(
                  onPressed: _verifyTimeCounter != 0
                      ? null
                      : () {
                          //按下获取验证码按钮，让验证码输入框聚焦,且暂时不能获得验证码
                          //必须输入了正确的手机号才可以获得验证码
                          if (phoneController.text.isNotEmpty &&
                              isphonenum(phoneController.text)) {
                            FocusScope.of(context).requestFocus(_fnverify);
                            startCountdownTimer();
                            setState(() {
                              isVerifyFocused = true;
                              isPhoneFocused = false;
                              _verifyTimeCounter = 60;
                            });
                          }
                          if (phoneController.text.isEmpty) {
                            // 手机号为空
                            showmessage(
                                msg: "请输入手机号",
                                fontsize: ScreenUtil().setSp(14));
                            return;
                          }
                          if (!isphonenum(phoneController.text)) {
                            // 手机号格式不正确
                            showmessage(
                                msg: "手机号格式错误",
                                fontsize: ScreenUtil().setSp(14));
                            return;
                          }
                        },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(1, 1)),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    //取消按钮水波纹
                    splashFactory: NoSplash.splashFactory,
                  ),
                  child: Text(
                    //根据可否获得验证码更改textbutton的显示字符和颜色
                    _verifyTimeCounter != 0
                        ? "请稍等${_verifyTimeCounter}s"
                        : "获取验证码",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: _verifyTimeCounter != 0
                          ? Colors.grey
                          : PEOCConfig.THEMECOLOR,
                      fontFamily: 'syhtFamily',
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
          ],
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

    _fnpaswd.dispose();
    _fnphone.dispose();
    _fnverify.dispose();
    phoneController.dispose();
    pwdController.dispose();
  }
}
