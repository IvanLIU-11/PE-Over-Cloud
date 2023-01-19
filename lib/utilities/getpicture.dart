/*
 * @Author: IvanLiu
 * @LastEditors: IvanLiu
 * @Date: 2023-01-19 15:26:26
 * @LastEditTime: 2023-01-19 15:54:40
 * @Descripttion: 获取用户本地图片
 */
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart'
    show
        AssetEntity,
        AssetPicker,
        AssetPickerConfig,
        AssetPickerTextDelegate,
        RequestType;

Future<List<String>?> onTapPickPicture(BuildContext context, int num) async {
  //从相册选取图片,用于上传运动员证书等,传入contex和照片数
  final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context,
      pickerConfig: AssetPickerConfig(
          maxAssets: num,
          requestType: RequestType.image,
          textDelegate: const AssetPickerTextDelegate()));
  if (entitys == null) return null;

  List<String> chooseImagesPath = [];
  //遍历
  for (var entity in entitys) {
    File? imgFile = await entity.file;
    if (imgFile != null) chooseImagesPath.add(imgFile.path);
  }
  print('选择照片路径:$chooseImagesPath');
  return chooseImagesPath;
}

Future<List<String>?> onTapPickVideo(BuildContext context, int num) async {
  //从相册选取视频,用于上传视频,传入contex和视频数
  final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context,
      pickerConfig:
          AssetPickerConfig(maxAssets: num, requestType: RequestType.video));
  if (entitys == null) return null;

  List<String> chooseImagesPath = [];
  //遍历
  for (var entity in entitys) {
    File? imgFile = await entity.file;
    if (imgFile != null) chooseImagesPath.add(imgFile.path);
  }
  print('选择照片路径:$chooseImagesPath');
  return chooseImagesPath;
}
