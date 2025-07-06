import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/login/login_banned_page.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class LoginIndexController extends BaseController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  // 密码登录
  RxBool isPass = false.obs;
  // 勾选隐私协议
  RxBool isPrivacy = false.obs;
  // 定时任务
  final ToolsTimer toolsTimer = ToolsTimer();

  // 发送验证码
  Future<void> sendCode() async {
    // 获取手机号
    var phone = phoneController.text.trim();
    // 定时任务
    if (ToolsTimer().start()) {
      return;
    }
    // 执行
    String code = await RequestAuth.sendCode(phone, '1');
    // 验证码回填
    codeController.text = code;
  }

  // 密码登录
  Future<void> loginPass() async {
    String phone = phoneController.text.trim();
    String password = passController.text.trim();
    // 执行
    AuthModel02 model = await RequestAuth.loginPass(phone, password);
    // 取消
    ToolsSubmit.cancel();
    // 登录成功
    await _success(model);
  }

  // 验证码登录
  Future<void> loginCode() async {
    String phone = phoneController.text.trim();
    String code = codeController.text.trim();
    // 执行
    AuthModel02 model = await RequestAuth.loginCode(phone, code);
    // 取消
    ToolsSubmit.cancel();
    // 登录成功
    await _success(model);
  }

  // 登录成功
  Future<void> _success(AuthModel02 model) async {
    // 取消定时
    toolsTimer.cancel();
    // 更新token
    ToolsStorage().token(token: model.token);
    // 封禁
    if ('Y' == model.banned) {
      // 跳转
      Get.offAllNamed(LoginBannedPage.routeName);
    } else {
      ToolsStorage().status(value: MiddleStatus.normal);
      // 查询详情
      await RequestMine.getInfo();
      // 跳转
      Get.offAllNamed(MainPage.routeName);
      // 提示
      EasyLoading.showToast('登录成功');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 设置登录状态
    ToolsStorage().status(value: MiddleStatus.login);
  }
}
