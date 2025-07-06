import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_upload.dart';

class GroupInformController extends BaseController {
  String informType = '1';
  List<String> pathList = [];
  TextEditingController contentController = TextEditingController();
  late String groupId;

  // 提交
  Future<void> submit() async {
    // 内容
    String content = contentController.text.trim();
    // 上传
    List<String> dataList = await ToolsUpload.uploadFileList(pathList);
    // 执行
    await RequestGroup.inform(informType, groupId, dataList, content);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    groupId = Get.arguments;
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
