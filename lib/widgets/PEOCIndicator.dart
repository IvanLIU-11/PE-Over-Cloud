/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 10:21:06
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-02 10:41:54
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCIndicator.dart
 * @Description: 
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NLIndicator extends StatelessWidget {
  final _currentIndex;
  final _count;
  const NLIndicator(this._currentIndex, this._count);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.w,
      // margin: EdgeInsets.only(right: 4.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(_count, (index) {
          return _currentIndex == index
              ? Container(
                  width: 16.w,
                  height: 6.h,
                  margin: EdgeInsets.only(right: 4.r),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r)),
                )
              : Container(
                  width: 6.w,
                  height: 6.h,
                  margin: EdgeInsets.only(right: 4.r),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(238, 92, 92, 92),
                      borderRadius: BorderRadius.circular(20.r)),
                );
        }),
      ),
    );
  }
}
