/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-02-06 16:45:01
 * @LastEditTime: 2023-02-06 23:34:43
 * @Descripttion: 和存储操作相关函数，敏感信息用base64加密
 */
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeLocalToken(String token) async {
  //存储token到本地
  final prefs = await SharedPreferences.getInstance();

  // set value
  await prefs.setString('token', token);
}

Future<String> getLoacalToken() async {
  //获取本地token,没有就是空
  final prefs = await SharedPreferences.getInstance();

  String token = prefs.getString('token') ?? "";

  return token;
}

Future<void> storePwd(String uphone, String pwd) async {
  //存储对应手机号的密码
  final prefs = await SharedPreferences.getInstance();

  // set value
  await prefs.setString('pwd{$uphone}', pwd);
}

Future<String> getPwd(String uphone) async {
  //根据手机号获取记住的密码
  final prefs = await SharedPreferences.getInstance();

  String pwd = prefs.getString('pwd{$uphone}') ?? "";

  return pwd;
}

Future<void> deletePwd(String uphone) async {
  //删除对应手机号的密码
  final prefs = await SharedPreferences.getInstance();

  prefs.remove('pwd{$uphone}');
}

Future<void> storeCurrenLoginAccount(String uphone, String pwd) async {
  //存储当前登陆的账户手机号和密码
  final prefs = await SharedPreferences.getInstance();

  // set value
  await prefs.setString('currentLoginPhone', uphone);
  await prefs.setString('currentLoginPwd', pwd);
}

Future<String> getCurrenLoginAccountPhone() async {
  //得到当前登陆的账户手机号
  final prefs = await SharedPreferences.getInstance();

  String phone = prefs.getString('currentLoginPhone') ?? "";

  return phone;
}

Future<String> getCurrenLoginAccountPwd() async {
  //根据手机号获取记住的密码
  final prefs = await SharedPreferences.getInstance();

  String pwd = prefs.getString('currentLoginPwd') ?? "";

  return pwd;
}

Future<void> deleteCurrenLoginAccountPwd() async {
  //删除当前登录的手机号和密码，退出账号时使用
  final prefs = await SharedPreferences.getInstance();

  prefs.remove('currentLoginPhone');
  prefs.remove('currentLoginPwd');
}
