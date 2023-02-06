/*
 * @Author: YJR-1100
 * @Date: 2023-02-04 15:23:25
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 15:30:18
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCKeepAliveWapper.dart
 * @Description: 封装keepalive组件，保证列表下滑后回来还在刚才的位置
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */
/*封装的 PEOCKeepAliveWrapper 组件*/
import 'package:flutter/material.dart';

class PEOCKeepAliveWrapper extends StatefulWidget {
  const PEOCKeepAliveWrapper(
      {super.key, @required this.child, this.keepAlive = true});

  final Widget? child;
  final bool keepAlive;
  @override
  State<PEOCKeepAliveWrapper> createState() => _PEOCKeepAliveWrapperState();
}

class _PEOCKeepAliveWrapperState extends State<PEOCKeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
  @override
  void didUpdateWidget(covariant PEOCKeepAliveWrapper oldWidget) {
    // keepAlive 状态y更新，实现在AutomatickKeepAliveClientMixin中
    if (oldWidget.keepAlive != widget.keepAlive) {
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
