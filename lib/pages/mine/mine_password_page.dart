import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_password_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 修改密码
class MinePasswordPage extends GetView<MinePasswordController> {
  // 路由地址
  static const String routeName = '/mine_password';
  const MinePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MinePasswordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改密码'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkPass();
              if (ToolsSubmit.call()) {
                // 提交
                controller.submit();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildOldPass(),
            _buildNewPass(),
          ],
        ),
      ),
    );
  }

  _buildOldPass() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        obscureText: true,
        controller: controller.oldPassController,
        decoration: const InputDecoration(
          hintText: '请输入旧密码',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  _buildNewPass() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        obscureText: true,
        controller: controller.newPwdController,
        decoration: const InputDecoration(
          hintText: '请输入新密码',
          counterText: AppConfig.passText,
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  // 校验
  _checkPass() {
    var oldPass = controller.oldPassController.text.trim();
    var newPwd = controller.newPwdController.text.trim();
    if (oldPass.isEmpty) {
      throw Exception('请输入旧密码');
    }
    if (newPwd.isEmpty) {
      throw Exception('请输入新密码');
    }
  }
}
