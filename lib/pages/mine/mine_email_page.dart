import 'package:alpaca/pages/mine/mine_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
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
      appBar: AppBar(
        title: const Text('我的邮箱'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkPhone();
              // 校验
              _checkCode();
              // 校验
              _checkEmail();
              // 提交
              if (ToolsSubmit.call()) {
                // 提交
                controller.setPass();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildPhone(),
            _buildCode(),
            _buildEmail(),
          ],
        ),
      ),
    );
  }

  _buildPhone() {
    return TextField(
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          ToolsRegex.regExpNumber,
        ),
        LengthLimitingTextInputFormatter(11),
      ],
      controller: controller.phoneController,
      decoration: const InputDecoration(
        hintText: '请输入手机号码',
        prefixIcon: Icon(Icons.phone_iphone),
      ),
    );
  }

  _buildCode() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
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
                // 校验
                _checkPhone();
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
        decoration: const InputDecoration(
          hintText: '请输入邮箱地址',
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  // 校验
  _checkPhone() {
    var phone = controller.phoneController.text.trim();
    if (!ToolsRegex.isPhone(phone)) {
      throw Exception('请输入正确的手机号码');
    }
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
