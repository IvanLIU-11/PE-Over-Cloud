import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';

//服务条款页

class ClausePage extends StatelessWidget {
  const ClausePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: PEOCConfig.THEMECOLOR,
          alignment: Alignment.center,
          child: const Text(
            "条款页面",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'syhtFamily',
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Positioned(
          bottom: 5.h,
          left: 137.5.w,
          child: SizedBox(
            width: 100.w,
            //height: 10.h,
            child: TextButton(
              onPressed: () {
                Get.toNamed('/');
              },
              child: const Text('同意'),
            ),
          ),
        )
      ],
    );
  }
}
