import 'dart:async';

import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class MineForgotController extends BaseController {
  // 参数
  TextEditingController phoneController = TextEditingController(
    text: ToolsStorage().local().phone,
  );
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestMine.sendCode('5');
    // 验证码回填
    codeController.text = code;
  }

  // 忘记密码
  Future<void> submit() async {
    String code = codeController.text.trim();
    String password = passController.text.trim();
    // 执行
    await RequestMine.forgot(code, password);
    // 取消
    ToolsSubmit.cancel();
    // 取消
    toolsTimer.cancel();
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    passController.dispose();
    super.onClose();
  }
}
