import 'dart:async';

import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class MineEmailController extends BaseController {
  // 参数
  TextEditingController phoneController = TextEditingController(
    text: ToolsStorage().local().phone,
  );
  TextEditingController codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestMine.sendCode('4');
    // 验证码回填
    codeController.text = code;
  }

  // 设置密码
  Future<void> setEmail() async {
    var code = codeController.text.trim();
    var email = emailController.text.trim();
    // 执行
    await RequestMine.setEmail(code, email);
    // 取消
    ToolsSubmit.cancel();
    // 取消
    toolsTimer.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    toolsTimer.cancel();
  }

  @override
  void onClose() {
    phoneController.dispose();
    codeController.dispose();
    emailController.dispose();
    toolsTimer.cancel();
    super.onClose();
  }
}
