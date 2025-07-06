import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineBirthdayController extends BaseController {
  TextEditingController birthdayController = TextEditingController();
  PDuration birthday = PDuration.now();
  PDuration min = PDuration.parse(DateTime.parse('19000101'));
  PDuration max = PDuration.now();

  // 获取详情
  void _onRefresh() {
    LocalUser localUser = ToolsStorage().local();
    String birth = localUser.birthday;
    onChanged(PDuration.parse(DateTime.parse(birth)));
  }

  // 提交
  Future<void> submit() async {
    String birth = birthdayController.text;
    // 执行
    await RequestMine.editBirthday(birth);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 提交
  void onChanged(PDuration birth) {
    birthday = birth;
    String year = _format(birth.year ?? 1970);
    String month = _format(birth.month ?? 01);
    String day = _format(birth.day ?? 01);
    birthdayController.text = '$year-$month-$day';
  }

  // 格式化
  String _format(int index) {
    if (index < 10) {
      return '0$index';
    }
    return '$index';
  }

  @override
  void onInit() {
    super.onInit();
    _onRefresh();
  }

  @override
  void onClose() {
    birthdayController.dispose();
    super.onClose();
  }
}
