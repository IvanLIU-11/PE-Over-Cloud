/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:42:01
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-02-06 23:57:18
 * @FilePath: \PE-Over-Cloud\Client\lib\utilities\user.dart
 * @Description: 用户的一些业务逻辑函数
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2022-11-25 15:50:20
 * @LastEditTime: 2023-02-06 14:27:37
 * @Descripttion: 
 */
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pe_over_cloud/utilities/storage.dart';

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

//完善运动员信息
Future<dynamic> athleteInforUpdate(
    String name,
    bool isMan,
    String birthday,
    String sport,
    bool isProfessional,
    int teamType,
    String school,
    String educationBackground,
    String athleteAddress,
    String athleteCertificate,
    String awards,
    String injury) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));
  String? token = await getLoacalToken();
  // 发送请求,带上token
  var res = await Dio(BaseOptions(
    baseUrl: 'http://47.110.82.236:8080',
    headers: {
      "content-type": "application/json",
      'accept': '*/*',
      'Authorization': " Bearer $token",
      'accept-language': 'zh-CN',
      'accept-encoding': 'gzip,deflate,br',
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )).post('/information/fill/athlete',
      data: jsonEncode({
        "name": name,
        "gender": isMan,
        "birthday": birthday,
        "sport": sport,
        "athlete_type": isProfessional,
        "team_type": teamType,
        "school": school,
        "education_background": educationBackground,
        "athlete_address": athleteAddress,
        "athlete_certificate": athleteCertificate,
        "awards": awards,
        "injury": injury
      }));
  var response = res.data;
  print(response);
  return response;
}

//完善教练员信息
Future<dynamic> coachInforUpdate(
    String name,
    bool isMan,
    String birthday,
    String sport,
    int careerYear,
    int coachType,
    int teamType,
    String school,
    String educationBackground,
    String coachAddress,
    String athleteCertificate,
    String coachCertificate,
    String refereeCertificate,
    String awards,
    String injury) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));
  String? token = await getLoacalToken();
  // 发送请求,带上token
  var res = await Dio(BaseOptions(
    baseUrl: 'http://47.110.82.236:8080',
    headers: {
      "content-type": "application/json",
      'accept': '*/*',
      'Authorization': " Bearer $token",
      'accept-language': 'zh-CN',
      'accept-encoding': 'gzip,deflate,br',
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )).post('/information/fill/coach',
      data: jsonEncode({
        "name": name,
        "gender": isMan,
        "birthday": birthday,
        "sport": sport,
        "career_year": careerYear,
        "coach_type": coachType,
        "team_type": teamType,
        // "school": school,
        "education_background": educationBackground,
        "coach_address": coachAddress,
        "athlete_certificate": athleteCertificate,
        "coach_certificate": coachCertificate,
        "referee_certificate": refereeCertificate,
        "awards": awards,
        "injury": injury
      }));
  var response = res.data;
  print(response);
  return response;
}

//完善爱好者信息
Future<dynamic> amateurInforUpdate(
    String name,
    bool isMan,
    String birthday,
    String sport,
    String cause,
    String amateurAddress,
    int experience,
    String injury) async {
  // 加载动画
  SmartDialog.showLoading(
      isLoadingTemp: false, background: const Color.fromARGB(196, 44, 44, 44));
  String? token = await getLoacalToken();
  // 发送请求,带上token
  var res = await Dio(BaseOptions(
    baseUrl: 'http://47.110.82.236:8080',
    headers: {
      "content-type": "application/json",
      'accept': '*/*',
      'Authorization': " Bearer $token",
      'accept-language': 'zh-CN',
      'accept-encoding': 'gzip,deflate,br',
    },
    connectTimeout: 5000,
    receiveTimeout: 3000,
  )).post('/information/fill/amateur',
      data: jsonEncode({
        "name": name,
        "gender": isMan,
        "birthday": birthday,
        "sport": sport,
        "cause": cause,
        "experience": experience,
        "address": amateurAddress,
        "injury": injury
      }));
  var response = res.data;
  print(response);
  return response;
}

/// 获取token
Future<dynamic> userPhonenumPwdToken(String phonenum, String pwd) async {
  // 发送请求
  var res = await PEOCConfig.dio.post('/login/password',
      data: jsonEncode({"u_phone": phonenum, "password": pwd}));
  var response = res.data;

  return response;
}

void getTokenPeriodic(String phone, String pwd) {
  //定期获得最新的token,29min一次
  const timeout = const Duration(minutes: 29);
  userPhonenumPwdToken(phone, pwd).then((res) async {
    var code = res["code"];

    if (code == 200) {
      var data = res["data"];
      var token = data["access_token"];
      print('currentTime=' + DateTime.now().toString());
      print("token_now:$token");
      //存储token到本地
      storeLocalToken(token);
    }
  });

  Timer(timeout, () {
    //到时回调
    getTokenPeriodic(phone, pwd);
  });
}
