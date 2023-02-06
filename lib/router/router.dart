/*
 * @Author: YJR-1100
 * @Date: 2022-11-24 22:34:27
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-02-06 22:10:19
 * @FilePath: \PE-Over-Cloud\Client\lib\router\router.dart
 * @Description: 路由配置文件
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:get/get.dart';
import 'package:pe_over_cloud/screens/allscreens.dart';

List<GetPage> namedPages = [
  GetPage(name: '/', page: () => gethellopage()),
  GetPage(name: '/clause', page: () => getclausepage()),
  GetPage(name: '/login', page: () => getloginpage()),
  GetPage(name: '/register', page: () => getregisterpage()),
  GetPage(
    name: '/verifycodeinput',
    page: () => getverifycodeinputpage(),
  ),
  GetPage(
    name: '/verifycodelogin',
    page: () => getverifycodeloginpage(),
  ),
  GetPage(name: '/forget', page: () => getforgetpahe()),
  GetPage(name: '/main', page: () => getmainpage()),
  GetPage(name: '/usertype', page: () => getusertypepage()),
  GetPage(name: '/athleteinfo', page: () => getathleteinfopage()),
  GetPage(name: '/coachinfo', page: () => getcoachinfopage()),
  GetPage(name: '/amateurinfo', page: () => getamateurinfopage()),
  GetPage(name: '/videoplayer', page: () => getvideoplayerpage()),
  GetPage(name: '/trainingroomsearch', page: () => gettrainingroomsearchpage()),
  GetPage(name: '/traindata', page: () => getmytaindatapage()),
  GetPage(name: '/trainingchat', page: () => gettraininggchatpage()),
];
