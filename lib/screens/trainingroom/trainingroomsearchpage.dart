import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';

class TrainingRoomSearchPage extends StatefulWidget {
  const TrainingRoomSearchPage({super.key});

  @override
  State<TrainingRoomSearchPage> createState() => _TrainingRoomSearchPageState();
}

class _TrainingRoomSearchPageState extends State<TrainingRoomSearchPage> {
  final searchController = TextEditingController();
  final FocusNode _focusNodesearch = FocusNode();
  bool _searchfocus = true;
  bool _isshowcancel = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = "";
    print("ininini");
    // search输入框焦点
    _focusNodesearch.addListener(() {
      if (!_focusNodesearch.hasFocus) {
        // 失去焦点
        setState(() {
          _searchfocus = false;
        });
      } else {
        setState(() {
          _searchfocus = true;
        });
      }
    });
    Future.delayed(
        const Duration(
          milliseconds: 1800,
        ), () {
      _focusNodesearch.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _focusNodesearch.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 0),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Hero(
                      tag: 'trainingroomsearch',
                      child: Material(
                        child: Container(
                          height: 40.h,
                          color: Colors.white,
                          child: Row(children: [
                            Flexible(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(237, 237, 237, 1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                margin: EdgeInsets.only(right: 5.w),
                                padding: EdgeInsets.fromLTRB(10.r, 0, 10.r, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.youtube_searched_for_outlined,
                                      color: Color.fromRGBO(122, 122, 122, 1),
                                      size: 18,
                                    ), //放大镜
                                    Flexible(
                                      child: Container(
                                        height: 40.h,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.fromLTRB(
                                            10.r, 0, 2.r, 0),
                                        child: TextField(
                                          controller: searchController,
                                          focusNode: _focusNodesearch,
                                          onChanged: ((value) {
                                            print(value);
                                            if (searchController
                                                .text.isNotEmpty) {
                                              setState(() {
                                                _isshowcancel = true;
                                              });
                                            } else {
                                              setState(() {
                                                _isshowcancel = false;
                                              });
                                            }
                                          }),
                                          autofocus: false,
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                17, 24, 39, 1),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "syhtFamily",
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "搜索",
                                            hintStyle: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 138, 144, 154),
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "syhtFamily",
                                            ),
                                            isCollapsed: true,
                                          ),
                                          cursorColor: PEOCConfig.THEMECOLOR,
                                        ),
                                      ),
                                    ),
                                    Offstage(
                                      offstage: !_isshowcancel,
                                      child: PEOCButton.iconButton(
                                          height: 40.h,
                                          width: 30.w,
                                          icon: const Icon(
                                            Icons.cancel,
                                            size: 18,
                                            color: Color.fromRGBO(
                                                122, 122, 122, 1),
                                          ),
                                          ontap: () {
                                            searchController.clear();
                                            setState(() {
                                              _isshowcancel = false;
                                            });
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: PEOCButton.textButton(
                                  text: Text(
                                    "取消",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: PEOCConfig.THEMECOLOR,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: "syhtFamily",
                                      height: 1.0,
                                      leadingDistribution:
                                          TextLeadingDistribution.even,
                                    ),
                                  ),
                                  ontap: () {
                                    Navigator.of(context).pop();
                                  }),
                            )
                          ]),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


/* 
                                 */