/*
 * @Author: YJR
 * @LastEditors: IvanLiu
 * @Date: 2023-02-04 22:43:11
 * @LastEditTime: 2023-02-06 22:09:35
 * @Descripttion: 训练房页面
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:pe_over_cloud/widgets/PEOCCart.dart';
import 'package:pe_over_cloud/widgets/PEOCOverScrollBehavior.dart';
import 'package:pe_over_cloud/widgets/PEOCKeepAliveWapper.dart';
import './trainingroomsearchpage.dart';

class MyTrainingroom extends StatefulWidget {
  MyTrainingroom({super.key, required this.test});
  String test;
  @override
  State<MyTrainingroom> createState() => _MyTrainingroomState();
}

class _MyTrainingroomState extends State<MyTrainingroom> {
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 15.5.h,
                  width: PEOCConfig.DESIGNEDWIDTH.w,
                ),
                Container(
                  padding: EdgeInsets.zero,
                  height: 30.h,
                  child: Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () => {
                            // Get.toNamed('/trainingroomsearch')
                            openPageFunction(context)
                          },
                          child: Hero(
                            tag: 'trainingroomsearch',
                            child: Container(
                              width: 300.w,
                              height: 30.h,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(12.r, 0, 12.r, 0),
                              margin: EdgeInsets.only(right: 10.w),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(237, 237, 237, 1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: const Icon(
                                Icons.youtube_searched_for_outlined,
                                color: Color.fromRGBO(122, 122, 122, 1),
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: PEOCButton.iconButton(
                            icon: const Icon(
                              Icons.add_circle_outline_outlined,
                              color: Color.fromRGBO(133, 133, 133, 1),
                            ),
                            ontap: () {
                              print("新建训练房");
                            }),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.5.h),
                  child: PEOCCart.getTalkCart(),
                ),
                PEOCCart.getmessageCard(
                    imageurl:
                        "https://s2.loli.net/2023/02/03/mtvwBAEjWhrluJy.jpg",
                    talkname: "2022年中南大学羽毛球队队长群hh lkjR",
                    newmessage: "今天主要训练哈今天主要训练哈哈今天主要训练哈哈哈",
                    newmessagedate: "今天 09:41",
                    talkid: "keysixasef"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openPageFunction(context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        //目标页面
        return const TrainingRoomSearchPage();
      },
      //打开新的页面用时
      transitionDuration: const Duration(milliseconds: 800),
      //关半页岩用时
      reverseTransitionDuration: const Duration(milliseconds: 800),
      //过渡动画构建
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        //渐变过渡动画
        return FadeTransition(
          // 透明度从 0.0-1.0
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              //动画曲线规则
              curve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          child: child,
        );
      },
    ),
  );
}
