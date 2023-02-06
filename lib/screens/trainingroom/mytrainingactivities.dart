/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-02-04 22:43:11
 * @LastEditTime: 2023-02-05 22:37:12
 * @Descripttion: 
 */
/*
 * @Author: YJR-1100
 * @Date: 2023-02-04 15:07:18
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 15:07:30
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\trainingroom\mytrainingactivities.dart
 * @Description: 我的训练活动页面
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCKeepAliveWapper.dart';
import 'package:pe_over_cloud/widgets/PEOCOverScrollBehavior.dart';
import 'package:pe_over_cloud/widgets/PEOCCart.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';

class MyTrainingActivities extends StatefulWidget {
  MyTrainingActivities({super.key, required this.test});

  String test;

  @override
  State<MyTrainingActivities> createState() => _MyTrainingActivitiesState();
}

class _MyTrainingActivitiesState extends State<MyTrainingActivities> {
  //是否有未完成训练任务
  bool _isNotFinishedTrain = false;

  //未完成任务和已完成任务数量和训练数据数量
  int _unfinishedtasknum = 10;
  int _finishedtasknum = 6;
  int _traindata = 6;

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

    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 0, 21.w, 0),
      child: PEOCKeepAliveWrapper(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ScrollConfiguration(
            behavior: PEOCOverScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 21.h,
                            width: 121.w,
                            alignment: Alignment.centerLeft,
                            child: PEOCText.easyText(
                                text: "未完成的训练活动",
                                fontsize: 14.sp,
                                color: const Color.fromRGBO(79, 79, 79, 1)),
                          ),
                          //小红点
                          Positioned(
                            top: 0.h,
                            right: 0.w,
                            child: Container(
                              width: 10.w,
                              height: 10.h,
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                color: _isNotFinishedTrain
                                    ? const Color.fromRGBO(255, 87, 51, 1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(100.sp),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 20.w,
                        height: 20.h,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (() {
                            setState(() {
                              _isNotFinishedTrain = !_isNotFinishedTrain;
                            });
                          }),
                          child: Icon(
                            Icons.add,
                            color: const Color.fromRGBO(79, 79, 79, 1),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  SizedBox(
                    width: 334.w,
                    child: ListView.builder(
                      shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
                      physics: const NeverScrollableScrollPhysics(), //禁止滚动
                      itemCount: _unfinishedtasknum,
                      //scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Widget item = PEOCCart.getUnFinishedTrainTaskCard(
                            imageurl:
                                "https://s2.loli.net/2023/02/03/mtvwBAEjWhrluJy.jpg",
                            trainname: "中南大学羽毛球队训练任务",
                            content: "准备活动；800米长跑；50米短跑.....",
                            settime: "今天 09:41");
                        return item;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 21.h,
                        width: 126.w,
                        alignment: Alignment.centerLeft,
                        child: PEOCText.easyText(
                            text: "已完成的训练活动",
                            fontsize: 14.sp,
                            color: const Color.fromRGBO(79, 79, 79, 1)),
                      ),
                      TextButton(
                        onPressed: () {
                          //TODO:清空已完成任务
                          print("清空已完成任务");
                        },
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(1, 1)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                          "清空",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(10),
                            color: const Color.fromRGBO(125, 125, 125, 1),
                            fontFamily: 'syhtFamily',
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  Container(
                    height: 110.h,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: _finishedtasknum,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Widget item = PEOCCart.getFinishedTrainTaskCard(
                            imageurl:
                                "https://img2.baidu.com/it/u=2131172674,3720696541&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
                            trainname: "田径队训练任务",
                            settime: "今天 09:41");
                        return item;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 21.h,
                        width: 126.w,
                        alignment: Alignment.centerLeft,
                        child: PEOCText.easyText(
                            text: "我的训练数据",
                            fontsize: 14.sp,
                            color: const Color.fromRGBO(79, 79, 79, 1)),
                      ),
                      Container(
                        width: 20.w,
                        height: 20.h,
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (() {
                            //TODO:点击我的训练数据详情
                            print("点击我的训练数据详情");
                            Get.toNamed("/traindata");
                          }),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: const Color.fromRGBO(79, 79, 79, 1),
                            size: 25.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                  ),
                  Container(
                    height: 120.h,
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: _traindata,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Widget item = PEOCCart.getTrainDataCard(
                            sportname: "800米跑步",
                            grade: "2min30s",
                            finishedtime: "1月24日 16:51");
                        return item;
                      },
                    ),
                  ),
                  SizedBox(
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                    height: 62.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
