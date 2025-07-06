import 'dart:async';

import 'package:get/get.dart';

// 定时任务
// eg：
// final ToolsTimer toolsTimer = ToolsTimer();
class ToolsTimer {
  ToolsTimer._();
  static ToolsTimer? _singleton;
  factory ToolsTimer() => _singleton ??= ToolsTimer._();
  // 初始倒计时时间
  int count = 0;
  // 时间计数器
  late Timer _timer;
  // 初始文本
  static const String _text = '获取验证码';
  // 按钮初始文本
  RxString sendText = _text.obs;

  // 执行定时任务
  bool start() {
    if (count > 0) {
      return true;
    }
    count = 60;
    // 执行
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (count-- < 2) {
          // 取消
          _timer.cancel();
          sendText.value = _text;
        } else {
          sendText.value = '重新发送($count)';
        }
      },
    );
    return false;
  }

  // 取消定时任务
  void cancel() {
    if (count != 0) {
      _timer.cancel();
    }
    count = 0;
    sendText.value = _text;
  }
}
