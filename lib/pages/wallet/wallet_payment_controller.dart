import 'dart:async';

import 'package:alpaca/request/request_mine.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class WalletPaymentController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();
  // 密码
  late String pass = '';

  // 发送验证码
  Future<void> sendCode() async {
    // 获取手机号
    var phone = phoneController.text.trim();
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestMine.sendCode(phone, '3');
    // 验证码回填
    codeController.text = code;
  }

  // 设置密码
  Future<void> setPass() async {
    var phone = phoneController.text.trim();
    var code = codeController.text.trim();
    // 执行
    await RequestWallet.setPass(phone, code, pass);
    // 取消
    ToolsSubmit.cancel();
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
    passController.dispose();
    codeController.dispose();
    toolsTimer.cancel();
    super.onClose();
  }
}
