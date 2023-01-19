/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-01-10 22:26:39
 * @LastEditTime: 2023-01-19 22:22:51
 * @Descripttion: 教练员信息界面
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/utilities/getpicture.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCBottomPopUp.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:pe_over_cloud/widgets/toastDialog.dart';

class CoachInfoPage extends StatefulWidget {
  const CoachInfoPage({super.key});

  @override
  State<CoachInfoPage> createState() => _CoachInfoPageState();
}

class _CoachInfoPageState extends State<CoachInfoPage> {
  //设计稿规范部分
  final double _leftPadding = 21.w;
  final double _rightPadding = 20.w;
  final double _bordercircular = 15.sp;
  final double _rowSpacing = 16.h;
  final double _titleButtonSpacing = 6.h;

  int resultNum = 0;
  //运动项目
  final List<String> _sportsItem = [
    "羽 毛 球",
    "乒 乓 球",
    "游 泳",
    "田 径",
    "篮 球",
    "足 球",
    "排 球"
  ];
  //运动项目对应的图标
  final List<Icon> _sportsIcon = [
    Icon(
      PEOCiconFont.badminton1,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.pingpang,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.swim,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.trackAndField,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.basketball,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.football,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
    Icon(
      PEOCiconFont.volleyball,
      color: PEOCConfig.THEMECOLOR,
      size: 15.sp,
    ),
  ];

  //学历级别
  final List<String> _educationItem = [
    "小 学",
    "初 中",
    "高 中",
    "本 科",
    "硕 士",
    "博 士",
  ];
  //代表选择的学历，默认是本科，3
  int educationIndex = 3;

  //代表选择第几个项目，默认为0，羽毛球
  int sportItemIndex = 0;

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

  //选中的图片路径
  String _athletePhotoPath = "";
  String _coachPhotoPath = "";
  String _refereePhotoPath = "";

  //默认生日是2000/1/1, 2023 - 23 = 2000
  int yearsIndex = 23;
  int monthsIndex = 0;
  int daysIndex = 0;

  final FocusNode _fnname = FocusNode();
  final FocusNode _fnschool = FocusNode();
  final FocusNode _fneduyears = FocusNode();
  final FocusNode _fnlocation = FocusNode();
  final FocusNode _fnfirstresult = FocusNode();
  final FocusNode _fnsecondresult = FocusNode();
  final FocusNode _fnthirdresult = FocusNode();
  final FocusNode _fnfourthresult = FocusNode();
  final FocusNode _fnfifthresult = FocusNode();

  bool _isNameFocused = false;
  bool _isSchoolFocused = false;
  bool _isEduYearsFocused = false;
  bool _isLocationFocused = false;
  bool _isFirstResultFocused = false;
  bool _isSecondResultFocused = false;
  bool _isThirdResultFocused = false;
  bool _isFourthResultFocused = false;
  bool _isFifthResultFocused = false;

  //各类信息
  bool _isMan = true;
  bool _isPersonalTrain = true;
  bool _isSchoolTrain = false;
  bool _isProfessionalTrain = false;
  bool _isPersonalCoach = true;
  bool _isSchoolCoach = false;
  bool _isProfessionalCoach = false;
  bool _isGetAthleteCertificate = false;
  bool _isGetCoachCertificate = false;
  bool _isGetRefereeCertificate = false;
  bool _isFirstGradeAthlete = true;
  bool _isSecondGradeAthlete = false;
  bool _isMasterSportMan = false;
  bool _isFirstGradeCoach = true;
  bool _isSecondGradeCoach = false;
  bool _isThirdGradeCoach = false;
  bool _isShoulderInjury = false;
  bool _isHandInjury = false;
  bool _isWaistInjury = false;
  bool _isLegInjury = false;
  bool _isFootInjury = false;
  bool _isOtherInjury = false;
  bool _isUploadAthletePhoto = false;
  bool _isUploadCoachPhoto = false;
  bool _isUploadRefereePhoto = false;

  bool _isFinished = false;

  final nameController = TextEditingController();
  final eduyearsController = TextEditingController();
  final schoolController = TextEditingController();
  final locationController = TextEditingController();
  final firstresultController = TextEditingController();
  final secondresultController = TextEditingController();
  final thirdresultController = TextEditingController();
  final fourthresultController = TextEditingController();
  final fifthresultController = TextEditingController();

  //重大赛事成绩的文本控制器数组
  //late List<TextEditingController> _resultsControllers;
  // ignore: prefer_final_fields
  var _resultsControllers = [];

  @override
  void initState() {
    super.initState();
    nameController.text = "";
    eduyearsController.text = "";
    schoolController.text = "";
    locationController.text = "";
    firstresultController.text = "";
    secondresultController.text = "";
    thirdresultController.text = "";
    fourthresultController.text = "";
    fifthresultController.text = "";

    _resultsControllers.add(firstresultController);
    _resultsControllers.add(secondresultController);
    _resultsControllers.add(thirdresultController);
    _resultsControllers.add(fourthresultController);
    _resultsControllers.add(fifthresultController);

    //焦点添加监听器相应焦点变化
    _fnname.addListener(() {
      if (_fnname.hasFocus) {
        setState(() {
          _isNameFocused = true;
        });
      } else {
        setState(() {
          _isNameFocused = false;
          _isFinished = nameController.text.isNotEmpty &
              eduyearsController.text.isNotEmpty &
              schoolController.text.isNotEmpty &
              locationController.text.isNotEmpty;
        });
      }
    });

    _fneduyears.addListener(() {
      if (_fneduyears.hasFocus) {
        setState(() {
          _isEduYearsFocused = true;
        });
      } else {
        setState(() {
          _isEduYearsFocused = false;
          _isFinished = nameController.text.isNotEmpty &
              eduyearsController.text.isNotEmpty &
              schoolController.text.isNotEmpty &
              locationController.text.isNotEmpty;
        });
      }
    });

    _fnschool.addListener(() {
      if (_fnschool.hasFocus) {
        setState(() {
          _isSchoolFocused = true;
        });
      } else {
        setState(() {
          _isSchoolFocused = false;
          _isFinished = nameController.text.isNotEmpty &
              eduyearsController.text.isNotEmpty &
              schoolController.text.isNotEmpty &
              locationController.text.isNotEmpty;
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
              eduyearsController.text.isNotEmpty &
              schoolController.text.isNotEmpty &
              locationController.text.isNotEmpty;
        });
      }
    });

    _fnfirstresult.addListener(() {
      if (_fnfirstresult.hasFocus) {
        setState(() {
          _isFirstResultFocused = true;
        });
      } else {
        setState(() {
          _isFirstResultFocused = false;
        });
      }
    });

    _fnsecondresult.addListener(() {
      if (_fnsecondresult.hasFocus) {
        setState(() {
          _isSecondResultFocused = true;
        });
      } else {
        setState(() {
          _isSecondResultFocused = false;
        });
      }
    });

    _fnthirdresult.addListener(() {
      if (_fnthirdresult.hasFocus) {
        setState(() {
          _isThirdResultFocused = true;
        });
      } else {
        setState(() {
          _isThirdResultFocused = false;
        });
      }
    });

    _fnfourthresult.addListener(() {
      if (_fnfourthresult.hasFocus) {
        setState(() {
          _isFourthResultFocused = true;
        });
      } else {
        setState(() {
          _isFourthResultFocused = false;
        });
      }
    });

    _fnfifthresult.addListener(() {
      if (_fnfifthresult.hasFocus) {
        setState(() {
          _isFifthResultFocused = true;
        });
      } else {
        setState(() {
          _isFifthResultFocused = false;
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
              title: PEOCText.easyText(text: "教练员注册", fontsize: 20.sp),
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
          //点击空白处反应
          _fnname.unfocus();
          _fneduyears.unfocus();
          _fnschool.unfocus();
          _fnlocation.unfocus();
          _fnfirstresult.unfocus();
          _fnsecondresult.unfocus();
          _fnthirdresult.unfocus();
          _fnfourthresult.unfocus();
          _fnfifthresult.unfocus();
        },
        child: Container(
          width: PEOCConfig.DESIGNEDWIDTH.w,
          height: 730.h,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
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
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
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
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                            borderRadius:
                                                BorderRadius.horizontal(
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
                                      color:
                                          const Color.fromRGBO(17, 24, 39, 1),
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
                                      color:
                                          const Color.fromRGBO(17, 24, 39, 1),
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
                                    context,
                                    _days[monthsIndex],
                                    1,
                                    "出生日期",
                                    true);
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
                                      color:
                                          const Color.fromRGBO(17, 24, 39, 1),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 76.w,
                              height: 21.h,
                              alignment: Alignment.centerLeft,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: PEOCText.easyText(
                                text: "运动项目",
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
                                text: "从事教育行业年限",
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
                          //运动项目选择框
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
                              alignment: Alignment.center,
                              child: GestureDetector(
                                //点击按钮弹出项目选框
                                onTap: () async {
                                  int? selectedIndex =
                                      await showIconSelectWindow(context,
                                          _sportsItem, _sportsIcon, "运动项目");
                                  if (selectedIndex != null) {
                                    //如果点击叉号不会返回数字，所以判空一下
                                    setState(() {
                                      sportItemIndex = selectedIndex;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 145.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(17, 24, 39, 1),
                                      border: Border.all(
                                        color:
                                            const Color.fromRGBO(17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80.w,
                                    height: 21.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _sportsIcon[sportItemIndex],
                                        Container(
                                          height: 21.h,
                                          width: 50.w,
                                          alignment: Alignment.centerLeft,
                                          // margin:
                                          //     EdgeInsets.fromLTRB(12.w, 0, 0, 0),
                                          child: PEOCText.easyText(
                                              text: _sportsItem[sportItemIndex],
                                              fontsize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //从事教育行业年限输入框
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
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isEduYearsFocused
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(17, 24, 39, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: eduyearsController,
                                        focusNode: _fneduyears,
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              17, 24, 39, 1),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "syhtFamily",
                                        ),
                                        decoration: const InputDecoration(
                                          isCollapsed: true,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    PEOCText.easyText(
                                        text: "年",
                                        fontsize: 14.sp,
                                        color: PEOCConfig.THEMECOLOR),
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
                        child: PEOCText.easyText(text: "教练类别", fontsize: 14.sp),
                      ),

                      SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _titleButtonSpacing,
                      ),

                      //教练类别选择按钮
                      Container(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: 33.h,
                        padding: EdgeInsets.fromLTRB(
                            _leftPadding, 0, _rightPadding, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //业余教练员按钮
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalCoach = true;
                                  _isSchoolCoach = false;
                                  _isProfessionalCoach = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isPersonalCoach
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isPersonalCoach
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "业余教练",
                                  fontsize: 14.sp,
                                  color: _isPersonalCoach
                                      ? Colors.white
                                      : const Color.fromRGBO(177, 177, 177, 1),
                                ),
                              ),
                            ),
                            //体校教练
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalCoach = false;
                                  _isSchoolCoach = true;
                                  _isProfessionalCoach = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isSchoolCoach
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isSchoolCoach
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "体校教练",
                                  fontsize: 14.sp,
                                  color: _isSchoolCoach
                                      ? Colors.white
                                      : const Color.fromRGBO(177, 177, 177, 1),
                                ),
                              ),
                            ),
                            //专业队教练按钮
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalCoach = false;
                                  _isSchoolCoach = false;
                                  _isProfessionalCoach = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isProfessionalCoach
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isProfessionalCoach
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "专业队教练",
                                  fontsize: 14.sp,
                                  color: _isProfessionalCoach
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
                        child:
                            PEOCText.easyText(text: "教练队伍类型", fontsize: 14.sp),
                      ),

                      SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _titleButtonSpacing,
                      ),

                      //教练队伍类型选择按钮
                      Container(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: 33.h,
                        padding: EdgeInsets.fromLTRB(
                            _leftPadding, 0, _rightPadding, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //个人教练按钮
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalTrain = true;
                                  _isSchoolTrain = false;
                                  _isProfessionalTrain = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isPersonalTrain
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isPersonalTrain
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "个体教练队",
                                  fontsize: 14.sp,
                                  color: _isPersonalTrain
                                      ? Colors.white
                                      : const Color.fromRGBO(177, 177, 177, 1),
                                ),
                              ),
                            ),
                            //体校训练队按钮
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalTrain = false;
                                  _isSchoolTrain = true;
                                  _isProfessionalTrain = false;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isSchoolTrain
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isSchoolTrain
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "体校训练队",
                                  fontsize: 14.sp,
                                  color: _isSchoolTrain
                                      ? Colors.white
                                      : const Color.fromRGBO(177, 177, 177, 1),
                                ),
                              ),
                            ),
                            //专业队按钮
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPersonalTrain = false;
                                  _isSchoolTrain = false;
                                  _isProfessionalTrain = true;
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 100.w,
                                height: 33.h,
                                decoration: BoxDecoration(
                                    color: _isProfessionalTrain
                                        ? PEOCConfig.THEMECOLOR
                                        : Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isProfessionalTrain
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: PEOCText.easyText(
                                  text: "专业队",
                                  fontsize: 14.sp,
                                  color: _isProfessionalTrain
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
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: PEOCText.easyText(
                                text: "毕业或所在院校",
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
                                text: "学历",
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
                          //学校输入框
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
                                    color: Colors.transparent,
                                    border: Border.all(
                                      //选中与否决定边框颜色
                                      color: _isSchoolFocused
                                          ? PEOCConfig.THEMECOLOR
                                          : const Color.fromRGBO(17, 24, 39, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(_bordercircular)),
                                child: TextField(
                                  controller: schoolController,
                                  focusNode: _fnschool,
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
                          //学历选择框
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
                              child: GestureDetector(
                                //点击按钮弹出学历选框
                                onTap: () async {
                                  int? selectedIndex =
                                      await showNonIconSelectWindow(
                                          context, _educationItem, "学历情况");
                                  if (selectedIndex != null) {
                                    //如果点击叉号不会返回数字，所以判空一下
                                    setState(() {
                                      educationIndex = selectedIndex;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 145.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(17, 24, 39, 1),
                                      border: Border.all(
                                        color:
                                            const Color.fromRGBO(17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 80.w,
                                    height: 21.h,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 21.h,
                                          width: 50.w,
                                          alignment: Alignment.center,
                                          // margin:
                                          //     EdgeInsets.fromLTRB(12.w, 0, 0, 0),
                                          child: PEOCText.easyText(
                                              text: _educationItem[
                                                  educationIndex],
                                              fontsize: 14.sp,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
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
                        child:
                            PEOCText.easyText(text: "教练员归属地", fontsize: 14.sp),
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
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
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
                        child: PEOCText.easyText(
                            text: "是否获得运动员证书", fontsize: 14.sp),
                      ),

                      SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _titleButtonSpacing,
                      ),

                      //是否获得运动员证书选择框
                      Container(
                        height: 33.h,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: Container(
                          width: 145.w,
                          height: 33.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetAthleteCertificate = true;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _isGetAthleteCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: _isGetAthleteCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(_bordercircular),
                                        right: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "是",
                                    fontsize: 14.sp,
                                    color: _isGetAthleteCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetAthleteCertificate = false;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !_isGetAthleteCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: !_isGetAthleteCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(_bordercircular),
                                        left: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "否",
                                    fontsize: 14.sp,
                                    color: !_isGetAthleteCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //运动员证书等级和上传运动员证书图片，选择获得运动员证书才出现
                      Visibility(
                        visible: _isGetAthleteCertificate,
                        child: Column(
                          children: [
                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _rowSpacing,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 21.h,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: PEOCText.easyText(
                                  text: "运动员证书等级", fontsize: 14.sp),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //一级按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeAthlete = true;
                                        _isSecondGradeAthlete = false;
                                        _isMasterSportMan = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isFirstGradeAthlete
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isFirstGradeAthlete
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "一级",
                                        fontsize: 14.sp,
                                        color: _isFirstGradeAthlete
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                      ),
                                    ),
                                  ),
                                  //二级按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeAthlete = false;
                                        _isSecondGradeAthlete = true;
                                        _isMasterSportMan = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isSecondGradeAthlete
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isSecondGradeAthlete
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "二级",
                                        fontsize: 14.sp,
                                        color: _isSecondGradeAthlete
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                      ),
                                    ),
                                  ),
                                  //运动健将按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeAthlete = false;
                                        _isSecondGradeAthlete = false;
                                        _isMasterSportMan = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isMasterSportMan
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isMasterSportMan
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "运动健将",
                                        fontsize: 14.sp,
                                        color: _isMasterSportMan
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
                              height: _rowSpacing,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 21.h,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: Row(
                                children: [
                                  PEOCText.easyText(
                                      text: "上传运动员证书", fontsize: 14.sp),
                                  PEOCText.easyText(
                                      text: "(选填)",
                                      fontsize: 12.sp,
                                      color: const Color.fromRGBO(
                                          177, 177, 177, 1)),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _titleButtonSpacing,
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: 334.w,
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(177, 177, 177, 0.4),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        177, 177, 177, 0.4),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: GestureDetector(
                                onTap: () {
                                  //上传图片

                                  onTapPickPicture(context, 1)
                                      .then((chooseImagesPath) {
                                    if (chooseImagesPath != null) {
                                      setState(() {
                                        _isUploadAthletePhoto = true;
                                        _athletePhotoPath = chooseImagesPath[0];
                                      });
                                    }
                                  });
                                },
                                //根据是否上传图片改变显示内容，上传了就显示图片
                                child: _isUploadAthletePhoto
                                    ? SizedBox(
                                        width: 330.w,
                                        height: 195.h,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 330.w,
                                              height: 195.h,
                                              child: Image.file(
                                                File(_athletePhotoPath),
                                              ),
                                            ),
                                            Positioned(
                                              left: 302.w,
                                              top: 0.h,
                                              child: GestureDetector(
                                                onTap: (() {
                                                  setState(() {
                                                    _isUploadAthletePhoto =
                                                        false;
                                                    _athletePhotoPath = "";
                                                  });
                                                }),
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    PEOCiconFont.chachaFont,
                                                    color:
                                                        PEOCConfig.THEMECOLOR,
                                                    size: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            width: 42.w,
                                            height: 35.h,
                                            'asset/images/upLoadPhoto.png',
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          PEOCText.easyText(
                                              text: "点 此 上 传",
                                              fontsize: 10.sp,
                                              color: PEOCConfig.THEMECOLOR)
                                        ],
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
                        child: PEOCText.easyText(
                            text: "是否获得教练员等级证书", fontsize: 14.sp),
                      ),

                      SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _titleButtonSpacing,
                      ),

                      //是否获得教练员等级证书选择框
                      Container(
                        height: 33.h,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: Container(
                          width: 145.w,
                          height: 33.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetCoachCertificate = true;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _isGetCoachCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: _isGetCoachCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(_bordercircular),
                                        right: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "是",
                                    fontsize: 14.sp,
                                    color: _isGetCoachCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetCoachCertificate = false;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !_isGetCoachCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: !_isGetCoachCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(_bordercircular),
                                        left: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "否",
                                    fontsize: 14.sp,
                                    color: !_isGetCoachCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //运动员证书等级和上传运动员证书图片，选择获得运动员证书才出现
                      Visibility(
                        visible: _isGetCoachCertificate,
                        child: Column(
                          children: [
                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _rowSpacing,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 21.h,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: PEOCText.easyText(
                                  text: "教练员证书等级", fontsize: 14.sp),
                            ),

                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _titleButtonSpacing,
                            ),

                            //教练员证书选择按钮
                            Container(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 33.h,
                              padding: EdgeInsets.fromLTRB(
                                  _leftPadding, 0, _rightPadding, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //初级级按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeCoach = true;
                                        _isSecondGradeCoach = false;
                                        _isThirdGradeCoach = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isFirstGradeCoach
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isFirstGradeCoach
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "初级",
                                        fontsize: 14.sp,
                                        color: _isFirstGradeCoach
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                      ),
                                    ),
                                  ),
                                  //中级按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeCoach = false;
                                        _isSecondGradeCoach = true;
                                        _isThirdGradeCoach = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isSecondGradeCoach
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isSecondGradeCoach
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "中级",
                                        fontsize: 14.sp,
                                        color: _isSecondGradeCoach
                                            ? Colors.white
                                            : const Color.fromRGBO(
                                                177, 177, 177, 1),
                                      ),
                                    ),
                                  ),
                                  //高级按钮
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isFirstGradeCoach = false;
                                        _isSecondGradeCoach = false;
                                        _isThirdGradeCoach = true;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      height: 33.h,
                                      decoration: BoxDecoration(
                                          color: _isThirdGradeCoach
                                              ? PEOCConfig.THEMECOLOR
                                              : Colors.transparent,
                                          border: Border.all(
                                            //选中与否决定边框颜色
                                            color: _isThirdGradeCoach
                                                ? PEOCConfig.THEMECOLOR
                                                : const Color.fromRGBO(
                                                    177, 177, 177, 1),
                                            width: ScreenUtil().setSp(1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              _bordercircular)),
                                      child: PEOCText.easyText(
                                        text: "高级",
                                        fontsize: 14.sp,
                                        color: _isThirdGradeCoach
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
                              height: _rowSpacing,
                            ),

                            Container(
                              alignment: Alignment.centerLeft,
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 21.h,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: Row(
                                children: [
                                  PEOCText.easyText(
                                      text: "上传教练员证书", fontsize: 14.sp),
                                  PEOCText.easyText(
                                      text: "(选填)",
                                      fontsize: 12.sp,
                                      color: const Color.fromRGBO(
                                          177, 177, 177, 1)),
                                ],
                              ),
                            ),

                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _titleButtonSpacing,
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: 334.w,
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(177, 177, 177, 0.4),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        177, 177, 177, 0.4),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: GestureDetector(
                                onTap: () {
                                  //上传图片

                                  onTapPickPicture(context, 1)
                                      .then((chooseImagesPath) {
                                    if (chooseImagesPath != null) {
                                      setState(() {
                                        _isUploadCoachPhoto = true;
                                        _coachPhotoPath = chooseImagesPath[0];
                                      });
                                    }
                                  });
                                },
                                //根据是否上传图片改变显示内容，上传了就显示图片
                                child: _isUploadCoachPhoto
                                    ? SizedBox(
                                        width: 330.w,
                                        height: 195.h,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 330.w,
                                              height: 195.h,
                                              child: Image.file(
                                                File(_coachPhotoPath),
                                              ),
                                            ),
                                            Positioned(
                                              left: 302.w,
                                              top: 0.h,
                                              child: GestureDetector(
                                                onTap: (() {
                                                  setState(() {
                                                    _isUploadCoachPhoto = false;
                                                    _coachPhotoPath = "";
                                                  });
                                                }),
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    PEOCiconFont.chachaFont,
                                                    color:
                                                        PEOCConfig.THEMECOLOR,
                                                    size: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            width: 42.w,
                                            height: 35.h,
                                            'asset/images/upLoadPhoto.png',
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          PEOCText.easyText(
                                              text: "点 此 上 传",
                                              fontsize: 10.sp,
                                              color: PEOCConfig.THEMECOLOR)
                                        ],
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
                        child: PEOCText.easyText(
                            text: "是否获得裁判员员证书", fontsize: 14.sp),
                      ),

                      SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _titleButtonSpacing,
                      ),

                      //"是否获得裁判员员证书选择框
                      Container(
                        height: 33.h,
                        padding: EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                        child: Container(
                          width: 145.w,
                          height: 33.h,
                          decoration:
                              const BoxDecoration(color: Colors.transparent),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetRefereeCertificate = true;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: _isGetRefereeCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: _isGetRefereeCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(_bordercircular),
                                        right: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "是",
                                    fontsize: 14.sp,
                                    color: _isGetRefereeCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (() {
                                  setState(() {
                                    _isGetRefereeCertificate = false;
                                  });
                                }),
                                child: Container(
                                  width: 74.w,
                                  height: 33.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: !_isGetRefereeCertificate
                                        ? const Color.fromRGBO(17, 24, 39, 1)
                                        : Colors.white,
                                    border: Border.all(
                                      color: !_isGetRefereeCertificate
                                          ? const Color.fromRGBO(17, 24, 39, 1)
                                          : const Color.fromRGBO(
                                              177, 177, 177, 1),
                                      width: ScreenUtil().setSp(1),
                                    ),
                                    //一边圆角一边直角
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(_bordercircular),
                                        left: Radius.zero),
                                  ),
                                  child: PEOCText.easyText(
                                    text: "否",
                                    fontsize: 14.sp,
                                    color: !_isGetRefereeCertificate
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            177, 177, 177, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //上传裁判员员证书图片，选择获得裁判员证书才出现
                      Visibility(
                        visible: _isGetRefereeCertificate,
                        child: Column(
                          children: [
                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _rowSpacing,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: 21.h,
                              padding:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              child: Row(
                                children: [
                                  PEOCText.easyText(
                                      text: "上传裁判员证书", fontsize: 14.sp),
                                  PEOCText.easyText(
                                      text: "(选填)",
                                      fontsize: 12.sp,
                                      color: const Color.fromRGBO(
                                          177, 177, 177, 1)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: PEOCConfig.DESIGNEDWIDTH.w,
                              height: _titleButtonSpacing,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 334.w,
                              height: 200.h,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromRGBO(177, 177, 177, 0.4),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        177, 177, 177, 0.4),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: GestureDetector(
                                onTap: () {
                                  //上传图片

                                  onTapPickPicture(context, 1)
                                      .then((chooseImagesPath) {
                                    if (chooseImagesPath != null) {
                                      setState(() {
                                        _isUploadRefereePhoto = true;
                                        _refereePhotoPath = chooseImagesPath[0];
                                      });
                                    }
                                  });
                                },
                                //根据是否上传图片改变显示内容，上传了就显示图片
                                child: _isUploadRefereePhoto
                                    ? SizedBox(
                                        width: 330.w,
                                        height: 195.h,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: 330.w,
                                              height: 195.h,
                                              child: Image.file(
                                                File(_refereePhotoPath),
                                              ),
                                            ),
                                            Positioned(
                                              left: 302.w,
                                              top: 0.h,
                                              child: GestureDetector(
                                                onTap: (() {
                                                  setState(() {
                                                    _isUploadRefereePhoto =
                                                        false;
                                                    _refereePhotoPath = "";
                                                  });
                                                }),
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    PEOCiconFont.chachaFont,
                                                    color:
                                                        PEOCConfig.THEMECOLOR,
                                                    size: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            width: 42.w,
                                            height: 35.h,
                                            'asset/images/upLoadPhoto.png',
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          PEOCText.easyText(
                                              text: "点 此 上 传",
                                              fontsize: 10.sp,
                                              color: PEOCConfig.THEMECOLOR)
                                        ],
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
                        child: Row(
                          children: [
                            PEOCText.easyText(text: "重大赛事成绩", fontsize: 14.sp),
                            PEOCText.easyText(
                                text: "(至多填写5条)",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //第一条赛事成绩
                          Visibility(
                            visible: resultNum >= 1 ? true : false,
                            child: Column(
                              children: [
                                Container(
                                  width: 334.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: _isFirstResultFocused
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: firstresultController,
                                          focusNode: _fnfirstresult,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
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
                                      SizedBox(
                                        width: 15.w,
                                        child: InkWell(
                                          onTap: (() {
                                            deleteResult(1, resultNum);
                                            setState(() {
                                              resultNum--;
                                              _fnfirstresult.unfocus();
                                            });
                                          }),
                                          child: Icon(
                                            PEOCiconFont.chachaFont,
                                            color: PEOCConfig.THEMECOLOR,
                                            size: 15.sp,
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
                              ],
                            ),
                          ),

                          //第二条赛事成绩
                          Visibility(
                            visible: resultNum >= 2 ? true : false,
                            child: Column(
                              children: [
                                Container(
                                  width: 334.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: _isSecondResultFocused
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: secondresultController,
                                          focusNode: _fnsecondresult,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
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
                                      SizedBox(
                                        width: 15.w,
                                        child: InkWell(
                                          onTap: (() {
                                            deleteResult(2, resultNum);
                                            setState(() {
                                              resultNum--;
                                              _fnsecondresult.unfocus();
                                            });
                                          }),
                                          child: Icon(
                                            PEOCiconFont.chachaFont,
                                            color: PEOCConfig.THEMECOLOR,
                                            size: 15.sp,
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
                              ],
                            ),
                          ),

                          //第三条赛事成绩
                          Visibility(
                            visible: resultNum >= 3 ? true : false,
                            child: Column(
                              children: [
                                Container(
                                  width: 334.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: _isThirdResultFocused
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: thirdresultController,
                                          focusNode: _fnthirdresult,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
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
                                      SizedBox(
                                        width: 15.w,
                                        child: InkWell(
                                          onTap: (() {
                                            deleteResult(3, resultNum);
                                            setState(() {
                                              _fnthirdresult.unfocus();
                                              resultNum--;
                                            });
                                          }),
                                          child: Icon(
                                            PEOCiconFont.chachaFont,
                                            color: PEOCConfig.THEMECOLOR,
                                            size: 15.sp,
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
                              ],
                            ),
                          ),

                          //第四条赛事成绩
                          Visibility(
                            visible: resultNum >= 4 ? true : false,
                            child: Column(
                              children: [
                                Container(
                                  width: 334.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: _isFourthResultFocused
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: fourthresultController,
                                          focusNode: _fnfourthresult,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
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
                                      SizedBox(
                                        width: 15.w,
                                        child: InkWell(
                                          onTap: (() {
                                            deleteResult(4, resultNum);
                                            setState(() {
                                              resultNum--;
                                              _fnfourthresult.unfocus();
                                            });
                                          }),
                                          child: Icon(
                                            PEOCiconFont.chachaFont,
                                            color: PEOCConfig.THEMECOLOR,
                                            size: 15.sp,
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
                              ],
                            ),
                          ),

                          //第五条赛事成绩
                          Visibility(
                            visible: resultNum >= 5 ? true : false,
                            child: Column(
                              children: [
                                Container(
                                  width: 334.w,
                                  height: 33.h,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      border: Border.all(
                                        color: _isFifthResultFocused
                                            ? PEOCConfig.THEMECOLOR
                                            : const Color.fromRGBO(
                                                17, 24, 39, 1),
                                        width: ScreenUtil().setSp(1),
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _bordercircular)),
                                  padding:
                                      EdgeInsets.fromLTRB(12.w, 0, 12.w, 0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: fifthresultController,
                                          focusNode: _fnfifthresult,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
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
                                      SizedBox(
                                        width: 15.w,
                                        child: InkWell(
                                          onTap: (() {
                                            deleteResult(5, resultNum);

                                            setState(() {
                                              resultNum--;
                                              _fnfifthresult.unfocus();
                                            });
                                          }),
                                          child: Icon(
                                            PEOCiconFont.chachaFont,
                                            color: PEOCConfig.THEMECOLOR,
                                            size: 15.sp,
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
                              ],
                            ),
                          ),

                          //添加赛事成绩的按钮
                          GestureDetector(
                            onTap: (() {
                              //TODO:添加赛事成绩

                              if (resultNum < 5) {
                                setState(() {
                                  resultNum++;
                                });
                              } else {
                                showmessage(msg: "至多添加5条", fontsize: 14.sp);
                              }
                            }),
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.fromLTRB(_leftPadding, 0, 0, 0),
                              width: 70.w,
                              height: 33.h,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(17, 24, 39, 1),
                                  border: Border.all(
                                    //选中与否决定边框颜色
                                    color: const Color.fromRGBO(17, 24, 39, 1),
                                    width: ScreenUtil().setSp(1),
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_bordercircular)),
                              child: PEOCText.easyText(
                                  text: "添 加",
                                  fontsize: 14.sp,
                                  color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }

  void deleteResult(int no, int resultNum) {
    //删除赛事成绩,传入被删的编号和删前的成绩数
    if (resultNum == no) {
      //被删的是最后一条,直接最后一条内容清空
      _resultsControllers[no - 1].text = "";
    } else {
      int j = 1;
      for (int i = 1; i < resultNum; i++) {
        if (i == no) {
          //本条保存下一条的内容
          j++;
        }
        _resultsControllers[i - 1].text = _resultsControllers[j - 1].text;
        j++;
      }
      _resultsControllers[resultNum - 1].text = "";
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fnname.dispose();
    _fneduyears.dispose();
    _fnschool.dispose();
    _fnlocation.dispose();
    _fnfirstresult.dispose();
    _fnsecondresult.dispose();
    _fnthirdresult.dispose();
    _fnfourthresult.dispose();
    _fnfifthresult.dispose();

    nameController.dispose();
    eduyearsController.dispose();
    schoolController.dispose();
    locationController.dispose();
    firstresultController.dispose();
    secondresultController.dispose();
    thirdresultController.dispose();
    fourthresultController.dispose();
    fifthresultController.dispose();
  }
}
