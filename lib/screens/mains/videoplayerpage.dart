import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/widgets/PEOCVideoItem.dart';
import 'package:pe_over_cloud/widgets/PEOCVideoPlayer.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
// 引入官方插件
import 'package:orientation/orientation.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/services.dart';
import 'package:pe_over_cloud/widgets/PEOCOverScrollBehavior.dart';

// ignore: depend_on_referenced_packages
class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late var _currentvideo;
  List _videoinfolist = [];
  final List _messageinfolist = [];
  List<Widget> _relatedvideolist = [];
  late ScrollController _relatedcontroller;
  final bool _isRelatedBottom = false;
  final bool _isMessageBottom = false;
  late ScrollController _messagecontroller;
  // 获取中考体育教学视频信息
  List listData = [
    {
      "vid": "1",
      "imageurl":
          "https://p2.itc.cn/q_70/images03/20210921/e8fb04c573d74813a770436789067b3d.jpeg",
      "title": "跳远教学视频",
      "description":
          "视频视频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当\n容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当\n容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当",
      "videourl":
          "https://v.06dn.com/api/v3/slave/source/0/L3VwbG9hZHMvMS8yMDIzMDIvMDEvMV9vd3NJczBhOF9sb25nIGp1bXAxLm1wNA/long%20jump1.mp4?sign=yxNhU02PMaqw9hxc-wv_DMv_F53H1yUf7-NSwJVYbYM%3D%3A0",
      "videotime": "01:00",
      "playtimes": "1000",
      "author": "云上体教",
      "authorimgurl": "https://www.itying.com/themes/itying/images/ionic1.png",
      "date": "2021.7.14 08:32 发表于湖南"
    },
  ];
  // 留言信息
  List messageData = [
    {
      'authorimgurl':
          'https://p8.itc.cn/q_70/images03/20210729/c0f5f8e841ed4c9280e922817be06862.jpeg',
      'author': '云上体教',
      'date': '2021.7.14 08:32 发表于湖南',
      'message': '评论评论'
    },
    {
      'authorimgurl':
          'https://p8.itc.cn/q_70/images03/20210729/c0f5f8e841ed4c9280e922817be06862.jpeg',
      'author': '云上体教',
      'date': '2021.7.14 08:32 发表于湖南',
      'message':
          "视频视频简介介内容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当\n容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当\n容或者频简介内容或者是教内容或者是教学视容或者是教学视频当中的学是教是学频学当",
    },
    {
      'authorimgurl':
          'https://p8.itc.cn/q_70/images03/20210729/c0f5f8e841ed4c9280e922817be06862.jpeg',
      'author': '云上体教',
      'date': '2021.7.14 08:32 发表于湖南',
      'message': '评论评论'
    },
  ];

  // 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  @override
  void initState() {
    if (Get.arguments != null) {
      _currentvideo = Get.arguments["currentvideo"];
      _videoinfolist = Get.arguments["videoinfolist"];
    } else {
      _currentvideo = listData[0];
      _videoinfolist = listData;
    }
    _relatedvideolist = [];
    // _messageinfolist = messageData;
    super.initState();
    _relatedcontroller = ScrollController();
    _messagecontroller = ScrollController();
    // _relatedcontroller.addListener(() {
    //   if (_relatedcontroller.position.pixels ==
    //       _relatedcontroller.position.maxScrollExtent) {
    //     print("到底了");
    //     setState(() {
    //       _isRelatedBottom = true;
    //     });
    //   }
    //   if (_relatedcontroller.position.pixels ==
    //       _relatedcontroller.position.maxScrollExtent - 1) {
    //     setState(() {
    //       _isRelatedBottom = false;
    //     });
    //   }
    // });
    print("视频播放页面init");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    final double topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final double vw = MediaQuery.of(context).size.width;
    final double vh = MediaQuery.of(context).size.height;
    print("build");
    _relatedvideolist.clear();
    for (int i = 0; i < _videoinfolist.length; i++) {
      if (_videoinfolist[i]['vid'] != _currentvideo['vid']) {
        _relatedvideolist.add(PEOCVideoItem.relatedInfoCard(
          currentvideo: _videoinfolist[i],
          videoinfolist: _videoinfolist,
          ontap: () => Get.toNamed('/videoplayer',
              preventDuplicates: false,
              arguments: {
                "currentvideo": _videoinfolist[i],
                "videoinfolist": _videoinfolist
              }),
        ));
      }
    }
    // if (_videoinfolist.isNotEmpty) {
    //   _relatedvideolist.add(PEOCCart.getToBottom(!_isRelatedBottom));
    // }
    // if (_messageinfolist.isNotEmpty) {
    //   _messagelist.add(PEOCCart.getToBottom(true));
    // }

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PEOCVideoPlayer(
                      url: _currentvideo["videourl"],
                      width: _isFullScreen ? vw : vw,
                      height: _isFullScreen ? vh : vw / 16 * 9),
                  Offstage(
                    offstage: _isFullScreen,
                    child: Center(
                      child: SizedBox(
                        width: PEOCConfig.DESIGNEDWIDTH.w,
                        height: _isFullScreen
                            ? 0
                            : PEOCConfig.DESIGNEDHEIGHT.h -
                                topPadding -
                                vw / 16 * 9,
                        child: ContainedTabBarView(
                          tabs: [
                            Text(
                              '简介',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "syhtFamily",
                              ),
                            ),
                            Text(
                              '留言',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                fontFamily: "syhtFamily",
                              ),
                            ),
                          ],
                          tabBarProperties: TabBarProperties(
                            padding: EdgeInsets.only(top: 5.h),
                            height: 37.h,
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 0.3,
                                      blurRadius: 3,
                                      offset: const Offset(0, 1),
                                    ),
                                  ]),
                            ),
                            indicatorColor: PEOCConfig.THEMECOLOR,
                            indicatorWeight: 2.sp,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.black,
                            unselectedLabelColor:
                                const Color.fromARGB(255, 156, 156, 156),
                          ),
                          views: [
                            Container(
                              color: Colors.white.withOpacity(0),
                              child: Container(
                                width: PEOCConfig.DESIGNEDWIDTH.w,
                                padding: EdgeInsets.fromLTRB(20.w, 0, 21.w, 0),
                                child: ScrollConfiguration(
                                  behavior: PEOCOverScrollBehavior(),
                                  child: ListView(
                                    controller: _relatedcontroller,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top: 15.h),
                                        child: Column(children: [
                                          PEOCVideoItem.senderInfoCard(
                                              authorimgurl:
                                                  _currentvideo["authorimgurl"],
                                              author: _currentvideo["author"],
                                              date: _currentvideo["date"]),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 10.h),
                                            child: PEOCText.easyText(
                                              text: _currentvideo["title"],
                                              fontsize: 16.sp,
                                              textAlign: TextAlign.left,
                                              fontFamily: "syhtMediumFamily",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 5.h),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.video_call_outlined,
                                                  size: 16.sp,
                                                  color: const Color.fromRGBO(
                                                      189, 189, 189, 1),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 4.w),
                                                  child: Text(
                                                    _currentvideo["playtimes"],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color:
                                                          const Color.fromRGBO(
                                                              189, 189, 189, 1),
                                                      fontFamily:
                                                          "syhtLightFamily",
                                                      // height: 1.0,
                                                      leadingDistribution:
                                                          TextLeadingDistribution
                                                              .even,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.topLeft,
                                            margin: EdgeInsets.only(top: 5.h),
                                            constraints: const BoxConstraints(
                                                // minHeight: 100.h,
                                                ),
                                            child: PEOCText.richText(
                                                fontsize: 14.sp,
                                                linelenght:
                                                    (PEOCConfig.DESIGNEDWIDTH -
                                                            41)
                                                        .w,
                                                color: const Color.fromRGBO(
                                                    117, 117, 117, 1),
                                                text: _currentvideo[
                                                    "description"],
                                                fontfamily: "syhtLightFamily"),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20.h),
                                        child: Column(children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            child: PEOCText.easyText(
                                                text: "相关推荐",
                                                fontFamily: "syhtMediumFamily",
                                                color: const Color.fromRGBO(
                                                    112, 112, 112, 1),
                                                fontsize: 14.sp),
                                          ),
                                          const Divider(
                                            color: Color.fromRGBO(
                                                204, 204, 204, 1),
                                          ),
                                          Column(
                                              children:
                                                  _relatedvideolist.isEmpty
                                                      ? [
                                                          Container(
                                                            color: Colors.white
                                                                .withOpacity(0),
                                                            child: Container(
                                                                width: PEOCConfig
                                                                    .DESIGNEDWIDTH
                                                                    .w,
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        20.w,
                                                                        0,
                                                                        21.w,
                                                                        0),
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: 30
                                                                            .h),
                                                                    child: Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            width:
                                                                                78.w,
                                                                            height:
                                                                                57.h,
                                                                            'asset/images/logogray.png',
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 8.h),
                                                                            child: PEOCText.easyText(
                                                                                text: "暂无相关推荐",
                                                                                fontsize: 12.sp,
                                                                                fontFamily: "syhtRegularFamily",
                                                                                color: const Color.fromRGBO(207, 207, 207, 1)),
                                                                          )
                                                                        ]),
                                                                  ),
                                                                )),
                                                          )
                                                        ]
                                                      : _relatedvideolist)
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            _messageinfolist.isEmpty
                                ? Container(
                                    color: Colors.white.withOpacity(0),
                                    child: Container(
                                        width: PEOCConfig.DESIGNEDWIDTH.w,
                                        padding: EdgeInsets.fromLTRB(
                                            20.w, 0, 21.w, 0),
                                        child: Center(
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(bottom: 165.h),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    width: 78.w,
                                                    height: 57.h,
                                                    'asset/images/logogray.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 8.h),
                                                    child: PEOCText.easyText(
                                                        text: "快来留下第一条评论吧",
                                                        fontsize: 12.sp,
                                                        fontFamily:
                                                            "syhtRegularFamily",
                                                        color: const Color
                                                                .fromRGBO(
                                                            207, 207, 207, 1)),
                                                  )
                                                ]),
                                          ),
                                        )),
                                  )
                                : Container(
                                    color: Colors.white.withOpacity(0),
                                    child: Container(
                                      width: PEOCConfig.DESIGNEDWIDTH.w,
                                      padding:
                                          EdgeInsets.fromLTRB(20.w, 0, 21.w, 0),
                                      child: ScrollConfiguration(
                                        behavior: PEOCOverScrollBehavior(),
                                        child: RefreshIndicator(
                                          onRefresh: () async {
                                            print("下拉加载更多");
                                            print(
                                                "https://www.jb51.net/article/260463.htm");
                                            return;
                                          },
                                          child: ListView.builder(
                                            itemCount: _messageinfolist.length,
                                            itemBuilder: (context, index) {
                                              return PEOCVideoItem
                                                  .videoMessageCard(
                                                      _messageinfolist[index]);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                          onChange: (index) => print(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (_isFullScreen) {
            // 如果是全屏就切换竖屏
            OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
            return false;
          } else {
            return true;
          }
        });
  }
}

// 下半评论部分
// Widget _message = Center(child: ,);
