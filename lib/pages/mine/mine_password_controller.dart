import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MinePasswordController extends BaseController {
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();

  // 提交
  Future<void> submit() async {
    var oldPwd = oldPassController.text.trim();
    var newPwd = newPwdController.text.trim();
    // 执行
    await RequestMine.editPass(oldPwd, newPwd);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    oldPassController.dispose();
    newPwdController.dispose();
    super.onClose();
  }
}
