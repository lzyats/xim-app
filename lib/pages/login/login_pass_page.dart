import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/login/login_pass_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:alpaca/widgets/widget_upload.dart';

// 设置密码
class LoginPassPage extends GetView<LoginPassController> {
  // 路由地址
  static const String routeName = '/login_pass';
  // 路由编码
  static const int routeCode = 506;
  const LoginPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginPassController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('设置密码'),
          actions: [
            WidgetAction(
              onTap: () {
                if (ToolsSubmit.progress()) {
                  return;
                } // 校验
                _checkNickname();
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
              _buildPortrait(context),
              _buildNickname(),
              _buildPass(),
            ],
          ),
        ),
      ),
    );
  }

  _buildPortrait(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: WidgetLineRow(
        '头像',
        widget: Obx(
          () => WidgetCommon.showAvatar(
            controller.portrait.string,
            size: 65,
          ),
        ),
        onTap: () {
          WidgetUpload.image(
            context,
            onTap: (value) {
              if (ToolsSubmit.call()) {
                // 提交
                controller.editPortrait(value);
              }
            },
          );
        },
      ),
    );
  }

  _buildNickname() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        maxLength: 15,
        controller: controller.nicknameController,
        decoration: const InputDecoration(
          hintText: '请输入昵称',
          prefixIcon: Icon(AppFonts.e677),
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
  _checkNickname() {
    var nickname = controller.nicknameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('请输入昵称');
    }
  }

  // 校验
  _checkPass() {
    var pass = controller.passController.text.trim();
    if (pass.isEmpty) {
      throw Exception('请输入密码');
    }
  }
}
