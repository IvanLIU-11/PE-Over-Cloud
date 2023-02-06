/*
 * @Author: YJR-1100
 * @Date: 2023-02-01 10:37:10
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 11:59:26
 * @FilePath: \PE-Over-Cloud\Client\lib\utilities\homepage.dart
 * @Description: 获取主页需要的信息
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/widgets/PEOCVideoItem.dart';

// 获取轮播图图片
getSwiperimg() {
  List<Map> imgList = [
    {
      "url":
          "https://x0.ifengimg.com/ucms/2022_03/2F2A63CAC628C58BD947E534A97AFB01EFF6D307_size2825_w4096_h2731.jpg"
    },
    {
      "url":
          "https://picx.zhimg.com/v2-78558a8574af881d9199dd5957400213_1440w.jpg"
    },
    {
      "url":
          "https://pics5.baidu.com/feed/6159252dd42a283431f3aaaf0e0f99ed14cebf7a.jpeg"
    },
  ];
  return imgList;
}

// 获取中考体育教学视频
Future<dynamic> getVideoUrl() async {
  List videoList = [
    {
      "vid": "1",
      "imageurl":
          "https://p2.itc.cn/q_70/images03/20210921/e8fb04c573d74813a770436789067b3d.jpeg",
      "title": "跳远教学视频",
      "description":
          "视频视频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当\n频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学\n频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学",
      "videourl":
          "https://v.06dn.com/api/v3/slave/source/0/L3VwbG9hZHMvMS8yMDIzMDIvMDEvMV9vd3NJczBhOF9sb25nIGp1bXAxLm1wNA/long%20jump1.mp4?sign=yxNhU02PMaqw9hxc-wv_DMv_F53H1yUf7-NSwJVYbYM%3D%3A0",
      "videotime": "01:00",
      "playtimes": "1000",
      "author": "云上体教",
      "authorimgurl": "https://www.itying.com/themes/itying/images/ionic1.png",
      "date": "2021.7.14 08:32 发表于湖南"
    },
    {
      "vid": "2",
      "imageurl": "https://s2.loli.net/2023/02/03/mtvwBAEjWhrluJy.jpg",
      "title": "实心球教学视频",
      "description":
          "我有一个全屏的Flutter应用程序。\n但是问题是当用户触摸屏幕时，出现顶部状态栏，或者当用户触摸文本字段时，出现底部状态栏和顶部状态栏。",
      "videourl":
          "https://v.06dn.com/api/v3/slave/source/0/L3VwbG9hZHMvMS8yMDIzMDIvMDEvMV9uM1E4aWRsZF9zb2xpZCBzcGhlcmVfMS5tcDQ/solid%20sphere_1.mp4?sign=knIXriRNNxe2zBgzMgegJAwaeCrVqdZuj14jjkDroNk%3D%3A0",
      "videotime": "03:34",
      "playtimes": "100",
      "author": "云上体教",
      "authorimgurl": "https://www.itying.com/themes/itying/images/ionic3.png",
      "date": "2021.7.14 08:32 发表于湖南"
    },
    {
      "vid": "3",
      "imageurl":
          "https://p8.itc.cn/q_70/images03/20210729/c0f5f8e841ed4c9280e922817be06862.jpeg",
      "title": "跳绳",
      "description": "视频简介",
      "videourl":
          "https://v.06dn.com/api/v3/slave/source/0/L3VwbG9hZHMvMS8yMDIzMDIvMDEvMV9tT0ZXc25Hdl9yb3BlIHNraXBwaW5nXzEubXA0/rope%20skipping_1.mp4?sign=AUHO2EzH7Yxm7etdcgBdaPLZL49GtzkcKKvTrcEmIzw%3D%3A0",
      "videotime": "08:34",
      "playtimes": "1.4万",
      "author": "云上体教",
      "authorimgurl": "https://www.itying.com/themes/itying/images/ionic4.png",
      "date": "2021.7.14 08:32 发表于湖南"
    },
  ];
  return Future(() => videoList);
}

List<Widget> getHomeItemList(List videoinfolist) {
  List<Widget> videoItemList = [];
  for (var element in videoinfolist) {
    videoItemList.add(PEOCVideoItem.homeItem(
        lable: element['title'],
        child: Image.network(
          element['imageurl'],
          fit: BoxFit.cover,
        ),
        ontap: () => Get.toNamed('/videoplayer', arguments: {
              "currentvideo": element,
              "videoinfolist": videoinfolist
            })));
  }
  return videoItemList;
}
