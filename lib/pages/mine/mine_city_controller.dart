import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineCityController extends BaseController {
  TextEditingController cityController = TextEditingController();
  String province = '';
  String city = '';

  // 获取详情
  void _onRefresh() {
    LocalUser localUser = ToolsStorage().local();
    onChanged(localUser.province, localUser.city);
  }

  // 提交
  Future<void> submit() async {
    // 执行
    await RequestMine.editCity(province, city);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 提交
  void onChanged(String p, String c) {
    province = p;
    city = c;
    cityController.text = '$province $city';
  }

  @override
  void onInit() {
    super.onInit();
    _onRefresh();
  }

  @override
  void onClose() {
    cityController.dispose();
    super.onClose();
  }
}
