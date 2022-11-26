import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';

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
  //是否可以点击获取验证码
  bool canGetVerify = true;

  @override
  void initState() {
    super.initState();
    //焦点添加监听器相应焦点变化
    _fnphone.addListener(() {
      if (_fnphone.hasFocus) {
        setState(() {
          isPhoneFocused = true;
        });
      } else {
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
                  padding: EdgeInsets.fromLTRB(32.w, 68.h, 0, 0),
                  width: 375.w,
                  height: 108.h,
                  color: Colors.white,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: IconButton(
                      splashColor: Colors.white,
                      highlightColor: Colors.white,
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: ScreenUtil().setSp(24),
                      color: Colors.black,
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                    ),
                  )),
            ),
            //提示信息
            Positioned(
              top: 124.h,
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
                    Text(
                      '嗨，注册一个账户',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(24),
                        fontFamily: 'syhtFamily',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      '输入您的手机号和登录密码',
                      style: TextStyle(
                        color: const Color.fromRGBO(107, 114, 128, 1),
                        fontSize: ScreenUtil().setSp(16),
                        fontFamily: 'syhtFamily',
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal,
                      ),
                    )
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
                    Material(
                      child: Container(
                        height: 56.h,
                        width: 327.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                //选中与否觉得边框颜色
                                color: isPhoneFocused
                                    ? PEOCConfig.THEMECOLOR
                                    : Colors.black,
                                width: ScreenUtil().setSp(1)),
                            borderRadius: BorderRadius.circular(
                                (ScreenUtil().setSp(12)))),
                        child: TextField(
                          focusNode: _fnphone,
                          decoration: const InputDecoration(
                            hintText: "请输入手机号码",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
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
                    Material(
                      child: Container(
                        height: 56.h,
                        width: 327.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: isVerifyFocused
                                    ? PEOCConfig.THEMECOLOR
                                    : Colors.black,
                                width: ScreenUtil().setSp(1)),
                            borderRadius: BorderRadius.circular(
                                (ScreenUtil().setSp(12)))),
                        child: TextField(
                          focusNode: _fnverify,
                          decoration: const InputDecoration(
                            hintText: "请输入验证码",
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          keyboardType: TextInputType.number,
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
                    Material(
                      child: Container(
                        height: 56.h,
                        width: 327.w,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: isPaswdFocused
                                    ? PEOCConfig.THEMECOLOR
                                    : Colors.black,
                                width: ScreenUtil().setSp(1)),
                            borderRadius: BorderRadius.circular(
                                (ScreenUtil().setSp(12)))),
                        child: TextField(
                          focusNode: _fnpaswd,
                          decoration: InputDecoration(
                              hintText: "请输入密码",
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.remove_red_eye_outlined),
                                onPressed: () {
                                  print("闭眼");
                                },
                              )),
                          keyboardType: TextInputType.number,
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
                  onPressed: () {},
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
                        Get.toNamed('/login');
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
                  onPressed: !canGetVerify
                      ? null
                      : () {
                          print('验证码');
                          //按下获取验证码按钮，让验证码输入框聚焦,且暂时不能获得验证码
                          FocusScope.of(context).requestFocus(_fnverify);
                          setState(() {
                            isVerifyFocused = true;
                            isPhoneFocused = false;
                            canGetVerify = false;
                          });
                        },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(1, 1)),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text(
                    //根据可否获得验证码更改textbutton的显示字符和颜色
                    canGetVerify ? "获取验证码" : "请稍等",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      color: canGetVerify ? PEOCConfig.THEMECOLOR : Colors.grey,
                      fontFamily: 'syhtFamily',
                      fontWeight: FontWeight.bold,
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
}
