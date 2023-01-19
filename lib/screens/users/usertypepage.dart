/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-01-09 10:49:30
 * @LastEditTime: 2023-01-19 22:25:58
 * @Descripttion: 用户选择自己的类别，初始登陆后弹出
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import '../../config/peocdesign.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  bool _is_athlete = false;
  bool _is_coach = false;
  bool _is_amateur = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          )),
      body: Container(
        color: Colors.white,
        width: PEOCConfig.DESIGNEDWIDTH.w,
        height: PEOCConfig.DESIGNEDHEIGHT.h,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 309.h,
              left: -31.w,
              child: Image.asset(
                //按照设计稿显示的尺寸设置即可
                width: 352.w,
                height: 327.h,
                'asset/images/bkgRunMan.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 17.h,
              left: 29.w,
              child: PEOCText.easyText(
                text: "欢 迎 来 到 云 上 体 教",
                fontsize: 26.sp,
              ),
            ),
            Positioned(
              top: 53.h,
              left: 29.w,
              child: PEOCText.easyText(
                text: "请 选 择 符 合 您 的 类 别",
                fontsize: 16.sp,
              ),
            ),
            Positioned(
              top: 364.h,
              left: 23.w,
              child: Container(
                width: 330.w,
                height: 56.h,
                //alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: (_is_amateur | _is_athlete | _is_coach)
                      ? PEOCConfig.THEMECOLOR
                      : const Color.fromRGBO(89, 89, 89, 1),
                ),
                child: ElevatedButton(
                  //TODO:跳转到对应页面
                  onPressed: () {
                    if (_is_athlete) {
                      Get.offNamed('/athleteinfo');
                    }
                    if (_is_coach) {
                      Get.offNamed('/coachinfo');
                    }
                    if (_is_amateur) {
                      Get.offNamed('/amateurinfo');
                    }
                  },
                  style: ButtonStyle(
                    //去除阴影
                    elevation: MaterialStateProperty.all(0),
                    //将按钮背景设置为透明
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    "N  e  x  t       下  一  步",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(17),
                      color: Colors.white,
                      fontFamily: 'syhtFamily',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
            //运动员类别按钮
            Positioned(
              top: 194.h,
              left: 37.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _is_athlete = true;
                    _is_coach = false;
                    _is_amateur = false;
                  });
                },
                child: Container(
                  width: 66.w,
                  height: 66.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.sp,
                      color: _is_athlete
                          ? PEOCConfig.THEMECOLOR
                          : const Color.fromRGBO(196, 200, 204, 1),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    width: 38.w,
                    height: 38.h,
                    'asset/images/isAthlete.png',
                  ),
                ),
              ),
            ),
            //教练员类别按钮
            Positioned(
              top: 194.h,
              left: 156.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _is_coach = true;
                    _is_athlete = false;
                    _is_amateur = false;
                  });
                },
                child: Container(
                  width: 66.w,
                  height: 66.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.sp,
                      color: _is_coach
                          ? PEOCConfig.THEMECOLOR
                          : const Color.fromRGBO(196, 200, 204, 1),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 41.w,
                    width: 26.h,
                    child: Image.asset(
                      width: 41.w,
                      height: 26.h,
                      'asset/images/isCouch.png',
                    ),
                  ),
                ),
              ),
            ),
            //爱好者类别按钮
            Positioned(
              top: 194.h,
              left: 275.w,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _is_amateur = true;
                    _is_athlete = false;
                    _is_coach = false;
                  });
                },
                child: Container(
                  width: 66.w,
                  height: 66.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.sp,
                      color: _is_amateur
                          ? PEOCConfig.THEMECOLOR
                          : const Color.fromRGBO(196, 200, 204, 1),
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: SizedBox(
                    height: 41.w,
                    width: 41.h,
                    child: Image.asset(
                      width: 41.w,
                      height: 41.h,
                      'asset/images/isAmateur.png',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 276.h,
              left: 38.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '运  动  员',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: _is_athlete
                          ? PEOCConfig.THEMECOLOR
                          : const Color.fromRGBO(196, 196, 196, 1),
                      fontFamily: 'syhtFamily',
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(58.w, 0, 58.w, 0),
                    child: Text(
                      '教  练  员',
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(16),
                        color: _is_coach
                            ? PEOCConfig.THEMECOLOR
                            : const Color.fromRGBO(196, 196, 196, 1),
                        fontFamily: 'syhtFamily',
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  Text(
                    '爱  好  者',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      color: _is_amateur
                          ? PEOCConfig.THEMECOLOR
                          : const Color.fromRGBO(196, 196, 196, 1),
                      fontFamily: 'syhtFamily',
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 39.h,
              left: 155.w,
              child: PEOCButton.textButton(
                  msg: "暂 时 跳 过",
                  fontsize: 14.sp,
                  ontap: () {
                    //TODO
                    print('暂时跳过');
                    Get.offNamed('/main');
                  }),
            )
          ],
        ),
      ),
    );
  }
}
