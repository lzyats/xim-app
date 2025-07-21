import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class LoginForgotController extends BaseController {
  // 参数
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController safePassController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 获取手机号
    var phone = phoneController.text.trim();
    var safe = safePassController.text.trim();
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestAuth.sendCode(phone, '2', safe: safe);
    // 验证码回填
    codeController.text = code;
  }

  // 忘记密码
  Future<void> submit() async {
    String phone = phoneController.text.trim();
    String code = codeController.text.trim();
    String password = passController.text.trim();
    // 执行
    await RequestAuth.forgot(phone, code, password);
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
    safePassController.dispose();
    super.onClose();
  }
}
