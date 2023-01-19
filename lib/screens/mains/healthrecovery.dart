/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 20:53:34
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-03 19:16:23
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\healthrecovery.dart
 * @Description: 康复的页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
// import 'package:pe_over_cloud/widgets/toastDialog.dart';
// import 'package:pe_over_cloud/utilities/user.dart';

class HealthRecoveryPage extends StatefulWidget {
  const HealthRecoveryPage({super.key});

  @override
  State<HealthRecoveryPage> createState() => _HealthRecoveryPageState();
}

class _HealthRecoveryPageState extends State<HealthRecoveryPage> {
  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top + 2;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: topPadding.h,
          left: 24.w,
          child: Center(
            child: Container(
              width: 327.w,
              height: 45.h,
              alignment: Alignment.center,
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        // width: 35.w,
                        height: 24.h,
                        alignment: Alignment.center,
                        child: PEOCText.easyText(
                            text: "康复自测",
                            fontsize: 16.sp,
                            fontFamily: "syhtMediumFamily")),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
