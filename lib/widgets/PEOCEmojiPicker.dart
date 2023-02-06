/*
 * @Author: YJR-1100
 * @Date: 2023-02-06 16:34:43
 * @LastEditors: YJR-1100
 * @LastEditTime: 2023-02-06 17:58:39
 * @FilePath: \PE-Over-Cloud\Client\lib\widgets\PEOCEmojiPicker.dart
 * @Description: 表情组件
 * 
 * Copyright (c) 2023 by yjr-1100/CSU, All Rights Reserved. 
 */

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pe_over_cloud/config/peocdesign.dart';

class PEOCEmojiPicker extends StatefulWidget {
  PEOCEmojiPicker({super.key, required this.textEditionController});
  TextEditingController textEditionController;
  @override
  State<PEOCEmojiPicker> createState() => _PEOCEmojiPickerState();
}

class _PEOCEmojiPickerState extends State<PEOCEmojiPicker> {
  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onBackspacePressed: () {
        // Do something when the user taps the backspace button (optional)
        // Set it to null to hide the Backspace-Button
      },
      textEditingController: widget
          .textEditionController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
        columns: 7,
        emojiSizeMax: 24.h *
            (foundation.defaultTargetPlatform == TargetPlatform.iOS
                ? 1.30
                : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
        verticalSpacing: 0,
        horizontalSpacing: 0,
        gridPadding: EdgeInsets.zero,
        initCategory: Category.RECENT,
        bgColor: Colors.white,
        indicatorColor: PEOCConfig.THEMECOLOR,
        iconColor: Colors.grey,
        iconColorSelected: PEOCConfig.THEMECOLOR,
        backspaceColor: PEOCConfig.THEMECOLOR,
        skinToneDialogBgColor: Colors.white,
        skinToneIndicatorColor: const Color.fromARGB(255, 191, 191, 191),
        enableSkinTones: true,
        showRecentsTab: true,
        recentsLimit: 28,
        noRecents: Text(
          'No Recents',
          style: TextStyle(fontSize: 20.sp, color: Colors.black26),
          textAlign: TextAlign.center,
        ), // Needs to be const Widget
        loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
        tabIndicatorAnimDuration: const Duration(milliseconds: 200),
        categoryIcons: const CategoryIcons(),
        buttonMode: ButtonMode.CUPERTINO,
      ),
    );
  }
}
