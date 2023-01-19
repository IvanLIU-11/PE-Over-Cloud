/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-01-10 22:27:30
 * @LastEditTime: 2023-01-19 22:23:20
 * @Descripttion: 业余爱好者信息界面
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCBottomPopUp.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';

class AmateurInfoPage extends StatefulWidget {
  const AmateurInfoPage({super.key});

  @override
  State<AmateurInfoPage> createState() => _AmateurInfoPageState();
}

class _AmateurInfoPageState extends State<AmateurInfoPage> {
  //设计稿规范部分
  final double _leftPadding = 21.w;
  final double _rightPadding = 20.w;
  final double _bordercircular = 15.sp;
  final double _rowSpacing = 16.h;
  final double _titleButtonSpacing = 6.h;

  //各类信息
  bool _isMan = true;
  bool _isShoulderInjury = false;
  bool _isHandInjury = false;
  bool _isWaistInjury = false;
  bool _isLegInjury = false;
  bool _isFootInjury = false;
  bool _isOtherInjury = false;
  bool _isLikeBasketball = false;
  bool _isLikeFootball = false;
  bool _isLikeTianjin = false;
  bool _isLikeVolleyball = false;
  bool _isLikeSwim = false;
  bool _isLikeBadminton = false;
  bool _isLikePingpong = false;
  bool _isForJianZhi = false;
  bool _isForZenji = false;
  bool _isForHealthy = false;
  bool _isForOthers = false;
  bool _isNoExp = true;
  bool _is1To3Exp = false;
  bool _is3MoreExp = false;

  bool _isFinished = false;

  final FocusNode _fnname = FocusNode();
  final FocusNode _fnlocation = FocusNode();

  bool _isNameFocused = false;
  bool _isLocationFocused = false;

  final nameController = TextEditingController();
  final locationController = TextEditingController();

  //月份和对应的天数
  final List<String> _months = [
    '1 月',
    '2 月',
    '3 月',
    '4 月',
    '5 月',
    '6 月',
    '7 月',
    '8 月',
    '9 月',
    '10 月',
    '11 月',
    '12 月'
  ];
  List<int> _days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  //默认生日是2000/1/1, 2023 - 23 = 2000
  int yearsIndex = 23;
  int monthsIndex = 0;
  int daysIndex = 0;

