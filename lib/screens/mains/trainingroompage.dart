/*
 * @Author: YJR-1100
 * @Date: 2023-02-04 12:15:54
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 15:55:33
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\trainingroompage.dart
 * @Description: 训练房页面
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/screens/trainingroom/mytrainingactivities.dart';
import 'package:pe_over_cloud/screens/trainingroom/mytrainingroom.dart';

class TrainingRoomPage extends StatefulWidget {
  const TrainingRoomPage({super.key});

  @override
  State<TrainingRoomPage> createState() => _TrainingRoomPageState();
}

class _TrainingRoomPageState extends State<TrainingRoomPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ContainedTabBarView(
          tabs: const [Text('训练房'), Text('我的训练活动')],
          tabBarProperties: TabBarProperties(
            padding: EdgeInsets.only(top: 10.h),
            height: 56.h,
            background: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.1,
                  blurRadius: 1,
                  offset: const Offset(0.0, 2),
                ),
              ]),
            ),
            indicatorColor: PEOCConfig.THEMECOLOR,
            indicatorWeight: 2.sp,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: const Color.fromRGBO(140, 140, 140, 1),
            labelColor: Colors.black,
            unselectedLabelStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              fontFamily: "syhtRegularFamily",
            ),
            labelStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
              fontFamily: "syhtRegularFamily",
            ),
          ),
          views: [
            MyTrainingroom(
              test: "先占个传值的位置",
            ),
            MyTrainingActivities(
              test: "先占个传值的位置",
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
