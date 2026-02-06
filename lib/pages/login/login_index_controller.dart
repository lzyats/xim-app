import 'dart:async';

import 'package:alpaca/request/request_robot.dart';
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
import 'package:restart_app/restart_app.dart';

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
  SysConfig localConfig = ToolsStorage().sysConfig();


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

  /// 新增：处理服务线路配置存储逻辑
  /// [newConfig]：待存储的新服务配置（含HTTP/WS地址）
  /// [routeName]：选中线路的名称
  Future<void> saveRouteConfig(SysConfig newConfig, String routeName) async {
    try {
      // 1. 等待存储操作完全完成（关键！）
      await ToolsStorage().sysConfig(value: newConfig);
      print(newConfig.toJson().toString());

      // 2. 提示用户（延迟3秒，确保用户看到提示）
      EasyLoading.showSuccess('服务器配置成功，将在3秒后重启动生效');
      await Future.delayed(const Duration(seconds: 3));

      // 3. 执行请求重置（使新配置生效）
      //ToolsRequest.reset();
      Restart.restartApp(); // 如需重启App可取消注释（需导入对应包）

    } catch (e) {
      // 捕获存储异常，避免崩溃
      EasyLoading.showError('配置存储失败，请重试');
      debugPrint('存储配置错误：$e');
    }
  }

  @override
  void onInit() async {
    super.onInit();
    // 设置登录状态
    ToolsStorage().status(value: MiddleStatus.login);
    //防止被清空线路信息
    ToolsStorage().sysConfig(value: localConfig);
    print('线路信息：'+localConfig.toJson().toString());
    // 获取机器人列表
    RequestRobot.getRobotList();
  }
}
