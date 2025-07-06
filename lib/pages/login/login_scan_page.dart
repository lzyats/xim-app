import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/login/login_scan_controller.dart';

import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_button.dart';

// 扫码登录
class LoginScanPage extends GetView<LoginScanController> {
  // 路由地址
  static const String routeName = '/login_scan';
  const LoginScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginScanController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('扫码登录'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            children: [
              const Icon(
                AppFonts.e605,
                size: 100,
              ),
              const Text(
                '电脑版登录确认',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              WidgetButton(
                label: '确认登录',
                onTap: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.submit();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Text(
                  '取消登录',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
