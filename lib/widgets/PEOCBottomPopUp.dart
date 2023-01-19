/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-01-18 21:41:39
 * @LastEditTime: 2023-01-19 11:36:30
 * @Descripttion: 本文件提供底部选项弹窗界面
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';

//选项前带图标的底部弹出选项框,传入选项字符列表，icon列表，和标题
Future<int?> showIconSelectWindow(
    context, List<String> options, List<Icon> optionsIcon, String title) async {
  return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
          ),
          height: (PEOCConfig.DESIGNEDHEIGHT / 2).h,
          child: Column(children: [
            SizedBox(
              height: 50,
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  Center(
                      child: PEOCText.easyText(text: title, fontsize: 16.sp)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            Divider(height: 1.h),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                    height: 45.h,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5.sp,
                            color: const Color.fromRGBO(177, 177, 177, 0.2)),
                      ),
                    ),
                    //padding: EdgeInsets.fromLTRB(135.w, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        //点击某个选项会关闭弹窗并带回该选项的index
                        Navigator.of(context).pop(index);
                      },
                      style: ButtonStyle(
                        //去除阴影
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          optionsIcon[index],
                          Container(
                            height: 21.h,
                            width: 60.w,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(12.w, 0, 0, 0),
                            child: PEOCText.easyText(
                                text: options[index],
                                fontsize: 16.sp,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                  // return ListTile(
                  //     leading: sportsIcon[index],
                  //     title: Text(sportsItem[index]),
                  //     onTap: () {
                  //       Navigator.of(context).pop(index);
                  //     });
                },
                itemCount: options.length,
              ),
            ),
          ]),
        );
      });
}

//无图标的底部弹出选项框，传入选项string列表，返回选择的选项index
Future<int?> showNonIconSelectWindow(
    context, List<String> options, String title) async {
  return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
          ),
          height: (PEOCConfig.DESIGNEDHEIGHT / 2).h,
          child: Column(children: [
            SizedBox(
              height: 50,
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  Center(
                      child: PEOCText.easyText(text: title, fontsize: 16.sp)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            Divider(height: 1.h),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                    height: 45.h,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5.sp,
                            color: const Color.fromRGBO(177, 177, 177, 0.2)),
                      ),
                    ),
                    //padding: EdgeInsets.fromLTRB(135.w, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        //点击某个选项会关闭弹窗并带回该选项的index
                        Navigator.of(context).pop(index);
                      },
                      style: ButtonStyle(
                        //去除阴影
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 21.h,
                            width: 60.w,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(12.w, 0, 0, 0),
                            child: PEOCText.easyText(
                                text: options[index],
                                fontsize: 16.sp,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: options.length,
              ),
            ),
          ]),
        );
      });
}

//无图标的自动生成选项的底部弹窗，指定选项数目，和起始偏移，和生成方向（正序或倒序），用以生成年份和日期选择
Future<int?> showAutoSelectWindow(
    context, int optionNum, int offset, String title, bool is_forward) async {
  return showModalBottomSheet<int>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
          ),
          height: (PEOCConfig.DESIGNEDHEIGHT / 2).h,
          child: Column(children: [
            SizedBox(
              height: 50,
              child: Stack(
                textDirection: TextDirection.rtl,
                children: [
                  Center(
                      child: PEOCText.easyText(text: title, fontsize: 16.sp)),
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
            Divider(height: 1.h),
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: PEOCConfig.DESIGNEDWIDTH.w,
                    height: 45.h,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                            width: 0.5.sp,
                            color: const Color.fromRGBO(177, 177, 177, 0.2)),
                      ),
                    ),
                    //padding: EdgeInsets.fromLTRB(135.w, 0, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        //点击某个选项会关闭弹窗并带回该选项的index
                        Navigator.of(context).pop(index);
                      },
                      style: ButtonStyle(
                        //去除阴影
                        elevation: MaterialStateProperty.all(0),
                        //将按钮背景设置为透明
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 21.h,
                            width: 60.w,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(12.w, 0, 0, 0),
                            child: PEOCText.easyText(
                                text: is_forward
                                    ? (offset + index).toString()
                                    : (offset - index).toString(),
                                fontsize: 16.sp,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: optionNum,
              ),
            ),
          ]),
        );
      });
}
