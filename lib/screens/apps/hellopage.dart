/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-25 15:50:20
 * @LastEditTime: 2023-02-06 23:58:06
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:pe_over_cloud/utilities/storage.dart';
import 'package:pe_over_cloud/utilities/user.dart';

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
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      
      String currentPhone = await getCurrenLoginAccountPhone();
      String currentPwd = await getCurrenLoginAccountPwd();

      if (currentPhone.isNotEmpty && currentPwd.isNotEmpty) {
        //当前有登陆的账号，直接登录
        Get.offNamed('/main');
        getTokenPeriodic(currentPhone, currentPwd);
        timer.cancel();
      } else {
        //当前没有登陆的账号，去登陆
        Get.offAllNamed('/login');
        timer.cancel();
      }
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
