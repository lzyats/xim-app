import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';

class FriendSettingController extends BaseController {
  // 删除好友
  Future<void> delFriend() async {
    // 执行
    await RequestFriend.delFriend(refreshData.userId);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 好友拉黑
  Future<void> setBlack(String black) async {
    // 设置
    refreshData.black = black;
    update();
    // 执行
    await RequestFriend.setBlack(refreshData.userId, black);
    // 取消
    ToolsSubmit.cancel();
  }

  // 好友拉黑
  Future<void> setTop(String top) async {
    // 设置
    refreshData.top = top;
    update();
    // 执行
    await RequestFriend.setTop(refreshData.userId, top);
    // 取消
    ToolsSubmit.cancel();
  }

  // 好友静默
  Future<void> setDisturb(String disturb) async {
    // 设置
    refreshData.disturb = disturb;
    update();
    // 执行
    await RequestFriend.setDisturb(refreshData.userId, disturb);
    // 取消
    ToolsSubmit.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData = Get.arguments;
  }
}
