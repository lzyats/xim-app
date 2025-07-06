import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_upload.dart';
import 'package:alpaca/widgets/widget_bottom.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// 上传组件
class WidgetUpload {
  // 拍摄/图片
  static Future<void> image(
    BuildContext context, {
    bool upload = true,
    required Function(String value) onTap,
  }) async {
    WidgetBottom([
      BottomModel(
        '图片',
        onTap: () async {
          // 关闭
          Get.back();
          // 权限
          bool result = await ToolsPerms.photos();
          if (!result) {
            return;
          }
          // 选取
          // ignore: use_build_context_synchronously
          String portrait = await _image(context, upload: upload);
          // 修改
          onTap.call(portrait);
        },
      ),
      BottomModel(
        '拍照',
        onTap: () async {
          // 关闭
          Get.back();
          // 权限
          bool result = await ToolsPerms.camera();
          if (!result) {
            return;
          }
          // 拍照
          // ignore: use_build_context_synchronously
          String portrait = await _image(context, camera: true, upload: upload);
          // 修改
          onTap.call(portrait);
        },
      ),
    ]);
  }

  // 拍摄/图片
  static Future<String> _image(
    BuildContext context, {
    bool camera = false,
    required bool upload,
  }) async {
    // 对象
    AssetEntity? entity;
    // 拍照
    if (camera) {
      entity = await CameraPicker.pickFromCamera(context);
    }
    // 本地选取
    else {
      // 选取
      List<AssetEntity>? dataList = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 1,
          requestType: RequestType.image,
          pathNameBuilder: (AssetPathEntity path) {
            return WidgetCommon.pathName(path);
          },
        ),
      );
      entity = dataList?.first;
    }
    // 判断
    if (entity == null) {
      return '';
    }
    File? file = await entity.file;
    String path = file!.path;
    if (upload) {
      // 上传
      path = await ToolsUpload.uploadFile(file.path);
    }
    return path;
  }
}
