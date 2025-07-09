import 'dart:async';

import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class LoginRegisterController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 获取手机号
    var phone = phoneController.text.trim();
    var email = emailController.text.trim();
    // 定时任务
    if (toolsTimer.start()) {
      return;
    }
    // 执行
    String code = await RequestAuth.sendCode(phone, '0', email: email);
    // 验证码回填
    codeController.text = code;
  }

  // 注册账号
  Future<void> submit() async {
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String code = codeController.text.trim();
    // 执行
    AuthModel02 model = await RequestAuth.register(phone, email, code);
    // 取消
    ToolsSubmit.cancel();
    // 取消
    toolsTimer.cancel();
    // 登录成功
    await _success(model);
  }

  // 登录成功
  Future<void> _success(AuthModel02 model) async {
    // 取消定时
    toolsTimer.cancel();
    // 更新token
    ToolsStorage().token(token: model.token);
    // 状态
    ToolsStorage().status(value: MiddleStatus.normal);
    // 查询详情
    await RequestMine.getInfo();
    // 跳转
    Get.offAllNamed(MainPage.routeName);
    // 提示
    EasyLoading.showToast('注册成功');
  }
}
