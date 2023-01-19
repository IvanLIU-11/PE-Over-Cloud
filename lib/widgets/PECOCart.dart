/*
 * @Author: YJR-1100
 * @Date: 2022-12-03 18:41:11
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-12-03 19:06:09
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PECOCart.dart
 * @Description: 封装卡片
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PECOCart {
  static Widget newscart({
    required String imgurl,
    required String title,
    required String authorimg,
    required String author,
  }) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 103.h,
        color: Colors.yellow,
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
            width: 127.w,
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
}
