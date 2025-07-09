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
        appBar: AppBar(
          title: const Text('找回密码'),
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
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.phone_iphone),
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
          decoration: const InputDecoration(
            hintText: '请输入验证码',
            prefixIcon: Icon(Icons.lock),
          ),
        ),
        Positioned(
          right: 10,
          child: GestureDetector(
            onTap: () {
              // 提交
              controller.sendCode();
            },
            child: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                color: Colors.grey[200],
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
      ],
    );
  }

  _buildPass() {
    return TextField(
      obscureText: true,
      controller: controller.passController,
      decoration: const InputDecoration(
        hintText: '请输入密码',
        prefixIcon: Icon(Icons.lock),
        counterText: AppConfig.passText,
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
