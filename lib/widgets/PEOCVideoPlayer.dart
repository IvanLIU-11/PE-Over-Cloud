/*
 * @Author: YJR-1100
 * @Date: 2023-02-01 14:38:36
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-04 11:44:45
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCVideoPlayer.dart
 * @Description: 播放视频组件，进度条，全屏，播放/暂停
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

// PEOCVideoPlayer.dart
import 'package:pe_over_cloud/widgets/PEOCButton.dart';
import 'package:video_player/video_player.dart'; // 引入官方插件
import 'package:flutter/material.dart';
import 'package:orientation/orientation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:async';
// import 'package:fluttertoast/fluttertoast.dart';

class PEOCVideoPlayer extends StatefulWidget {
  PEOCVideoPlayer({
    required this.url, // 当前需要播放的地址
    required this.width, // 播放器尺寸（大于等于视频播放区域）
    required this.height,
  });

  // 视频地址
  final String url;
  // 视频尺寸比例
  double width;
  double height;

  @override
  State<PEOCVideoPlayer> createState() {
    return _PEOCVideoPlayerState();
  }
}

class _PEOCVideoPlayerState extends State<PEOCVideoPlayer> {
  // 指示video资源是否加载完成，加载完成后会获得总时长和视频长宽比等信息
  bool _videoInit = false;
  // video控件管理器
  late VideoPlayerController _controller;
  // 记录video播放进度
  Duration _position = const Duration(seconds: 0);
  // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
  Timer? _timer; // 计时器，用于延迟隐藏控件ui
  bool _hidePlayControl = true; // 控制是否隐藏控件ui
  double _playControlOpacity = 0; // 通过透明度动画显示/隐藏控件ui
  // 记录是否全屏
  bool get _isFullScreen =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  //倍速
  double _selectedSpeedValue = 1.0;
  List<double> videospeeditems = [2.0, 1.0, 0.75, 0.5];
  int _indexctrl = 1;
  List<Widget> _speedbtnlist = [];
  @override
  void initState() {
    super.initState();
    _urlChange(); // 初始进行一次url加载
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: const BoxDecoration(
            color: Color.fromARGB(192, 67, 67, 67),
            image: DecorationImage(
                image: AssetImage('asset/images/logogray.png'),
                fit: BoxFit.scaleDown)),
        child: Stack(
          // 因为控件ui和视频是重叠的，所以要用定位了
          children: [
            GestureDetector(
              // 手势组件
              onTap: () {
                // 点击显示/隐藏控件ui
                _togglePlayControl();
              },
              child: _videoInit
                  ? Container(
                      color: Colors.black54,
                      child: Center(
                        child: AspectRatio(
                          // 加载url成功时，根据视频比例渲染播放器
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    )
                  : const Center(
                      // 没加载完成时显示转圈圈loading
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
            // ui上半部分
            Positioned(
                left: 0,
                top: 0,
                child: Offstage(
                  offstage: _hidePlayControl,
                  child: AnimatedOpacity(
                    // 加入透明度动画
                    opacity: _playControlOpacity,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      // 顶部控件的容器
                      width: widget.width,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          // 来点黑色到透明的渐变优雅一下
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, .7),
                            Color.fromRGBO(0, 0, 0, .1),
                          ],
                        ),
                      ),
                      child: _videoInit
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      iconSize: 20,
                                      icon: const Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (_isFullScreen) {
                                          // 如果是全屏就切换竖屏
                                          _toggleFullScreen();
                                        } else {
                                          Get.back();
                                        }
                                      }),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 24,
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _showDialog();
                                    },
                                  )
                                ])
                          : Container(),
                    ),
                  ),
                )),
            // 控件ui下半部 看下面
            Positioned(
              // 需要定位
              left: 0,
              bottom: 0,
              child: Offstage(
                // 控制是否隐藏
                offstage: _hidePlayControl,
                child: AnimatedOpacity(
                  // 加入透明度动画
                  opacity: _playControlOpacity,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    // 底部控件的容器
                    width: widget.width,
                    height: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        // 来点黑色到透明的渐变优雅一下
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, .7),
                          Color.fromRGBO(0, 0, 0, .1)
                        ],
                      ),
                    ),
                    child: _videoInit
                        ? Row(
                            // 加载完成时才渲染,flex布局
                            children: [
                              IconButton(
                                // 播放按钮
                                padding: EdgeInsets.zero,
                                iconSize: 24,
                                icon: Icon(
                                  // 根据控制器动态变化播放图标还是暂停
                                  _controller.value.isPlaying
                                      ? Icons.pause_outlined
                                      : Icons.play_arrow_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // 同样的，点击动态播放或者暂停
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                    _startPlayControlTimer(); // 操作控件后，重置延迟隐藏控件的timer
                                  });
                                },
                              ),
                              Flexible(
                                // 相当于前端的flex: 1
                                child: VideoProgressIndicator(
                                  // video_player编写好的进度条，直接用就是了~~
                                  _controller,
                                  allowScrubbing: true, // 允许手势操作进度条
                                  padding: const EdgeInsets.all(0),
                                  colors: VideoProgressColors(
                                    // 配置进度条颜色，也是video_player现成的，直接用
                                    playedColor: Theme.of(context)
                                        .primaryColor, // 已播放的颜色
                                    bufferedColor: const Color.fromRGBO(
                                        255, 255, 255, .5), // 缓存中的颜色
                                    backgroundColor: const Color.fromRGBO(
                                        255, 255, 255, .2), // 为缓存的颜色
                                  ),
                                ),
                              ),
                              Container(
                                // 播放时间
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
                                  '${durationToTime(_position)}/${durationToTime(_controller.value.duration)}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              Offstage(
                                offstage: !_isFullScreen,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: InkWell(
                                    onTap: () => _showDialog(),
                                    child: const Text(
                                      '倍速',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                // 全屏/横屏按钮
                                padding: EdgeInsets.zero,
                                iconSize: 24,
                                icon: Icon(
                                  // 根据当前屏幕方向切换图标
                                  _isFullScreen
                                      ? Icons.fullscreen_exit_outlined
                                      : Icons.fullscreen_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // 点击切换是否全屏
                                  _toggleFullScreen();
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  void didUpdateWidget(PEOCVideoPlayer oldWidget) {
    if (oldWidget.url != widget.url) {
      _urlChange(); // url变化时重新执行一次url加载
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  void _showDialog() {
    _togglePlayControl();
    if (_isFullScreen) {
      flashspeedbtn(9.sp,
          width: double.infinity, height: (widget.height - 105.h) / 4);
      SmartDialog.show(
        alignmentTemp: Alignment.centerRight,
        isPenetrateTemp: false,
        clickBgDismissTemp: true,
        widget: Container(
          height: double.infinity,
          width: 32.w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              // 来点黑色到透明的渐变优雅一下
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(0, 0, 0, .2),
                Color.fromRGBO(0, 0, 0, .8),
              ],
            ),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 50.h, 0, 55.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _speedbtnlist,
            ),
          ),
        ),
      );
    } else {
      flashspeedbtn(14.sp,
          height: double.infinity, width: PEOCConfig.DESIGNEDWIDTH.w / 4);
      SmartDialog.show(
          alignmentTemp: Alignment.bottomCenter,
          isPenetrateTemp: false,
          maskColorTemp: const Color.fromRGBO(0, 0, 0, 0.5),
          clickBgDismissTemp: true,
          widget: Container(
            width: double.infinity,
            height: 186.h,
            color: Colors.grey[200],
            child: Column(children: [
              Container(
                height: 70.h,
                color: Colors.white,
              ),
              Container(
                height: 50.h,
                color: Colors.white,
                margin: EdgeInsets.only(top: 1.h),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: _speedbtnlist,
                  ),
                ),
              ),
              Container(
                height: 60.h,
                width: PEOCConfig.DESIGNEDWIDTH.w,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5.h),
                color: Colors.white,
                child: PEOCButton.textButton(
                    text: Text(
                      "取消",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        fontFamily: "syhtFamily",
                        height: 1.0,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                    ontap: () => SmartDialog.dismiss()),
              )
            ]),
          ));
    }
  }

  void flashspeedbtn(fontsize, {required width, required height}) {
    _speedbtnlist = videospeeditems.map((e) {
      return PEOCButton.selectedButton(
          index: videospeeditems.indexOf(e),
          indexctrl: _indexctrl,
          width: width,
          height: height,
          text: '${e}x',
          fontsize: fontsize,
          ontap: () {
            _selectedSpeedValue = e;
            _indexctrl = videospeeditems.indexOf(e);
            _controller.setPlaybackSpeed(e);
            SmartDialog.dismiss();
            _showDialog();
          });
    }).toList();
  }

  void _urlChange() {
    // if (widget.url == '') return;
    // _controller.removeListener(_videoListener);
    // _controller.dispose();
    // setState(() {
    //   // 重置组件参数
    //   _hidePlayControl = true;
    //   _videoInit = false;
    //   _position = const Duration(seconds: 0);
    // });
    // 加载network的url，也支持本地文件，自行阅览官方api
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
        _controller.addListener(_videoListener);
        setState(() {
          _videoInit = true;
        });
        _togglePlayControl();
      });
    _controller.setPlaybackSpeed(_selectedSpeedValue);
  }

  void _videoListener() async {
    Duration? res = await _controller.position;
    if (res! >= _controller.value.duration) {
      _controller.pause();
      _controller.seekTo(const Duration(seconds: 0));
    }
    setState(() {
      _position = res;
    });
  }

  void _togglePlayControl() {
    setState(() {
      if (_hidePlayControl) {
        // 如果隐藏则显示
        _hidePlayControl = false;
        _playControlOpacity = 1;
        _startPlayControlTimer(); // 开始计时器，计时后隐藏
      } else {
        // 如果显示就隐藏
        _timer?.cancel(); // 有计时器先移除计时器
        _playControlOpacity = 0;
        Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
          _hidePlayControl = true; // 延迟300ms(透明度动画结束)后，隐藏
        });
      }
    });
  }

  void _startPlayControlTimer() {
    // 计时器，用法和前端js的大同小异
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), () {
      // 延迟3s后隐藏
      setState(() {
        _playControlOpacity = 0;
        Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
          _hidePlayControl = true;
        });
      });
    });
  }

  void _toggleFullScreen() {
    setState(() {
      if (_isFullScreen) {
        // 如果是全屏就切换竖屏
        OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
      } else {
        OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      }
      _startPlayControlTimer(); // 操作完控件开始计时隐藏
    });
  }
}

String durationToTime(Duration duration) {
  String hours = duration.inHours.toString().padLeft(0, '2');
  String minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours == "0" ? "$minutes:$seconds" : "$hours:$minutes:$seconds";
}
