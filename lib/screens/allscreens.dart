/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 21:59:59
 * @LastEditors: IvanLiu
 * @LastEditTime: 2022-11-27 21:56:00
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\allscreens.dart
 * @Description: 所有页面的入口文件
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/cupertino.dart';
import './apps/hellopage.dart';
import './apps/clause.dart';
import './users/loginpage.dart';
import './users/registerpage.dart';
import './users/verifycodeinputpage.dart';
import './users/verifycodeloginpage.dart';
import './users/forgetpage.dart';

Widget gethellopage() => const HelloPage();
Widget getclausepage() => const ClausePage();
Widget getloginpage() => const LoginPage();
Widget getregisterpage() => const RegisterPage();
Widget getverifycodeinputpage() => const VerifyCodeInputPage();
Widget getverifycodeloginpage() => const VerifyCodeLoginPage();
Widget getforgetpahe() => const ForgetPage();
