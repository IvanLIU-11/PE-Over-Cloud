/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 16:02:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-02 13:27:32
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCButton.dart
 * @Description: 没有点击效果的文字按钮
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PEOCButton {
  // static Widget timeButton = timerButton();
  static Widget textButton({
    String? msg,
    double fontsize = 14,
    required Function() ontap,
    Widget? text,
  }) {
    return InkWell(
      highlightColor: Colors.black,
      onTap: ontap,
      child: text ??
          Text(
            msg!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PEOCConfig.THEMECOLOR,
              fontSize: fontsize,
              fontWeight: FontWeight.normal,
              fontFamily: "syhtFamily",
              height: 1.0,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
    );
  }

  static Widget text_iconButton({
    double? width,
    double? height,
    required Icon icon,
    required Widget text,
    required Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width ?? 32.w,
        height: height ?? 45.h,
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              icon,
              text,
            ]),
      ),
    );
  }
}

// // 失败的封装，不知道应该怎么传值
// class timerButton extends StatefulWidget {
//   Function? onTimerFinish; // 倒计时结束要执行的方法

//   timerButton({super.key});

//   @override
//   State<StatefulWidget> createState() => timerButtonState();
// }

// class timerButtonState extends State<timerButton> {
//   Timer? _timer;
//   int _countdownTime = 0;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         if (_countdownTime == 0) {
//           setState(() {
//             _countdownTime = 60;
//           });
//           //开始倒计时
//           startCountdownTimer();
//         }
//       },
//       child: Text(
//         _countdownTime > 0 ? '请稍等{$_countdownTime}s' : '获取验证码',
//         style: TextStyle(
//           fontSize: 14.sp,
//           color: _countdownTime > 0 ? Colors.grey : PEOCConfig.THEMECOLOR,
//           fontFamily: 'syhtFamily',
//           decoration: TextDecoration.none,
//         ),
//       ),
//     );
//   }

//   void startCountdownTimer() {
//     _timer = Timer.periodic(
//         const Duration(seconds: 1),
//         (Timer timer) => {
//               setState(() {
//                 if (_countdownTime < 1) {
//                   _timer?.cancel();
//                 } else {
//                   _countdownTime = _countdownTime - 1;
//                 }
//               })
//             });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _timer?.cancel();
//   }
// }
