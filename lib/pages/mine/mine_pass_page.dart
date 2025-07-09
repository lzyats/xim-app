import 'package:alpaca/pages/mine/mine_pass_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 设置密码
class MinePassPage extends GetView<MinePassController> {
  // 路由地址
  static const String routeName = '/mine_pass';
  const MinePassPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MinePassController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('设置密码'),
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
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildPass(),
            ],
          ),
        ),
      ),
    );
  }

  _buildPass() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        obscureText: true,
        controller: controller.passController,
        decoration: const InputDecoration(
          hintText: '请输入密码',
          prefixIcon: Icon(Icons.lock),
          counterText: AppConfig.passText,
        ),
      ),
    );
  }

  // 校验
  _checkPass() {
    var pass = controller.passController.text.trim();
    if (pass.isEmpty) {
      throw Exception('请输入密码');
    }
  }
}
