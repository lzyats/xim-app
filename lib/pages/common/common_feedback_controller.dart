import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_upload.dart';

class CommonFeedbackController extends BaseController {
  List<String> pathList = [];
  TextEditingController contentController = TextEditingController();

  // 提交
  Future<void> submit() async {
    // 内容
    String content = contentController.text.trim();
    // 上传
    List<String> dataList = await ToolsUpload.uploadFileList(pathList);
    // 执行
    await RequestCommon.feedback(dataList, content);
    // 取消
    ToolsSubmit.cancel();
    // 跳转
    Get.back();
  }

  @override
  void onClose() {
    contentController.dispose();
    super.onClose();
  }
}