  @override
  void initState() {
    super.initState();
    nameController.text = "";
    locationController.text = "";

    _fnname.addListener(() {
      if (_fnname.hasFocus) {
        setState(() {
          _isNameFocused = true;
        });
      } else {
        setState(() {
          _isNameFocused = false;
          _isFinished = nameController.text.isNotEmpty &
              locationController.text.isNotEmpty &
              (_isLikeBasketball |
                  _isLikeFootball |
                  _isLikeTianjin |
                  _isLikeVolleyball |
                  _isLikeSwim |
                  _isLikeBadminton |
                  _isLikePingpong);
        });
      }
    });

    _fnlocation.addListener(() {
      if (_fnlocation.hasFocus) {
        setState(() {
          _isLocationFocused = true;
        });
      } else {
        setState(() {
          _isLocationFocused = false;
          _isFinished = nameController.text.isNotEmpty &
              locationController.text.isNotEmpty &
              (_isLikeBasketball |
                  _isLikeFootball |
                  _isLikeTianjin |
                  _isLikeVolleyball |
                  _isLikeSwim |
                  _isLikeBadminton |
                  _isLikePingpong);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(64.h),
          child: AppBar(
              title: PEOCText.easyText(text: "爱好者注册", fontsize: 20.sp),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(
                height: 64.h,
                margin: EdgeInsets.fromLTRB(0, 16.h, 0, 8.h),
                // color: Colors.yellow,
                child: InkWell(
                  // 前面左侧的图标
                  child: SizedBox(
                    height: 40.w,
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                  onTap: () {
                    Get.offNamed('/usertype');
                  },
                ),
              ))),
      body: GestureDetector(
        onTap: () {
          //TODO:空白处
          _fnname.unfocus();
          _fnlocation.unfocus();
        },
        child: Container(
          width: PEOCConfig.DESIGNEDWIDTH.w,
          height: 730.h,
          color: Colors.white,
          child: Stack(alignment: Alignment.center, children: [
            Positioned(
              top: 309.h,
              left: -31.w,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  //按照设计稿显示的尺寸设置即可
                  width: 352.w,
                  height: 327.h,
                  'asset/images/bkgRunMan.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0.h,
              child: SizedBox(
                width: PEOCConfig.DESIGNEDWIDTH.w,
                height: 730.h,
                child: ListView(
                  children: [
                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 10.h,
                    ),

                    //提示信息
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 76.w,
                            height: 21.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                            child: PEOCText.easyText(
                              text: "姓名",
                              fontsize: 14.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 76.w,
                            height: 21.h,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(23.w, 0, 0, 0),
                            child: PEOCText.easyText(
                              text: "性别",
                              fontsize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //姓名输入框
                        Expanded(
                          child: Container(
                            height: 33.h,
                            padding: EdgeInsets.fromLTRB(
                                _leftPadding,
                                0,
                                (PEOCConfig.DESIGNEDWIDTH.w / 2) -
                                    _leftPadding -
                                    145.w,
                                0),
                            child: Container(
                              width: 145.w,
                              height: 33.h,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isNameFocused
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(17, 24, 39, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: TextField(
                                controller: nameController,
                                focusNode: _fnname,
                                style: TextStyle(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: "syhtFamily",
                                ),
                                decoration: const InputDecoration(
                                  isCollapsed: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //性别选择框
                        Expanded(
                          child: Container(
                            height: 33.h,
                            padding: EdgeInsets.fromLTRB(
                                (PEOCConfig.DESIGNEDWIDTH.w / 2) -
                                    145.w -
                                    _rightPadding,
                                0,
                                _rightPadding,
                                0),
                            child: Container(
                              width: 145.w,
                              height: 33.h,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          _isMan = true;
                                        });
                                      }),
                                      child: Container(
                                        width: 74.w,
                                        height: 33.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: _isMan
                                              ? const Color.fromRGBO(
                                                  17, 24, 39, 1)
                                              : Colors.white,
                                          border: Border.all(
                                            color: _isMan
                                                ? const Color.fromRGBO(
                                                    17, 24, 39, 1)
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          //一边圆角一边直角
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(
                                                  _bordercircular),
                                              right: Radius.zero),
                                        ),
                                        child: PEOCText.easyText(
                                          text: "男",
                                          fontsize: 14.sp,
                                          color: _isMan
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: (() {
                                        setState(() {
                                          _isMan = false;
                                        });
                                      }),
                                      child: Container(
                                        width: 74.w,
                                        height: 33.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: !_isMan
                                              ? const Color.fromRGBO(
                                                  17, 24, 39, 1)
                                              : Colors.white,
                                          border: Border.all(
                                            color: !_isMan
                                                ? const Color.fromRGBO(
                                                    17, 24, 39, 1)
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          //一边圆角一边直角
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(
                                                  _bordercircular),
                                              left: Radius.zero),
                                        ),
                                        child: PEOCText.easyText(
                                          text: "女",
                                          fontsize: 14.sp,
                                          color: !_isMan
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: PEOCText.easyText(text: "出生日期", fontsize: 14.sp),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    //出生日期选择按钮
                    Container(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 33.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //年份选择按钮
                          GestureDetector(
                            onTap: () async {
                              int? selectedIndex = await showAutoSelectWindow(
                                  context, 124, 2023, "出生年份", false);
                              if (selectedIndex != null) {
                                //如果点击叉号不会返回数字，所以判空一下
                                setState(() {
                                  yearsIndex = selectedIndex;
                                });
                              }
                            },
                            child: Container(
                              width: 80.w,
                              height: 33.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  border: Border.all(
                                    color: const Color.fromRGBO(17, 24, 39, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80.w,
                                height: 21.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PEOCText.easyText(
                                        text: (2023 - yearsIndex).toString(),
                                        fontsize: 14.sp,
                                        color: Colors.white),
                                    PEOCText.easyText(
                                        text: "年",
                                        fontsize: 13.sp,
                                        color: PEOCConfig.THEMECOLOR),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                            height: 30.h,
                          ),
                          //月份选择按钮
                          GestureDetector(
                            onTap: () async {
                              int? selectedIndex =
                                  await showNonIconSelectWindow(
                                      context, _months, "出生月份");
                              if (selectedIndex != null) {
                                //如果点击叉号不会返回数字，所以判空一下
                                setState(() {
                                  monthsIndex = selectedIndex;
                                });
                              }
                            },
                            child: Container(
                              width: 80.w,
                              height: 33.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  border: Border.all(
                                    color: const Color.fromRGBO(17, 24, 39, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80.w,
                                height: 21.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PEOCText.easyText(
                                        text: (monthsIndex + 1).toString(),
                                        fontsize: 14.sp,
                                        color: Colors.white),
                                    PEOCText.easyText(
                                        text: "月",
                                        fontsize: 13.sp,
                                        color: PEOCConfig.THEMECOLOR),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.w,
                            height: 30.h,
                          ),
                          //日期选择按钮
                          GestureDetector(
                            onTap: () async {
                              if ((2023 - yearsIndex) % 4 == 0) {
                                if ((2023 - yearsIndex) % 100 == 0) {
                                  if ((2023 - yearsIndex) % 400 == 0) {
                                    //是闰年，二月多一天
                                    _days[1] = 29;
                                  } else {
                                    _days[1] = 28;
                                  }
                                } else {
                                  //是闰年，二月多一天
                                  _days[1] = 29;
                                }
                              } else {
                                _days[1] = 28;
                              }
                              int? selectedIndex = await showAutoSelectWindow(
                                  context, _days[monthsIndex], 1, "出生日期", true);
                              if (selectedIndex != null) {
                                //如果点击叉号不会返回数字，所以判空一下
                                setState(() {
                                  daysIndex = selectedIndex;
                                });
                              }
                            },
                            child: Container(
                              width: 80.w,
                              height: 33.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  border: Border.all(
                                    color: const Color.fromRGBO(17, 24, 39, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 80.w,
                                height: 21.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    PEOCText.easyText(
                                        text: (daysIndex + 1).toString(),
                                        fontsize: 14.sp,
                                        color: Colors.white),
                                    PEOCText.easyText(
                                        text: "日",
                                        fontsize: 13.sp,
                                        color: PEOCConfig.THEMECOLOR),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: PEOCText.easyText(text: "爱好项目", fontsize: 14.sp),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    Column(
                      //爱好项目
                      children: [
                        Container(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 33.h,
                          padding: EdgeInsets.fromLTRB(
                              _leftPadding, 0, _rightPadding, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                //篮球
                                onTap: () {
                                  setState(() {
                                    _isLikeBasketball = !_isLikeBasketball;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeBasketball
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeBasketball
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.basketball,
                                        color: _isLikeBasketball
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "篮 球",
                                          fontsize: 14.sp,
                                          color: _isLikeBasketball
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //足球
                                onTap: () {
                                  setState(() {
                                    _isLikeFootball = !_isLikeFootball;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeFootball
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeFootball
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.football,
                                        color: _isLikeFootball
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "足 球",
                                          fontsize: 14.sp,
                                          color: _isLikeFootball
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //田径
                                onTap: () {
                                  setState(() {
                                    _isLikeTianjin = !_isLikeTianjin;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeTianjin
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeTianjin
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.trackAndField,
                                        color: _isLikeTianjin
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "田 径",
                                          fontsize: 14.sp,
                                          color: _isLikeTianjin
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //排球
                                onTap: () {
                                  setState(() {
                                    _isLikeVolleyball = !_isLikeVolleyball;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeVolleyball
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeVolleyball
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.volleyball,
                                        color: _isLikeVolleyball
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "排 球",
                                          fontsize: 14.sp,
                                          color: _isLikeVolleyball
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 10.h,
                        ),
                        SizedBox(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 33.h,
                          //padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                //游泳
                                onTap: () {
                                  setState(() {
                                    _isLikeSwim = !_isLikeSwim;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeSwim
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeSwim
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.swim,
                                        color: _isLikeSwim
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "游 泳",
                                          fontsize: 14.sp,
                                          color: _isLikeSwim
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //羽毛球
                                onTap: () {
                                  setState(() {
                                    _isLikeBadminton = !_isLikeBadminton;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikeBadminton
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikeBadminton
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.badminton1,
                                        color: _isLikeBadminton
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "羽 毛 球",
                                          fontsize: 14.sp,
                                          color: _isLikeBadminton
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //乒乓球
                                onTap: () {
                                  setState(() {
                                    _isLikePingpong = !_isLikePingpong;
                                    _isFinished =
                                        nameController.text.isNotEmpty &
                                            locationController.text.isNotEmpty &
                                            (_isLikeBasketball |
                                                _isLikeFootball |
                                                _isLikeTianjin |
                                                _isLikeVolleyball |
                                                _isLikeSwim |
                                                _isLikeBadminton |
                                                _isLikePingpong);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 80.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLikePingpong
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLikePingpong
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        PEOCiconFont.pingpang,
                                        color: _isLikePingpong
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        size: 15.sp,
                                      ),
                                      Container(
                                        height: 21.h,
                                        width: 50.w,
                                        alignment: Alignment.center,
                                        child: PEOCText.easyText(
                                          text: "乒 乓 球",
                                          fontsize: 14.sp,
                                          color: _isLikePingpong
                                              ? Colors.white
                                              : const Color.fromRGBO(
                                                  177, 177, 177, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: Row(
                        children: [
                          PEOCText.easyText(text: "运动原因", fontsize: 14.sp),
                          PEOCText.easyText(
                            text: "(可多选)",
                            fontsize: 12.sp,
                            color: const Color.fromRGBO(177, 177, 177, 1),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    //运动员证书选择按钮
                    Container(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 33.h,
                      padding: EdgeInsets.fromLTRB(
                          _leftPadding, 0, _rightPadding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //减脂
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isForJianZhi = !_isForJianZhi;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 70.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _isForJianZhi
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isForJianZhi
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "减脂",
                                fontsize: 14.sp,
                                color: _isForJianZhi
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                          //增肌
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isForZenji = !_isForZenji;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 70.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _isForZenji
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isForZenji
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "增肌",
                                fontsize: 14.sp,
                                color: _isForZenji
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                          //健康
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isForHealthy = !_isForHealthy;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 80.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _isForHealthy
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isForHealthy
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "保持健康",
                                fontsize: 14.sp,
                                color: _isForHealthy
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                          //其他
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isForOthers = !_isForOthers;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 70.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _isForOthers
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isForOthers
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "其他",
                                fontsize: 14.sp,
                                color: _isForOthers
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: PEOCText.easyText(text: "运动经历", fontsize: 14.sp),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    //运动经历选择按钮
                    Container(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 33.h,
                      padding: EdgeInsets.fromLTRB(
                          _leftPadding, 0, _rightPadding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //无经验按钮
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNoExp = true;
                                _is1To3Exp = false;
                                _is3MoreExp = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _isNoExp
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _isNoExp
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "无经验",
                                fontsize: 14.sp,
                                color: _isNoExp
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                          //1-3年经验
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNoExp = false;
                                _is1To3Exp = true;
                                _is3MoreExp = false;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _is1To3Exp
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _is1To3Exp
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "1 - 3 年",
                                fontsize: 14.sp,
                                color: _is1To3Exp
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                          //3年以上按钮
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isNoExp = false;
                                _is1To3Exp = false;
                                _is3MoreExp = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 100.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: _is3MoreExp
                                      ? PEOCConfig.THEMECOLOR
                                      : Colors.transparent,
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: _is3MoreExp
                                        ? PEOCConfig.THEMECOLOR
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                text: "3年以上",
                                fontsize: 14.sp,
                                color: _is3MoreExp
                                    ? Colors.white
                                    : const Color.fromRGBO(177, 177, 177, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: PEOCText.easyText(text: "所在地区", fontsize: 14.sp),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    Container(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 33.h,
                      padding: EdgeInsets.fromLTRB(
                          _leftPadding, 0, _rightPadding, 0),
                      child: Container(
                        width: 334.w,
                        height: 33.h,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              //选中与否决定边框颜色
                              color: _isLocationFocused
                                  ? PEOCConfig.THEMECOLOR
                                  : const Color.fromRGBO(17, 24, 39, 1),
                              width: ScreenUtil().setSp(1),
                            ),
                            borderRadius:
                                BorderRadius.circular(_bordercircular)),
                        child: TextField(
                          controller: locationController,
                          focusNode: _fnlocation,
                          style: TextStyle(
                            color: const Color.fromRGBO(17, 24, 39, 1),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            fontFamily: "syhtFamily",
                          ),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _rowSpacing,
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 21.h,
                      padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                      child: Row(
                        children: [
                          PEOCText.easyText(text: "有无伤病", fontsize: 14.sp),
                          PEOCText.easyText(
                              text: "(可多选)",
                              fontsize: 12.sp,
                              color: const Color.fromRGBO(177, 177, 177, 1)),
                        ],
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: _titleButtonSpacing,
                    ),

                    Column(
                      //伤病按钮
                      children: [
                        Container(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 33.h,
                          padding: EdgeInsets.fromLTRB(
                              _leftPadding, 0, _rightPadding, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                //肩部伤病
                                onTap: () {
                                  setState(() {
                                    _isShoulderInjury = !_isShoulderInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isShoulderInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isShoulderInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                    text: "肩 部",
                                    fontsize: 14.sp,
                                    color: _isShoulderInjury
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //手部伤病
                                onTap: () {
                                  setState(() {
                                    _isHandInjury = !_isHandInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isHandInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isHandInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                      text: "手 部",
                                      fontsize: 14.sp,
                                      color: _isHandInjury
                                          ? Colors.white
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1)),
                                ),
                              ),
                              GestureDetector(
                                //腰部伤病
                                onTap: () {
                                  setState(() {
                                    _isWaistInjury = !_isWaistInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isWaistInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isWaistInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                    text: "腰 部",
                                    fontsize: 14.sp,
                                    color: _isWaistInjury
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //腿膝部伤病
                                onTap: () {
                                  setState(() {
                                    _isLegInjury = !_isLegInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 82.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isLegInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isLegInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                    text: "腿 膝 部",
                                    fontsize: 14.sp,
                                    color: _isLegInjury
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 10.h,
                        ),
                        Container(
                          width: PEOCConfig.DESIGNEDWIDTH.w,
                          height: 33.h,
                          padding:
                              EdgeInsets.fromLTRB(_leftPadding, 0, 199.w, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                //脚部伤病
                                onTap: () {
                                  setState(() {
                                    _isFootInjury = !_isFootInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isFootInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isFootInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                    text: "脚 部",
                                    fontsize: 14.sp,
                                    color: _isFootInjury
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //其他伤病
                                onTap: () {
                                  setState(() {
                                    _isOtherInjury = !_isOtherInjury;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: _isOtherInjury
                                          ? PEOCConfig.THEMECOLOR
                                          : Colors.transparent,
                                      border: Border.all(
                                        //选中与否决定边框颜色
                                        color: _isOtherInjury
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: PEOCText.easyText(
                                    text: "其 他",
                                    fontsize: 14.sp,
                                    color: _isOtherInjury
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 40.h,
                    ),

                    Container(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 60.h,
                      padding: EdgeInsets.fromLTRB(
                          _leftPadding, 0, _rightPadding, 0),
                      child: //下一步按钮
                          Container(
                        width: 334.w,
                        height: 60.h,

                        //alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.sp),
                          color: _isFinished
                              ? PEOCConfig.THEMECOLOR
                              : const Color.fromRGBO(89, 89, 89, 1),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            //TODO:跳到主页
                            if (_isFinished) {
                              print("下一步");
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
                            "完               成",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              color: Colors.white,
                              fontFamily: 'syhtFamily',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 80.h,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fnname.dispose();
    _fnlocation.dispose();
    nameController.dispose();
    locationController.dispose();
  }
}
