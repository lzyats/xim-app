import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_nickname_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置昵称
class MineNicknamePage extends GetView<MineNicketnameController> {
  // 路由地址
  static const String routeName = '/mine_nickname';
  const MineNicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineNicketnameController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('修改昵称'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkNickname();
              if (ToolsSubmit.call()) {
                // 提交
                controller.submit();
              }
            },
          ),
        ],
      ),
      body: _buildNickname(),
    );
  }

  // 昵称
  _buildNickname() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        maxLength: 15,
        controller: controller.nicknameController,
        decoration: const InputDecoration(
          hintText: '请输入昵称',
        ),
      ),
    );
  }

  // 校验
  _checkNickname() {
    var nickname = controller.nicknameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('请输入昵称');
    }
  }
}
