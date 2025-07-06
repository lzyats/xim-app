import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_intro_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置签名
class MineIntroPage extends GetView<MineIntroController> {
  // 路由地址
  static const String routeName = '/mine_intro';
  const MineIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineIntroController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改签名'),
        actions: [
          WidgetAction(
            onTap: () {
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
            _buildIntro(),
          ],
        ),
      ),
    );
  }

  _buildIntro() {
    return TextField(
      maxLines: null,
      keyboardType: TextInputType.text,
      maxLength: 20,
      controller: controller.introController,
      decoration: const InputDecoration(
        hintText: '请输入签名',
      ),
    );
  }
}
