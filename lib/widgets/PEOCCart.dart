/*
 * @Author: YJR-1100
 * @Date: 2022-12-03 18:41:11
 * @LastEditors: IvanLiu
 * @LastEditTime: 2023-02-06 22:09:44
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-05 10:34:32
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCCart.dart
 * @Description: 封装卡片
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */
/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-02-04 22:43:11
 * @LastEditTime: 2023-02-05 20:04:48
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PEOCCart {
  static Widget newscart({
    required String imgurl,
    required String title,
    required String authorimg,
    required String author,
  }) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 103.h,
        // color: Color.fromARGB(255, 255, 255, 255),
        child: Row(children: [
          Container(
            // image
            height: double.infinity,
            width: 200.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 133, 133, 133), //背景色
              borderRadius: BorderRadius.circular((12.r)), //圆角
            ),
            child: Image.network(
              imgurl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: 134.w,
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15.w, 7.h, 15.w, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      title,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 10.sp, fontFamily: "syhtFamily"),
                    ),
                  ), // title
                  Container(
                    // author
                    margin: EdgeInsets.only(bottom: 6.h),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            authorimg,
                            scale: 1, //缩放
                            alignment: Alignment.bottomCenter, // 图片在外部容器中的位置
                            fit: BoxFit.fill,
                            width: 15.h,
                            height: 15.h,
                          ),
                        ),
                        Container(
                          height: 15.h,
                          width: 60.w,
                          margin: EdgeInsets.only(left: 4.w),
                          child: Text(
                            author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.sp, fontFamily: "syhtFamily"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          )
        ]),
      ),
    );
  }

  static Widget getToBottom(isShow) {
    return Offstage(
      offstage: isShow,
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 5.h, 0, 20.h),
          child: PEOCText.easyText(
              text: "到底了哟~",
              fontsize: 14.sp,
              color: const Color.fromRGBO(168, 168, 168, 1)),
        ),
      ),
    );
  }

  static Widget getTalkCart() {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: PEOCConfig.THEMECOLOR,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Image.asset(
              'asset/images/Customer.png',
              height: 48.h,
              width: 48.h,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Container(
                height: 50.h,
                padding: EdgeInsets.fromLTRB(12.w, 0, 4.w, 0),
                margin: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(126, 96, 96, 96)
                            .withOpacity(0.1),
                        spreadRadius: 0.0,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: InkWell(
                  onTap: () {
                    print("我的好友");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(0, 5.h, 0, 8.h),
                        height: 50.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: PEOCText.easyText(
                                  text: "我的好友",
                                  fontsize: 14.sp,
                                  fontFamily: 'syhtMediumFamily'),
                            ),
                            Container(
                              child: PEOCText.easyText(
                                text: "没有新通知",
                                fontsize: 12.sp,
                                fontFamily: 'syhtRegularFamily',
                                color: const Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_outlined,
                        color: Color.fromRGBO(196, 196, 196, 1),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  static Widget getmessageCard({
    required imageurl,
    required talkname,
    required newmessage,
    required newmessagedate,
    required talkid,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 7.h),
      height: 50.h,
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 205, 205, 205),
              borderRadius: BorderRadius.circular(8.r),
              image: const DecorationImage(
                  image: AssetImage(
                    "asset/images/logogray.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Image.network(
              imageurl,
              height: 48.h,
              width: 48.h,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Container(
              height: 50.h,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.only(left: 6.w),
              decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0), boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(126, 96, 96, 96).withOpacity(0.1),
                  spreadRadius: 0.0,
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ]),
              child: Slidable(
                key: ValueKey(talkid),
                direction: Axis.horizontal,
                enabled: true,
                endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.21,
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        label: "",
                        backgroundColor: Colors.white.withOpacity(0),
                      ),
                      InkWell(
                        onTap: () {
                          print("删除聊天室");
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(126, 96, 96, 96)
                                      .withOpacity(0.1),
                                  spreadRadius: 0.0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ]),
                          child: const Icon(
                            Icons.delete_forever_outlined,
                            color: PEOCConfig.THEMECOLOR,
                          ),
                        ),
                      )
                    ]),
                child: Container(
                    height: 50.h,
                    padding: EdgeInsets.fromLTRB(12.w, 5.h, 10.w, 8.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(126, 96, 96, 96)
                                .withOpacity(0.1),
                            spreadRadius: 0.0,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          ),
                        ]),
                    child: InkWell(
                      onTap: () {
                        print("进入聊天页面");
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 200.w,
                                ),
                                child: PEOCText.easyText(
                                  text: talkname,
                                  fontsize: 14.sp,
                                  fontFamily: 'syhtMediumFamily',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              PEOCText.easyText(
                                text: newmessagedate,
                                color: const Color.fromRGBO(196, 196, 196, 1),
                                fontsize: 9.sp,
                                fontFamily: 'syhtMediumFamily',
                              ),
                            ],
                          )),
                          SizedBox(
                            width: 220.w,
                            child: PEOCText.easyText(
                              text: newmessage,
                              fontsize: 12.sp,
                              fontFamily: 'syhtRegularFamily',
                              color: const Color.fromRGBO(128, 128, 128, 1),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

//未完成训练任务卡片
  static Widget getUnFinishedTrainTaskCard({
    required imageurl,
    required trainname,
    required content,
    required settime,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 7.h),
      height: 50.h,
      child: Row(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 205, 205, 205),
              borderRadius: BorderRadius.circular(8.r),
              image: const DecorationImage(
                  image: AssetImage(
                    "asset/images/logogray.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Image.network(
              imageurl,
              height: 48.h,
              width: 48.h,
              fit: BoxFit.cover,
            ),
          ),
          Flexible(
            child: Container(
                height: 50.h,
                padding: EdgeInsets.fromLTRB(12.w, 5.h, 10.w, 8.h),
                margin: EdgeInsets.only(left: 6.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(126, 96, 96, 96)
                            .withOpacity(0.1),
                        spreadRadius: 0.0,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: InkWell(
                  onTap: () {
                    print("进入任务详情");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          PEOCText.easyText(
                              text: trainname,
                              fontsize: 14.sp,
                              fontFamily: 'syhtMediumFamily'),
                          PEOCText.easyText(
                              text: settime,
                              color: const Color.fromRGBO(196, 196, 196, 1),
                              fontsize: 9.sp,
                              fontFamily: 'syhtMediumFamily'),
                        ],
                      )),
                      Container(
                        child: PEOCText.easyText(
                          text: content,
                          fontsize: 12.sp,
                          fontFamily: 'syhtRegularFamily',
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

//已完成训练任务列表项样式
  static Widget getFinishedTrainTaskCard({
    required imageurl,
    required trainname,
    required settime,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 10.w, bottom: 7.h),
      height: 98.h,
      width: 80.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(126, 96, 96, 96).withOpacity(0.1),
            spreadRadius: 0.0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          //TODO:点击已完成任务
          print("点击已完成 任务");
        },
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 57.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 205, 205, 205),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8.r), bottom: Radius.zero),
                image: const DecorationImage(
                    image: AssetImage(
                      "asset/images/logogray.png",
                    ),
                    fit: BoxFit.cover),
              ),
              child: Image.network(
                imageurl,
                height: 57.h,
                width: 80.w,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 80.w,
              height: 41.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.zero, bottom: Radius.circular(8.r)),
              ),
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PEOCText.easyText(
                        text: trainname,
                        fontsize: 10.sp,
                        color: const Color.fromRGBO(130, 130, 130, 1)),
                    PEOCText.easyText(
                        text: settime,
                        fontsize: 9.sp,
                        color: const Color.fromRGBO(199, 199, 199, 1))
                  ]),
            ),
          ],
        ),
      ),
    );
  }

