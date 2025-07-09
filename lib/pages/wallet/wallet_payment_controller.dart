import 'dart:async';

import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class WalletPaymentController extends BaseController {
  // 密码
  TextEditingController phoneController = TextEditingController(
    text: ToolsStorage().local().phone,
  );
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();
  // 密码
  late String pass = '';

  // 发送验证码
  Future<void> sendCode() async {
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestMine.sendCode('3');
    // 验证码回填
    codeController.text = code;
  }

  // 设置密码
  Future<void> setPass() async {
    var code = codeController.text.trim();
    // 执行
    await RequestWallet.setPass(code, pass);
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
    passController.dispose();
    codeController.dispose();
    toolsTimer.cancel();
    super.onClose();
  }
}
