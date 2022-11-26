import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:get/get.dart';
import 'dart:async';

//应用启动页

class HelloPage extends StatelessWidget {
  const HelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );

    //使用定时器定时跳转到登录页面
    Timer(const Duration(seconds: 2), () {
      Get.offNamed('/login');
    });

    return Stack(alignment: Alignment.center, children: [
      Image.asset(
        //按照设计稿显示的尺寸设置即可
        width: 375.w,
        height: 812.h,
        'asset/images/StartPage.png',
        fit: BoxFit.cover,
      ),
      SizedBox(
        //应用名
        height: 58.h,
        // width: 128.w,
        child: Text(
          PEOCConfig.APPNAME,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(48),
            fontWeight: FontWeight.normal,
            letterSpacing: ScreenUtil().setSp(14),
            decoration: TextDecoration.none,
            fontFamily: "ysbthFamily",
          ),
        ),
      ),
    ]);
  }
}