//训练数据卡片,缩略版显示项目和成绩，不可点击
  static Widget getTrainDataCard({
    required sportname,
    required finishedtime,
    required grade,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 10.w, bottom: 7.h),
      padding:
          EdgeInsets.only(left: 10.w, right: 10.w, top: 12.h, bottom: 10.h),
      height: 110.h,
      width: 110.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(126, 96, 96, 96).withOpacity(0.1),
            spreadRadius: 0.0,
            blurRadius: 5,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            PEOCText.easyText(
                text: sportname,
                fontsize: 12.sp,
                color: const Color.fromRGBO(79, 79, 79, 1)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PEOCText.easyText(
                text: grade,
                fontsize: 18.sp,
                color: const Color.fromRGBO(255, 87, 51, 1)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PEOCText.easyText(
                text: finishedtime,
                fontsize: 9.sp,
                color: const Color.fromRGBO(166, 166, 166, 1)),
          ],
        ),
      ]),
    );
  }

  //我的训练数据页面中以训练任务展示的训练数据卡片
  static Widget getTrainDataInforCard({
    required trainname,
    required trainroom,
    required settime,
  }) {
    return GestureDetector(
      onTap: () {
        //TODO:点击我的训练数据中的一项跳转到对应训练任务
        print("点击我的训练数据中的一项跳转到对应训练任务");
      },
      child: Container(
        height: 49.h,
        width: 311.w,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.only(left: 12.w, right: 8.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(126, 96, 96, 96).withOpacity(0.3),
                spreadRadius: 0.0,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PEOCText.easyText(
                text: trainname,
                fontsize: 16.sp,
                color: const Color.fromRGBO(61, 61, 61, 1)),
            PEOCText.easyText(
                text: trainroom,
                fontsize: 10.sp,
                color: const Color.fromRGBO(128, 128, 128, 1)),
          ],
        ),
      ),
    );
  }

  //我的训练数据页面中以训日期统计的训练数据卡片
  static Widget getTrainDataInDaysCard({
    required trainnum,
    required settime,
    //某一天的训练内容
    required onedaytrainlist,
  }) {
    return Container(
      width: 334.w,
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.only(top: 9.h, bottom: 12.h),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(247, 247, 247, 1),
          borderRadius: BorderRadius.all(Radius.circular(8.r))),
      alignment: Alignment.center,
      child: Column(children: [
        SizedBox(
          width: 311.w,
          height: 24.h,
          child: PEOCText.easyText(
              text: settime,
              fontsize: 16.sp,
              color: const Color.fromRGBO(255, 133, 81, 1)),
        ),
        SizedBox(
          width: 311.w,
          child: ListView.builder(
            shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
            physics: const NeverScrollableScrollPhysics(), //禁止滚动
            itemCount: trainnum,

            itemBuilder: (BuildContext context, int index) {
              List todaytrainlist = onedaytrainlist[index];
              Widget item = PEOCCart.getTrainDataInforCard(
                  trainname: todaytrainlist[0],
                  trainroom: todaytrainlist[1],
                  settime: todaytrainlist[2]);
              return item;
            },
          ),
        ),
      ]),
    );
  }
}
