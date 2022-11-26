/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 20:58:28
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-26 21:04:48
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\users\verifycodeloginpage.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
import 'package:flutter/material.dart';

class VerifyCodeLoginPage extends StatefulWidget {
  const VerifyCodeLoginPage({super.key});

  @override
  State<VerifyCodeLoginPage> createState() => _VerifyCodeLoginPageState();
}

class _VerifyCodeLoginPageState extends State<VerifyCodeLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("验证码登录"),
    );
  }
}
