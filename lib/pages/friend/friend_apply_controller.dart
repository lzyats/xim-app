import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class FriendApplyController extends BaseController {
  TextEditingController reasonController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  late String userId;
  late FriendSource source;

  // 提交
  Future<void> submit() async {
    String reason = reasonController.text.trim();
    String remark = remarkController.text.trim();
    // 执行
    await RequestFriend.apply(userId, source, reason, remark);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    LocalUser localUser = ToolsStorage().local();
    reasonController.text = '我是${localUser.nickname}';
    Map<String, dynamic> data = Get.arguments;
    userId = data['userId'];
    source = data['source'];
  }

  @override
  void onClose() {
    reasonController.dispose();
    remarkController.dispose();
    super.onClose();
  }
}
