import 'package:flutter/material.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: PEOCConfig.DESIGNEDWIDTH.w,
      height: PEOCConfig.DESIGNEDHEIGHT.h,
      child: const Text("登陆页面"),
    );
  }
}
