/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 20:48:04
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-01-04 18:42:59
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\goodspage.dart
 * @Description: 周边页面
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
// import 'package:pe_over_cloud/widgets/toastDialog.dart';
// import 'package:pe_over_cloud/utilities/user.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
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
                          text: "运动周边",
                          fontsize: 16.sp,
                          fontFamily: "syhtMediumFamily"),
                    ),
                    Container(
                      child: PEOCButton.textButton(
                          text: Icon(
                            PEOCiconFont.listFont, // 右边的按钮
                            color: Colors.black,
                            size: 18.sp,
                          ),
                          ontap: () {
                            debugPrint("sdf");
                          }),
                    ),
                  ]),
            ),
          ),
        ),
      ]),
    );
  }
}
