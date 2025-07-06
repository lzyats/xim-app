import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineNicketnameController extends BaseController {
  TextEditingController nicknameController =
      TextEditingController(text: ToolsStorage().local().nickname);

  // 提交
  Future<void> submit() async {
    String nickname = nicknameController.text.trim();
    // 执行
    await RequestMine.editNickname(nickname);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
  }
}
