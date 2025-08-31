import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// iOS 后台任务保活工具类
class BackgroundTaskService {
  static const MethodChannel _channel =
      MethodChannel('lansoft.com/background_task');
  static int? _backgroundTaskId; // 后台任务ID

  /// 启动后台任务：延长后台运行时间（最多30秒，足够音频加载和播放）
  static Future<void> startBackgroundTask() async {
    if (Platform.isIOS) {
      try {
        _backgroundTaskId =
            await _channel.invokeMethod<int>('startBackgroundTask');
        debugPrint("启动后台任务，ID: $_backgroundTaskId");
      } on PlatformException catch (e) {
        debugPrint("启动后台任务失败：${e.message}");
      }
    }
  }

  /// 结束后台任务：释放资源
  static Future<void> endBackgroundTask() async {
    if (Platform.isIOS && _backgroundTaskId != null) {
      try {
        await _channel.invokeMethod('endBackgroundTask', _backgroundTaskId);
        debugPrint("结束后台任务，ID: $_backgroundTaskId");
        _backgroundTaskId = null;
      } on PlatformException catch (e) {
        debugPrint("结束后台任务失败：${e.message}");
      }
    }
  }
}
