import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_gender_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置性别
class MineGenderPage extends GetView<MineGenderController> {
  // 路由地址
  static const String routeName = '/mine_gender';
  const MineGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineGenderController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改性别'),
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
      body: Column(
        children: [
          _buildGender(),
        ],
      ),
    );
  }

  _buildGender() {
    return SingleChildScrollView(
      child: GetBuilder<MineGenderController>(
        builder: (builder) {
          return Column(
            children: [
              RadioListTile(
                title: const Text('男'),
                value: '1',
                groupValue: controller.gender,
                onChanged: (value) {
                  controller.editGender(value!);
                },
              ),
              RadioListTile(
                title: const Text('女'),
                value: '2',
                groupValue: controller.gender,
                onChanged: (value) {
                  controller.editGender(value!);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
