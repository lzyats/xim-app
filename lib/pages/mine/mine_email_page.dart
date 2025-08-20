import 'package:alpaca/pages/mine/mine_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 我的邮箱
class MineEmailPage extends GetView<MineEmailController> {
  // 路由地址
  static const String routeName = '/mine_email';
  const MineEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineEmailController());
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
            title: const Text(
              '我的邮箱',
              style: TextStyle(color: Colors.black),
            ),
            // 移除顶部导航栏中的完成按钮
            actions: [],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildPhone(),
            _buildCode(),
            _buildEmail(),
            // 在_buildEmail下方添加完成按钮
            Padding(
              padding: const EdgeInsets.only(top: 30), // 增加顶部间距，优化布局
              child: WidgetAction(
                label1: '立即修改',
                onTap: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  // 校验
                  _checkCode();
                  // 校验
                  _checkEmail();
                  // 提交
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.setEmail();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPhone() {
    return TextField(
      controller: controller.phoneController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_iphone),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
      ),
      readOnly: true,
    );
  }

  _buildCode() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  ToolsRegex.regExpNumber,
                ),
                LengthLimitingTextInputFormatter(6),
              ],
              controller: controller.codeController,
              decoration: InputDecoration(
                hintText: '请输入验证码',
                prefixIcon: const Icon(Icons.lock),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                // 提交
                controller.sendCode();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0463F7),
              ),
              child: Text(
                controller.toolsTimer.sendText.value,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [
          LengthLimitingTextInputFormatter(200),
        ],
        controller: controller.emailController,
        decoration: InputDecoration(
          hintText: '请输入邮箱地址',
          prefixIcon: const Icon(Icons.email),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // 校验
  _checkCode() {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }

  // 校验
  _checkEmail() {
    var email = controller.emailController.text.trim();
    if (!ToolsRegex.isEmail(email)) {
      throw Exception('请输入正确的邮箱地址');
    }
  }
}
