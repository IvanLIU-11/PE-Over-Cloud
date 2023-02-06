/*
 * @Author: YJR-1100
 * @Date: 2022-12-01 20:09:49
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 11:58:30
 * @FilePath: \PE-Over-Cloud\Client\lib\screens\mains\homepage.dart
 * @Description: 登录成功后进入的首页
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:pe_over_cloud/widgets/PEOCCart.dart';
import 'package:pe_over_cloud/widgets/PEOCIndicator.dart';
import 'package:pe_over_cloud/widgets/PEOCVideoItem.dart';
import 'package:pe_over_cloud/utilities/homepage.dart';
// import 'package:pe_over_cloud/widgets/toastDialog.dart';
// import 'package:pe_over_cloud/utilities/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 获取中考体育教学视频信息
  List<Widget> _videoItemList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("主页init");
    getVideoUrl().then((value) {
      setState(() {
        _videoItemList = getHomeItemList(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    // 获取轮播图图片
    print("主页build");
    List<Map> imgList = getSwiperimg();
    final double topPadding = MediaQuery.of(context).padding.top + 2;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: topPadding.h,
            child: Center(
              child: Container(
                width: 375.w,
                height: 45.h,
                padding: EdgeInsets.fromLTRB(20.2, 0, 21.w, 0),
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
                              text: "首页",
                              fontsize: 16.sp,
                              fontFamily: "syhtMediumFamily")),
                      Container(
                        child: PEOCButton.textButton(
                            text: Icon(
                              PEOCiconFont.listFont,
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
          Positioned(
            top: topPadding.h + 45.h,
            left: 0,
            child: Container(
              width: PEOCConfig.DESIGNEDWIDTH.w,
              height: 667.h,
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 5.h, 0, 10.h),
                children: [
                  Center(
                    child: Container(
                      width: 334.w,
                      height: 158.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 133, 133, 133), //背景色
                        borderRadius: BorderRadius.circular((12.r)), //圆角
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black, // 阴影颜色
                              offset: Offset(0.w, 4.h), // 阴影开始的位置
                              blurRadius: 4.w // 阴影强度
                              )
                        ],
                      ),
                      child: Swiper(
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.network(
                              imgList[index]["url"],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        autoplay: true,
                        autoplayDisableOnInteraction: true,
                        autoplayDelay: 3500,
                        itemCount: imgList.length,
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomRight,
                          builder: SwiperCustomPagination(
                            builder: (BuildContext context,
                                SwiperPluginConfig config) {
                              return NLIndicator(
                                  config.activeIndex, imgList.length);
                            },
                          ),
                        ),
                        layout: SwiperLayout.DEFAULT,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 334.w,
                      height: 128.h,
                      padding: EdgeInsets.fromLTRB(15.w, 15.h, 15.w, 15.h),
                      margin: EdgeInsets.fromLTRB(0, 30.h, 0, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular((12.r)), //圆角
                        boxShadow: [
                          BoxShadow(
                              color: const Color.fromARGB(
                                  255, 240, 246, 247), // 阴影颜色
                              offset: Offset(0.w, 2.h), // 阴影开始的位置
                              blurRadius: 10.w // 阴影强度
                              ),
                        ],
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: 14.h,
                        spacing: 40.w,
                        children: [
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.badminton1,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "羽毛球",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.pingpang,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "乒乓球",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.swim,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "游泳",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.trackAndField,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "田径",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.basketball,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "篮球",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.football,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "足球",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.volleyball,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "排球",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                          PEOCButton.text_iconButton(
                            icon: Icon(
                              PEOCiconFont.moreFont,
                              size: 25.h,
                              color: PEOCConfig.THEMECOLOR,
                            ),
                            text: PEOCText.easyText(
                                text: "更多",
                                fontsize: 11.sp,
                                color: const Color.fromRGBO(166, 166, 166, 1)),
                            ontap: (() {}),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20.w, 30.h, 0, 0),
                    alignment: Alignment.centerLeft,
                    height: 192.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 21.h,
                            child: PEOCText.easyText(
                                text: "中考体育考试项目教学",
                                fontsize: 14.sp,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 158.h,
                            child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: _videoItemList.isEmpty
                                    ? [
                                        PEOCVideoItem.homeItem(
                                            lable: "",
                                            child: Image.asset(
                                              'asset/images/logogray.png',
                                              fit: BoxFit.cover,
                                            ),
                                            ontap: () {})
                                      ]
                                    : _videoItemList),
                          )
                        ]),
                  ),
                  Center(
                    child: Container(
                      width: 334.w,
                      height: 273.h,
                      margin: EdgeInsets.only(top: 30.h),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: double.infinity,
                              height: 21.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    PEOCText.easyText(
                                        text: "热点资讯", fontsize: 14.sp),
                                    Icon(
                                      Icons.more_horiz,
                                      color: const Color.fromRGBO(
                                          196, 196, 196, 1),
                                      size: 21.sp,
                                    )
                                  ]),
                            ),
                          ), // 热点资讯模块标题
                          SizedBox(
                              // 热点卡片
                              width: double.infinity,
                              height: 103.h,
                              child: PEOCCart.newscart(
                                  imgurl:
                                      "https://picx.zhimg.com/v2-78558a8574af881d9199dd5957400213_1440w.jpg",
                                  title: "从硅谷火到中国特斯拉发布全新半挂卡车Semi",
                                  authorimg:
                                      "https://www.itying.com/themes/itying/images/ionic4.png",
                                  author: "人民日报")),
                          Container(
                              // 热点卡片
                              width: double.infinity,
                              height: 103.h,
                              margin: EdgeInsets.only(top: 15.h),
                              child: PEOCCart.newscart(
                                  imgurl:
                                      "https://picx.zhimg.com/v2-78558a8574af881d9199dd5957400213_1440w.jpg",
                                  title: "【独家】马xxx:传统企业家为什么不会好好说话？",
                                  authorimg:
                                      "https://www.itying.com/themes/itying/images/ionic4.png",
                                  author: "人民日报人民日报")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
