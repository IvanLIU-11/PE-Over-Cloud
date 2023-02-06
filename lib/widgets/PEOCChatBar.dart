/*
 * @Author: YJR-1100
 * @Date: 2023-02-05 14:57:52
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-06 18:02:31
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCChatBar.dart
 * @Description: 聊天室最下面的工具栏
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import './PEOCButton.dart';
import './PEOCEmojiPicker.dart';
import './PEOCText.dart';
import './PEOCiconFont.dart';
import './toastDialog.dart';
import './PEOCChatVoice.dart';

enum InputType {
  none,
  input,
  emoj,
  add,
}

class PEOCChatBar extends StatefulWidget {
  const PEOCChatBar({super.key});

  @override
  State<PEOCChatBar> createState() => PEOCChatBarState();
}

class PEOCChatBarState extends State<PEOCChatBar> with WidgetsBindingObserver {
  // 是否快捷指令还是输入
  bool _isinput = true;
  // 语音输入还是键盘输入
  bool _isvoice = true;
  // 发送按钮显示
  bool _isshowsend = false;

  final FocusNode _focusNodeinput = FocusNode();
  InputType _inputType = InputType.none;

  final inputController = TextEditingController();
  // 当前键盘是否是激活状态

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputController.text = "";
    print("聊天界面init");

    //监听文本焦点
    _focusNodeinput.addListener(() {
      //不在这里处理键盘弹起,拿不到键盘高度
      if (_focusNodeinput.hasFocus) {
        setState(() {
          _inputType = InputType.input;
        });
      } else {
        if (_inputType == InputType.input) {
          setState(() {
            _inputType = InputType.none;
          });
        }
      }
    });

    //监听键盘变化
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    print(WidgetsBinding.instance.window.viewInsets.bottom);
    print(_inputType);
    print(_focusNodeinput.hasFocus);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (WidgetsBinding.instance.window.viewInsets.bottom <= 0.0) {
          print("1111");
          if (_inputType == InputType.input) {
            // _focusNodeinput.unfocus();
          }
        } else {
          //键盘弹出
          print("弹窗");
          // setState(() {
          //   _inputType = InputType.input;
          // });
        }
      },
    );
  }

  hidenKeyBoard() {
    print("dddddddddddddddd");
    _focusNodeinput.unfocus();
    setState(() {
      _inputType = InputType.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(
          PEOCConfig.DESIGNEDWIDTH, PEOCConfig.DESIGNEDHEIGHT), // 传入设计图尺寸
    );
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, anim) {
            return FadeTransition(
                opacity: anim,
                child: MSSlideTransitionX(
                  position: anim,
                  dir: AxisDirection.up,
                  child: child,
                ));
          },
          child: _isinput
              ? Container(
                  key: const ValueKey("input"),
                  constraints: BoxConstraints(
                    minHeight: 54.h,
                  ),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(125, 70, 70, 70)
                              .withOpacity(0.15),
                          spreadRadius: 0.0,
                          blurRadius: 3,
                          offset: const Offset(0, -2),
                        ),
                      ]),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(15.w, 0, 16.w, 6.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PEOCButton.iconButton(
                          icon: const Icon(PEOCiconFont.gobackFont),
                          ontap: (() {
                            _focusNodeinput.unfocus();
                            setState(() {
                              _isinput = false;
                              _inputType = InputType.none;
                            });
                          }),
                        ),
                        _isvoice
                            ? PEOCButton.iconButton(
                                icon: const Icon(PEOCiconFont.voiceFont),
                                ontap: (() {
                                  _focusNodeinput.unfocus();
                                  if (_isvoice) {
                                    setState(() {
                                      _isvoice = false;
                                    });
                                  }
                                }),
                              )
                            : PEOCButton.iconButton(
                                icon: const Icon(PEOCiconFont.jianpanFont),
                                ontap: (() {
                                  _focusNodeinput.requestFocus();
                                  if (_isvoice == false) {
                                    setState(() {
                                      _isvoice = true;
                                    });
                                  }
                                }),
                              ),
                        Flexible(
                            child: _isvoice
                                ? Container(
                                    constraints: BoxConstraints(
                                      minHeight: 34.h,
                                    ),
                                    margin: EdgeInsets.fromLTRB(0, 6.h, 0, 6.h),
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.fromLTRB(8.r, 3.h, 8.r, 5.h),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          242, 242, 242, 1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      minLines: 1,
                                      controller: inputController,
                                      focusNode: _focusNodeinput,
                                      onChanged: ((value) {
                                        print(value);
                                        if (inputController.text.isNotEmpty) {
                                          if (_isshowsend == false) {
                                            setState(() {
                                              _isshowsend = true;
                                            });
                                          }
                                        } else {
                                          if (_isshowsend) {
                                            setState(() {
                                              _isshowsend = false;
                                            });
                                          }
                                        }
                                      }),
                                      autofocus: false,
                                      style: TextStyle(
                                        color:
                                            const Color.fromRGBO(17, 24, 39, 1),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "syhtFamily",
                                        height: 20 / 15,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
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
                                  )
                                : PEOCVoiceSender()),
                        PEOCButton.iconButton(
                          icon: Icon(
                            PEOCiconFont.emojiFont,
                            color: _inputType == InputType.emoj
                                ? const Color.fromARGB(255, 253, 88, 33)
                                : Colors.black,
                          ),
                          ontap: () {
                            // "笑脸"
                            if (_inputType == InputType.emoj) {
                              setState(() {
                                _inputType = InputType.none;
                              });
                              // _focusNodeinput.requestFocus();
                            } else {
                              _focusNodeinput.unfocus();
                              setState(() {
                                _inputType = InputType.emoj;
                              });
                            }
                          },
                        ),
                        _isshowsend
                            ? Container(
                                width: 35.w,
                                height: 43.h,
                                alignment: Alignment.center,
                                child: PEOCButton.textButton(
                                    key: UniqueKey(),
                                    msg: "发送",
                                    ontap: () {
                                      print("发送");
                                    }),
                              )
                            : PEOCButton.iconButton(
                                key: UniqueKey(),
                                icon: const Icon(PEOCiconFont.pluscircleFont),
                                ontap: () {
                                  //打开输入框
                                  print("加号");
                                  if (_inputType == InputType.add) {
                                    _focusNodeinput.requestFocus();
                                  }
                                  //打开表情键盘
                                  else {
                                    _focusNodeinput.unfocus();
                                    setState(() {
                                      _inputType = InputType.add;
                                    });
                                  }
                                },
                              ),
                      ],
                    ),
                  ))
              : Container(
                  key: const ValueKey("quickcommand"),
                  constraints: BoxConstraints(
                    minHeight: 54.h,
                  ),
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(125, 70, 70, 70)
                              .withOpacity(0.15),
                          spreadRadius: 0.0,
                          blurRadius: 3,
                          offset: const Offset(0, -2),
                        ),
                      ]),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.fromLTRB(15.w, 0, 16.w, 6.h),
                    child: Row(
                      children: [
                        PEOCButton.iconButton(
                          icon: const Icon(PEOCiconFont.jianpanFont),
                          ontap: (() {
                            setState(() {
                              _isinput = true;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height:
                (_inputType == InputType.emoj || _inputType == InputType.add)
                    ? 300.h
                    : _inputType == InputType.input
                        ? MediaQuery.of(context).viewInsets.bottom
                        : MediaQuery.of(context).padding.bottom,
            child: IndexedStack(
              index: _inputType == InputType.emoj
                  ? 1
                  : _inputType == InputType.add
                      ? 2
                      : 0,
              children: [
                Container(),
                Container(
                  width: PEOCConfig.DESIGNEDWIDTH.w,
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
                  child:
                      PEOCEmojiPicker(textEditionController: inputController),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: Colors.yellow,
                  child: const Text("添加"),
                ),
              ],
            )),
        // AnimatedContainer(
        //   duration: const Duration(milliseconds: 100),
        //   transformAlignment: Alignment.topCenter,
        //   height: _inputType == InputType.emoj
        //       ? 300.h
        //       : _inputType == InputType.input
        //           ? MediaQuery.of(context).viewInsets.bottom
        //           : MediaQuery.of(context).padding.bottom,
        //   width: PEOCConfig.DESIGNEDWIDTH.w,
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       // 来点黑色到透明的渐变优雅一下
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       colors: [
        //         Color.fromRGBO(210, 51, 51, 0.2),
        //         Color.fromRGBO(251, 1, 1, 0.8),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNodeinput.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class MSSlideTransitionX extends AnimatedWidget {
  MSSlideTransitionX({
    this.dir = AxisDirection.down,
    required Animation<double> position,
    required this.child,
    this.transformHitTests = true,
  }) : super(listenable: position) {
    switch (dir) {
      case AxisDirection.left:
        // 左出右进
        _tween =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        // 右出左进
        _tween =
            Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.up:
        // 上出下进
        _tween =
            Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        // 下出上进
        _tween =
            Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      default:
    }
  }

  final Widget child;
  final bool transformHitTests;
  final AxisDirection dir;
  late final Tween<Offset> _tween;
  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);
    if (position.status == AnimationStatus.reverse) {
      switch (dir) {
        case AxisDirection.left:
          // 左出右进
          offset = Offset(offset.dx, offset.dy);
          break;
        case AxisDirection.right:
          // 右出左进
          offset = Offset(offset.dx, offset.dy);
          break;
        case AxisDirection.up:
          // 上出下进
          offset = Offset(offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          // 下出上进
          offset = Offset(offset.dx, offset.dy);
          break;
        default:
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
