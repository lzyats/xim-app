import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineGenderController extends BaseController {
  RxString gender = ToolsStorage().local().gender.obs;
  RxBool hasShownDialog = false.obs; // 标记弹窗是否已显示（避免重复弹出）
  void editGender(String value) {
    gender.value = value;
    update();
  }

  // 提交
  Future<void> submit(String gender) async {
    // 执行
    await RequestMine.editGender(gender);
    // 取消
    ToolsSubmit.cancel();
  }
}
