import 'package:alpaca/pages/mine/mine_forgot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 忘记密码
class MineForgotPage extends GetView<MineForgotController> {
  // 路由地址
  static const String routeName = '/mine_forgot';
  const MineForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineForgotController());
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                '找回密码',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                WidgetAction(
                  onTap: () {
                    if (ToolsSubmit.progress()) {
                      return;
                    }
                    // 校验
                    _checkPass();
                    // 校验
                    _checkCode();
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _buildPhone(),
              const SizedBox(
                height: 20,
              ),
              _buildCode(),
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

  _buildPhone() {
    return TextField(
      controller: controller.phoneController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_iphone),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
      ),
      readOnly: true,
    );
  }

  _buildCode() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        TextField(
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
        Positioned(
          right: 18,
          // 限制验证码按钮上下不超过外容器
          top: 2,
          bottom: 2,
          child: GestureDetector(
            onTap: () {
              controller.sendCode();
            },
            child: Obx(
              () => Container(
                // 取消垂直内边距，改用居中对齐
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.grey[200],
                child: Center(
                  // 文字垂直居中
                  child: Text(
                    controller.toolsTimer.sendText.value,
                    style: TextStyle(
                      color: AppTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildPass() {
    return TextField(
      obscureText: true,
      controller: controller.passController,
      decoration: InputDecoration(
        hintText: '请输入密码',
        prefixIcon: const Icon(Icons.lock),
        counterText: AppConfig.passText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
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

  // 校验
  _checkCode() {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }
}
