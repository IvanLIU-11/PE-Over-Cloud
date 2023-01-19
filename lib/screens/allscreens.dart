/*
 * @Author: YJR-1100
 * @Date: 2022-11-25 21:59:59
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-01-18 20:57:16
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
import './mains/homepage.dart';
import './mains/goodspage.dart';
import './mains/healthrecovery.dart';
import './mains/mainpage.dart';
import './mains/socialpage.dart';
import './mains/userinfopage.dart';
import './users/usertypepage.dart';
import './users/athleteinfopage.dart';
import './users/coachinfopage.dart';
import './users/amateurinfopage.dart';

Widget gethellopage() => const HelloPage();
Widget getclausepage() => const ClausePage();
Widget getloginpage() => const LoginPage();
Widget getregisterpage() => const RegisterPage();
Widget getverifycodeinputpage() => const VerifyCodeInputPage();
Widget getverifycodeloginpage() => const VerifyCodeLoginPage();
Widget getforgetpahe() => const ForgetPage();
Widget gethomepage() => const HomePage();
Widget getgoodspage() => const GoodsPage();
Widget gethealthrecoverypage() => const HealthRecoveryPage();
Widget getmainpage() => const MainPage();
Widget getuserinfopage() => const UserinfoPage();
Widget getsocialpage() => const SocialPage();
Widget getusertypepage() => const UserTypePage();
Widget getathleteinfopage() => const AthleteInfoPage();
Widget getcoachinfopage() => const CoachInfoPage();
Widget getamateurinfopage() => const AmateurInfoPage();
