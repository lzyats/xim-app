import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineIntroController extends BaseController {
  TextEditingController introController =
      TextEditingController(text: ToolsStorage().local().intro);

  // 提交
  Future<void> submit() async {
    String intro = introController.text.trim();
    // 执行
    await RequestMine.editIntro(intro);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    introController.dispose();
    super.onClose();
  }
}
