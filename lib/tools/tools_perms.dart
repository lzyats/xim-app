import 'dart:io';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:permission_handler/permission_handler.dart';

// 权限工具
class ToolsPerms {
  // 定位权限
  static Future<bool> location() async {
    ToolsSubmit.show();
    bool result = await _perms(Permission.location, '位置');
    ToolsSubmit.dismiss();
    if (result) {
      await AmapLocation.instance.updatePrivacyShow(true);
      await AmapLocation.instance.updatePrivacyAgree(true);
      await AmapLocation.instance.init(iosKey: AppConfig.amapIos);
      await AmapCore.init(AppConfig.amapIos);
    }
    return result;
  }

  // 麦克风
  static Future<bool> microphone() async {
    ToolsSubmit.show();
    bool result = await _perms(Permission.microphone, '麦克风');
    ToolsSubmit.dismiss();
    return result;
  }

  // 读取相册
  static Future<bool> photos() async {
    ToolsSubmit.show();
    bool result = false;
    if (Platform.isIOS) {
      result = await _perms(Permission.photos, '相册');
    } else {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        result = await _perms(Permission.storage, '存储');
      } else {
        result = await _perms(Permission.photos, '相机');
      }
    }
    ToolsSubmit.dismiss();
    return result;
  }

  // 视频
  static Future<bool> video() async {
    ToolsSubmit.show();
    bool result = await _perms(Permission.camera, '相机');
    if (result) {
      result = await _perms(Permission.microphone, '麦克风');
    }
    ToolsSubmit.dismiss();
    return result;
  }

  // 拍照
  static Future<bool> camera() async {
    ToolsSubmit.show();
    bool result = await _perms(Permission.camera, '相机');
    ToolsSubmit.dismiss();
    return result;
  }

  // 存储
  static Future<bool> storage() async {
    ToolsSubmit.show();
    bool result = false;
    if (Platform.isIOS) {
      result = await _perms(Permission.storage, '存储');
    } else {
      AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
      // Android 13 (API 33) 及以上
      if (androidInfo.version.sdkInt >= 33) {
        result = await _perms(Permission.photos, '相册');
        if (result) {
          result = await _perms(Permission.videos, '相册');
        }
        if (result) {
          result = await _perms(Permission.audio, '相册');
        }
      }
      // Android 12L (API 32)
      else if (androidInfo.version.sdkInt == 32) {
        result = await _perms(Permission.photos, '相册');
      }
      // Android 12 及以下
      else {
        result = await _perms(Permission.storage, '存储');
      }
    }
    ToolsSubmit.dismiss();
    return result;
  }

  // 权限
  static Future<bool> _perms(Permission permission, String label) async {
    // 获取权限
    PermissionStatus status = await permission.status;
    // 已授权
    if (status.isGranted) {
      return true;
    }
    // 已受限
    if (status.isLimited) {
      return true;
    }
    // 已拒绝
    if (status.isDenied) {
      await permission.request();
    }
    // 已受限
    else if (status.isRestricted) {
      await permission.request();
      _showDialog(label);
    }
    // 已永久拒绝
    else if (status.isPermanentlyDenied) {
      _showDialog(label);
    }
    return false;
  }

  // 显示弹框
  static _showDialog(String label) {
    showCupertinoDialog(
      context: AppConfig.navigatorKey.currentState!.context,
      builder: (builder) {
        return CupertinoAlertDialog(
          content: Text(
            '开启 [ $label ] 权限',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('拒绝'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('开启'),
              onPressed: () {
                // 返回
                Get.back();
                // 去设置权限
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }
}
