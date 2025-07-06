import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class LoginForgotController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController passController1 = TextEditingController();
  TextEditingController passController2 = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 获取手机号
    var phone = phoneController.text.trim();
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestAuth.sendCode(phone, '2');
    // 验证码回填
    codeController.text = code;
  }

  // 忘记密码
  Future<void> submit() async {
    String phone = phoneController.text.trim();
    String code = codeController.text.trim();
    String password = passController1.text.trim();
    // 执行
    await RequestAuth.forgot(phone, code, password);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    passController1.dispose();
    passController2.dispose();
    super.onClose();
  }
}
