import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupSearchController extends BaseController {
  // 控制
  final TextEditingController textController = TextEditingController();
  // 下拉刷新
  Future<void> search() async {
    refreshPageIndex = 1;
    refreshList = [];
    update();
    String param = textController.text.trim();
    refreshList = await RequestGroup.search(refreshPageIndex, param);
    update();
    // 取消
    ToolsSubmit.cancel();
  }

  // 上滑加载
  void onLoading() {
    String param = textController.text.trim();
    superLoading(
      RequestGroup.search(refreshPageIndex + 1, param),
    );
  }

  // 加入
  Future<void> join(String groupId, String source, String configAudit) async {
    await RequestGroup.join(groupId, source, configAudit);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }
}
