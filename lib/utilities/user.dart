/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:42:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 14:34:31
 * @FilePath: \PE-Over-Cloud\Client\lib\utilities\user.dart
 * @Description: 用户的一些业务逻辑函数
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

/// 判断是否是手机号
bool isphonenum(String phonenum) {
  RegExp exp = RegExp(
      r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
  bool matched = exp.hasMatch(phonenum);
  return matched;
}

void userPhonenumPwdLogin(String phonenum, String pwd) {
  print("登录");
}
