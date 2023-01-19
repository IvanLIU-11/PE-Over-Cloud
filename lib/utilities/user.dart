/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:42:01
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-01-19 10:33:58
 * @FilePath: \PE-Over-Cloud\Client\lib\utilities\user.dart
 * @Description: 用户的一些业务逻辑函数
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 判断是否是手机号
bool isphonenum(String phonenum) {
  RegExp exp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  bool matched = exp.hasMatch(phonenum);
  return matched;
}

//是否是正确的密码形式 6-18位\字母\数字\规定字符的任意组合
bool isrightpwd(String pwd) {
  RegExp exp = RegExp(r'^[0-9a-zA-Z_!,.]{6,18}$');
  bool matched = exp.hasMatch(pwd);
  return matched;
}

// 注册

/// 发送注册验证码
Future<dynamic> sendUserVerifycodeRegister(String phonenum) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));

  // 发送验证码
  var res = await PEOCConfig.dio
      .get('/reg/send/mes', queryParameters: {'u_phone': phonenum});
  var response = res.data;
  print(response);
  return response;
}

/// 发送注册请求
Future<dynamic> userRegister(
    String phonenum, String pwd, String verifycode) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));

  // 发送请求
  var res = await PEOCConfig.dio.post('/reg/result',
      data: jsonEncode(
          {"u_phone": phonenum, "password": pwd, "verify_code": verifycode}));
  var response = res.data;
  print(response);
  return response;
}

// 登录

/// 密码登录
Future<dynamic> userPhonenumPwdLogin(String phonenum, String pwd) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));

  // 发送请求
  var res = await PEOCConfig.dio.post('/login/password',
      data: jsonEncode({"u_phone": phonenum, "password": pwd}));
  var response = res.data;
  print(response);
  return response;
}

/// 发送登录验证码
Future<dynamic> sendUserVerifycode(String phonenum) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));

  // 发送验证码
  var res = await PEOCConfig.dio
      .get('/login/send/mes', queryParameters: {'u_phone': phonenum});
  var response = res.data;
  print(response);
  return response;
}

/// 验证码登录
Future<dynamic> userVerifycodeLogin(String phonenum, String Verifycode) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));

  // 发送验证码
  var res = await PEOCConfig.dio.post('/login/message',
      data: jsonEncode({"u_phone": phonenum, "verifycode": Verifycode}));
  var response = res.data;
  print(response);
  return response;
}
