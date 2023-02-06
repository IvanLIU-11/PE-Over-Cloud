import 'package:flutter/material.dart';
import 'package:pe_over_cloud/widgets/PEOCText.dart';
import 'package:pe_over_cloud/widgets/PEOCiconFont.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
import 'package:pe_over_cloud/widgets/toastDialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class PEOCVoiceSender extends StatefulWidget {
  const PEOCVoiceSender({super.key});

  @override
  State<PEOCVoiceSender> createState() => _PEOCVoiceSenderState();
}

class _PEOCVoiceSenderState extends State<PEOCVoiceSender> {
  // 语音取消发送
  bool _iscancelsend = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        print("按下");
        showicontoast(
            widget: Container(
          padding: EdgeInsets.fromLTRB(0, 30.h, 0, 10.h),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  PEOCiconFont.voiceFont,
                  size: 60.sp,
                  // color: PEOCConfig.THEMECOLOR,
                  color: Colors.white,
                ),
                PEOCText.easyText(
                    color: Colors.white, text: "0:00", fontsize: 16.sp),
                PEOCText.easyText(
                    color: const Color.fromARGB(255, 233, 233, 233),
                    text: "手指上滑,取消发送",
                    fontsize: 16.sp)
              ]),
        ));
      },
      onLongPressEnd: (details) {
        if (_iscancelsend) {
          print("取消发送");
          setState(() {
            _iscancelsend = false; // 变回初始值
          });
          SmartDialog.dismiss();
        } else {
          print("发送");
          SmartDialog.dismiss();
        }
      },
      onLongPressMoveUpdate: (details) {
        if (details.offsetFromOrigin.dy <= -50.h) {
          print("上滑");
          setState(() {
            _iscancelsend = true; // 取消发送
          });
          showicontoast(
              widget: Container(
            padding: EdgeInsets.fromLTRB(0, 30.h, 0, 10.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    PEOCiconFont.voicecancelFont,
                    size: 60.sp,
                    color: PEOCConfig.THEMECOLOR,
                  ),
                  PEOCText.easyText(
                      color: Colors.white, text: "", fontsize: 16.sp),
                  PEOCText.easyText(
                      color: PEOCConfig.THEMECOLOR,
                      text: "松开手指,取消发送",
                      fontsize: 16.sp)
                ]),
          ));
        }
      },
      child: Container(
          constraints: BoxConstraints(
            minHeight: 34.h,
          ),
          margin: EdgeInsets.fromLTRB(0, 6.h, 0, 6.h),
          alignment: Alignment.center,
          padding: EdgeInsets.fromLTRB(8.r, 0, 8.r, 0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: PEOCText.easyText(
              color: PEOCConfig.THEMECOLOR,
              text: "按住 说话",
              fontFamily: "syhtRegularFamily",
              fontsize: 16.sp)),
    );
  }
}
