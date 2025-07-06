import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_apply_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 好友申请
class FriendApplyPage extends GetView<FriendApplyController> {
  // 路由地址
  static const String routeName = '/friend_apply';
  const FriendApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendApplyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('好友申请'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkReason();
              if (ToolsSubmit.call()) {
                // 提交
                controller.submit();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildReason(),
          _buildRemark(),
        ],
      ),
    );
  }

  _buildReason() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller.reasonController,
        decoration: const InputDecoration(
          hintText: '请输入原因',
        ),
        maxLength: 20,
      ),
    );
  }

  _buildRemark() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller.remarkController,
        decoration: const InputDecoration(
          hintText: '请输入好友备注',
        ),
        maxLength: 15,
      ),
    );
  }

  // 校验
  _checkReason() {
    var reason = controller.reasonController.text.trim();
    if (reason.isEmpty) {
      throw Exception('请输入原因');
    }
  }
}
