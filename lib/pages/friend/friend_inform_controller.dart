import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_upload.dart';

class FriendInformController extends BaseController {
  String informType = '1';
  List<String> pathList = [];
  TextEditingController contentController = TextEditingController();
  late String userId;

  // 提交
  Future<void> submit() async {
    // 内容
    String content = contentController.text.trim();
    // 上传
    List<String> dataList = await ToolsUpload.uploadFileList(pathList);
    // 执行
    await RequestFriend.inform(informType, userId, dataList, content);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    userId = Get.arguments;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
