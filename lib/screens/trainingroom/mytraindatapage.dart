/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-02-05 22:30:34
 * @LastEditTime: 2023-02-06 10:57:49
 * @Descripttion: 
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:pe_over_cloud/widgets/PEOCCart.dart';
import 'package:pe_over_cloud/widgets/PEOCKeepAliveWapper.dart';
import 'package:pe_over_cloud/widgets/PEOCOverScrollBehavior.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';

import 'trainingroomsearchpage.dart';

class MyTraindataPage extends StatefulWidget {
  const MyTraindataPage({super.key});

  @override
  State<MyTraindataPage> createState() => _MyTraindataPageState();
}

class _MyTraindataPageState extends State<MyTraindataPage> {
  //训练数据共有几天
  int _traindatadaysnum = 4;

  //一天里有多少个训练任务
  List _trainnumindays = [2, 3, 2, 5];

  //训练数据的日期
  List _trainday = ["2023年2月6日", "2023年2月4日", "2023年2月3日", "2023年2月2日"];
  List _ondaytrainlist = [
    [
      ["综合训练", "田径训练房", "今天9:45"],
      ["羽毛球训练", "羽毛球训练房", "今天9:45"],
    ],
    [
      ["综合训练", "田径训练房", "今天9:45"],
      ["综合训练1", "田径训练房1", "今天9:45"],
      ["耐力训练", "游泳训练房", "今天9:45"],
    ],
    [
      ["综合训练", "田径训练房", "今天9:45"],
      ["颠球训练", "羽毛球训练房", "今天9:45"],
    ],
    [
      ["综合训练", "田径训练房", "今天9:45"],
      ["综合训练", "田径训练房", "今天9:45"],
      ["综合训练", "田径训练房", "今天9:45"],
      ["综合训练", "田径训练房", "今天9:45"],
      ["综合训练", "田径训练房", "今天9:45"],
    ],
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.h),
          child: AppBar(
              title: PEOCText.easyText(text: "我的训练数据", fontsize: 18.sp),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 3,
              shadowColor: Colors.black.withOpacity(0.4),
              leading: Container(
                height: 56.h,
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
                    Get.back();
                  },
                ),
              ))),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20.w, 0, 21.w, 0),
        child: PEOCKeepAliveWrapper(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ScrollConfiguration(
              behavior: PEOCOverScrollBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.5.h,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      height: 30.h,
                      child: Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () => {openPageFunction(context)},
                              child: Hero(
                                tag: 'traindatasearch',
                                child: Container(
                                  width: 300.w,
                                  height: 30.h,
                                  alignment: Alignment.centerLeft,
                                  padding:
                                      EdgeInsets.fromLTRB(12.r, 0, 12.r, 0),
                                  margin: EdgeInsets.only(right: 10.w),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(237, 237, 237, 1),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: const Icon(
                                    Icons.youtube_searched_for_outlined,
                                    color: Color.fromRGBO(122, 122, 122, 1),
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: PEOCButton.iconButton(
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Color.fromRGBO(133, 133, 133, 1),
                                ),
                                ontap: () {
                                  //TODO:查询训练数据
                                  print("查询训练数据");
                                }),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                    ),
                    SizedBox(
                      width: 334.w,
                      child: ListView.builder(
                        shrinkWrap: true, //范围内进行包裹（内容多高ListView就多高）
                        physics: const NeverScrollableScrollPhysics(), //禁止滚动
                        itemCount: _traindatadaysnum,
                        //scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          Widget item = PEOCCart.getTrainDataInDaysCard(
                              trainnum: _trainnumindays[index],
                              settime: _trainday[index],
                              onedaytrainlist: _ondaytrainlist[index]);
                          return item;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 1.h,
                            color: const Color.fromRGBO(204, 204, 204, 0.5),
                          ),
                        ),
                        Container(
                          width: 70.w,
                          height: 18.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: PEOCText.easyText(
                              text: "没有更多了",
                              fontsize: 12.sp,
                              color: const Color.fromRGBO(207, 207, 207, 1)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 1.h,
                            color: const Color.fromRGBO(204, 204, 204, 0.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: PEOCConfig.DESIGNEDWIDTH.w,
                      height: 60.h,
                    ),
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

void openPageFunction(context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        //目标页面
        return const TrainingRoomSearchPage();
      },
      //打开新的页面用时
      transitionDuration: const Duration(milliseconds: 800),
      //关半页岩用时
      reverseTransitionDuration: const Duration(milliseconds: 800),
      //过渡动画构建
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        //渐变过渡动画
        return FadeTransition(
          // 透明度从 0.0-1.0
          opacity: Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              //动画曲线规则
              curve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          child: child,
        );
      },
    ),
  );
}
