/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 08:42:01
 * @LastEditors: IvanLiu
 * @LastEditTime: 2022-11-27 16:22:19
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

//是否是正确的密码形式 6-18位\字母\数字\规定字符的任意组合
bool isrightpwd(String pwd) {
  RegExp exp = RegExp(r'^[0-9a-zA-Z_!,.]{6,18}$');
  bool matched = exp.hasMatch(pwd);
  return matched;
}

void userPhonenumPwdLogin(String phonenum, String pwd) {
  print("登录");
}
