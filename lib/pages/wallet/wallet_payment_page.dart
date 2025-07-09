import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/wallet/wallet_payment_controller.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 支付页面
class WalletPaymentPage extends GetView<WalletPaymentController> {
  // 路由地址
  static const String routeName = '/wallet_payment';
  const WalletPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletPaymentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('支付密码'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              _checkCode();
              // 校验
              _checkPass();
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
            _buildPass(context),
          ],
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

  _buildPass(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        obscureText: true,
        readOnly: true,
        controller: controller.passController,
        decoration: const InputDecoration(
          hintText: '请输入新支付密码',
          prefixIcon: Icon(Icons.lock),
        ),
        onTap: () {
          WidgetCommon.showKeyboard(
            context,
            title: '请输入新支付密码',
            verify: false,
            operate: false,
            onPressed: (p0) {
              controller.pass = p0;
              controller.passController.text = '******';
            },
          );
        },
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
  _checkPass() {
    var pass = controller.pass.trim();
    if (pass.isEmpty) {
      throw Exception('请输入新密码');
    }
  }
}
