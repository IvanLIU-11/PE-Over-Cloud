/*
 * @Author: YJR-1100
 * @Date: 2022-11-26 10:51:21
 * @LastEditors: YJR-1100
 * @LastEditTime: 2022-11-28 14:58:18
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\toastDialog.dart
 * @Description: 消息弹框
 * 
 * Copyright (c) 2022 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';

void showmessage({required String msg, required double fontsize}) {
  Fluttertoast.cancel();

  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP, // 显示的位置
      timeInSecForIosWeb: 1, // 提示的时间，这个针对 ios，
      toastLength: Toast.LENGTH_SHORT, //　android 中这个可以配置显示的时间长短
      backgroundColor: PEOCConfig.THEMECOLOR, // 背景颜色
      textColor: Colors.white, // 字体颜色
      fontSize: fontsize // 字体大小
      );
}

// class MyDialog extends Dialog {
//   final String title;
//   final String content;
//   final Function? onTap;
//   const MyDialog(
//       {Key? key,
//       required this.title,
//       required this.content,
//       required this.onTap})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency, // 设置背景透明
//       child: Center(
//         // 包裹一个center组件，不然会全屏
//         child: Container(
//           height: 300,
//           width: 300,
//           color: Colors.white,
//           child: Column(children: [
//             Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Stack(children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(title),
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InkWell(
//                       // flutter中专门让点击的事件
//                       onTap: onTap,
//                       child: const Icon(Icons.close),
//                     ),
//                   ),
//                 ])),
//             const Divider(),
//             SizedBox(
//               width: double.infinity,
//               child: Text(content),
//             )
//           ]),
//         ),
//       ),
//     );
//   }
// }


// void _myDialog(){
//   showDialog(context:context,builder:(context){
//     return MyDialog(title:"提示",content:"我是内容"
//     onTap:(){
//       print("点了");
//     });
//   })
// }