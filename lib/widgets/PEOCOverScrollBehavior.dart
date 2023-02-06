/*
 * @Author: YJR-1100
 * @Date: 2023-02-03 09:09:42
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-03 09:09:53
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCOverScrollBehavior.dart
 * @Description: 
 * 
 * 
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';

class PEOCOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (getPlatform(context) == TargetPlatform.android ||
        getPlatform(context) == TargetPlatform.fuchsia) {
      return GlowingOverscrollIndicator(
        showLeading: false,
        showTrailing: false,
        axisDirection: axisDirection,
        color: Theme.of(context).colorScheme.secondary,
        child: child,
      );
    } else {
      return child;
    }
  }
}
