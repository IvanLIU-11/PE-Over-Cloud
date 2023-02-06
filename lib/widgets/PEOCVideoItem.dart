/*
 * @Author: YJR-1100
 * @Date: 2022-12-02 18:20:01
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 09:27:34
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCVideoItem.dart
 * @Description: 一些视频预览的卡片组件
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
// ignore: depend_on_referenced_packages

class PEOCVideoItem {
  static Widget homeItem(
      {required String lable,
      required Widget child,
      required Function() ontap}) {
    return InkWell(
        onTap: ontap,
        child: Container(
          width: 138.h,
          margin: EdgeInsets.only(right: 7.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 138.h,
                      height: 135.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 150, 81, 81), //背景色
                        borderRadius: BorderRadius.circular((12.r)), //圆角
                      ),
                      child: child,
                    ),
                    Positioned(
                        bottom: 8.h,
                        left: 8.h,
                        child: const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Color.fromARGB(255, 247, 247, 247),
                        ))
                  ],
                ),
                Container(
                  width: 138.h,
                  height: 18.h,
                  padding: EdgeInsets.only(
                    left: 2.w,
                  ),
                  child: PEOCText.easyText(
                      text: lable, fontsize: 12.sp, color: Colors.black),
                ),
              ]),
        ));
  }

  static Widget senderInfoCard(
      {required String authorimgurl,
      required String author,
      required String date}) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 15.r, // 设置半径
            backgroundImage: NetworkImage(authorimgurl),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.w),
            padding: EdgeInsets.zero,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PEOCText.easyText(
                    text: author,
                    fontsize: 14.sp,
                    textAlign: TextAlign.left,
                    fontFamily: "syhtMediumFamily",
                    // fontWeight: FontWeight.bold,
                  ),
                  // PEOCText.easyText(
                  //   text: date,
                  //   fontsize: 11.sp,
                  //   textAlign: TextAlign.left,
                  //   fontFamily: "syhtMediumFamily",
                  //   color: const Color.fromRGBO(189, 189, 189, 1),
                  // ),
                  Text(
                    date,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color.fromRGBO(189, 189, 189, 1),
                      fontFamily: "syhtLightFamily",
                      // height: 1.0,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ]),
          )
        ],
      ),
    );
  }

  static Widget relatedInfoCard(
      {required currentvideo,
      required List videoinfolist,
      required Function() ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 74.h,
                  width: 125.w,
                  child: Image.network(
                    currentvideo["imageurl"],
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 8.w),
                    height: 74.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              currentvideo['title'],
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "syhtRegularFamily",
                                fontWeight: FontWeight.bold,
                                leadingDistribution:
                                    TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 34.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.zero,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 8.r, // 设置半径
                                          backgroundImage: NetworkImage(
                                              currentvideo['authorimgurl']),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 5.w),
                                            child: Text(
                                              currentvideo['author'],
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black,
                                                fontFamily: "syhtLightFamily",
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even,
                                              ),
                                            ))
                                      ]),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    currentvideo['date'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color.fromRGBO(
                                          189, 189, 189, 1),
                                      fontFamily: "syhtLightFamily",
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
            const Divider(
              color: Color.fromRGBO(204, 204, 204, 1),
            ),
          ],
        ),
      ),
    );
  }

  static Widget videoMessageCard(messageinfo) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 85.h,
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 13.r, // 设置半径
                backgroundImage: NetworkImage(messageinfo['authorimgurl']),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.w),
                padding: EdgeInsets.zero,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PEOCText.easyText(
                        text: messageinfo['author'],
                        fontsize: 14.sp,
                        textAlign: TextAlign.left,
                        fontFamily: "syhtMediumFamily",
                      ),
                      Text(
                        messageinfo['date'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color.fromRGBO(189, 189, 189, 1),
                          fontFamily: "syhtLightFamily",
                          // height: 1.0,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.fromLTRB(26.r + 5.w, 10, 0, 5.h),
          child: PEOCText.richText(
              fontsize: 14.sp,
              linelenght: (PEOCConfig.DESIGNEDWIDTH - 41).w - 26.r - 5.w,
              color: const Color.fromRGBO(117, 117, 117, 1),
              text: messageinfo["message"],
              fontfamily: "syhtLightFamily"),
        ),
        const Divider(
          color: Color.fromRGBO(204, 204, 204, 1),
        ),
      ]),
    );
  }
}
