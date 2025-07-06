import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class LoginPassController extends BaseController {
  RxString portrait = ToolsStorage().local().portrait.obs;
  TextEditingController nicknameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  // 提交
  Future<void> submit() async {
    String nickname = nicknameController.text.trim();
    String password = passController.text.trim();
    // 执行
    await RequestMine.setPass(portrait.value, nickname, password);
    // 取消
    ToolsSubmit.cancel();
    // 跳转
    Get.offAllNamed(MainPage.routeName);
  }

  // 提交
  void editPortrait(String avatar) {
    portrait.value = avatar;
    // 取消
    ToolsSubmit.cancel();
  }

  @override
  void onClose() {
    nicknameController.dispose();
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
