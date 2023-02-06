import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/PEOCChatBar.dart';

class TrainingChatPage extends StatefulWidget {
  const TrainingChatPage({super.key});
  @override
  State<TrainingChatPage> createState() => _TrainingChatPageState();
}

class _TrainingChatPageState extends State<TrainingChatPage> {
  // 对键盘的控制
  final GlobalKey<PEOCChatBarState> _PEOCChatBarKey = GlobalKey();
  // 有没有公告
  final bool _hasannouncement = true;

  //每页13条
  static const PAGE_SIZE = 13;
  //当前页
  var PAGE_NUM = 1;
  //从那一条开始(为保证最新的先显示， 先查询最后的，并且不能用desc查询)
  var startNum = 0;
  //总共多少条
  var CHAT_TOTAL = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //监听键盘变化
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );

    return Scaffold(
      backgroundColor: Colors.white,
      // 键盘弹起页面不上移动
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: AppBar(
          shadowColor: const Color.fromARGB(125, 70, 70, 70).withOpacity(0.15),
          elevation: _hasannouncement ? 0 : 1,
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.fromLTRB(20.w, 23.h, 0, 6.h),
            padding: EdgeInsets.zero,
            child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20.sp,
                ),
                onTap: () {
                  Get.back();
                }),
          ),
          title: Container(
            margin: EdgeInsets.fromLTRB(0, 23.h, 0, 6.h),
            alignment: Alignment.center,
            child: Text(
              "中南大学羽毛球队",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontFamily: "syhtRegularFamily",
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 23.h, 21.w, 6.h),
              child: InkWell(
                  child: const Icon(
                    Icons.more_horiz_outlined,
                    color: Colors.black,
                  ),
                  onTap: () {
                    print("点击三个点");
                  }),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(children: [
          Offstage(
            offstage: !_hasannouncement,
            child: Container(
              height: 45.h,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.w, 0, 21.w, 0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(125, 70, 70, 70).withOpacity(0.15),
                  spreadRadius: 0.0,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]),
              child: Container(
                height: 27.h,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: GestureDetector(
              onPanDown: (_) {
                _PEOCChatBarKey.currentState!.hidenKeyBoard();
              },
              child: ListView(
                children: const [],
              ),
            ),
          ),
          // 显示聊天记录
          Container(
            constraints: BoxConstraints(
              minHeight: 54.h,
            ),
            width: double.infinity,
            child: PEOCChatBar(key: _PEOCChatBarKey),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
