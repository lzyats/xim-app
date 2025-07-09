import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MinePassController extends BaseController {
  // 密码
  TextEditingController passController = TextEditingController();

  // 提交
  Future<void> submit() async {
    // 密码
    String password = passController.text.trim();
    // 执行
    await RequestMine.setPass(password);
    // 取消
    ToolsSubmit.cancel();
    // 跳转
    Get.back();
  }

  @override
  void onClose() {
    passController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // 设置登录状态
    ToolsStorage().status(value: MiddleStatus.pass);
  }
}
