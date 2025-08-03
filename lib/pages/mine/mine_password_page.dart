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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('修改密码'), // 标题文本颜色默认黑色
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
        ),
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
        decoration: InputDecoration(
          hintText: '请输入旧密码',
          prefixIcon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
          // 聚焦状态边框
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
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
        decoration: InputDecoration(
          hintText: '请输入新密码',
          counterText: AppConfig.passText,
          prefixIcon: Icon(Icons.lock),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
          // 聚焦状态边框
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
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
