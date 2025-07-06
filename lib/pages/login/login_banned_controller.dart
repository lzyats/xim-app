import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/request/request_banned.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_upload.dart';

class LoginBannedController extends BaseController {
  List<String> pathList = [];
  TextEditingController contentController = TextEditingController();
  RxString remainStr = ''.obs;
  int remainInt = 0;

  // 查询详情
  Future<void> onRefresh() async {
    BannedModel model = await RequestBanned.getInfo();
    // 取消
    ToolsSubmit.cancel();
    if (model.banned == 'N') {
      ToolsStorage().status(value: MiddleStatus.normal);
      Get.offAllNamed(MainPage.routeName);
    } else {
      refreshData = model;
      remainInt = model.remain;
      update();
    }
  }

  // 退出
  void logout() async {
    await RequestAuth.logout();
  }

  // 提交
  Future<void> submit() async {
    // 内容
    String content = contentController.text.trim();
    // 上传
    List<String> dataList = await ToolsUpload.uploadFileList(pathList);
    // 执行
    await RequestBanned.appeal(dataList, content);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('提交成功');
    // 返回
    Get.back();
  }

  // 定时任务
  _listenTimer() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainInt--;
      if (remainInt < 1) {
        return;
      }
      remainStr.value = _format(remainInt);
    });
  }

  String _format(int remain) {
    String result = '';
    // 年
    int value = remain ~/ 31536000;
    if (value > 0) {
      result += '$value年';
      remain -= value * 31536000;
    }
    // 月
    value = remain ~/ 2592000;
    if (value > 0) {
      result += '$value月';
      remain -= value * 2592000;
    }
    // 日
    value = remain ~/ 86400;
    if (value > 0) {
      result += '$value日';
      remain -= value * 86400;
    }
    // 时
    value = remain ~/ 3600;
    if (value > 0) {
      result += '$value时';
      remain -= value * 3600;
    }
    // 分
    value = remain ~/ 60;
    if (value > 0) {
      result += '$value分';
      remain -= value * 60;
    }
    // 秒
    result += '$remain秒';
    return result;
  }

  @override
  void onInit() {
    super.onInit();
    ToolsStorage().status(value: MiddleStatus.banned);
    onRefresh();
    // 定时任务
    _listenTimer();
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
