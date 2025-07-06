import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineGenderController extends BaseController {
  String gender = ToolsStorage().local().gender;

  void editGender(String value) {
    gender = value;
    update();
  }

  // 提交
  Future<void> submit() async {
    // 执行
    await RequestMine.editGender(gender);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }
}
