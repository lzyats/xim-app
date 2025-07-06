import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/tools/tools_submit.dart';

class LoginScanController extends BaseController {
  late String token;

  // 确认
  Future<void> submit() async {
    // 执行
    await RequestAuth.loginScan(token);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    token = Get.arguments;
  }
}
