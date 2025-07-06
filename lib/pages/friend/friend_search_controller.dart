import 'package:flutter/material.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';

class FriendSearchController extends BaseController {
  // 控制
  final TextEditingController textController = TextEditingController();
  // 搜索
  Future<void> search() async {
    refreshData = null;
    update();
    String param = textController.text.trim();
    refreshData = await RequestFriend.search(param);
    update();
    //  取消
    ToolsSubmit.cancel();
  }
}
