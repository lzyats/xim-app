import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_remark_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 设置备注
class GroupRemarkPage extends GetView<GroupRemarkController> {
  // 路由地址
  static const String routeName = '/group_remark';
  const GroupRemarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupRemarkController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('修改群内昵称'),
          actions: [
            WidgetAction(
              onTap: () {
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.setRemark();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              WidgetCommon.tips(
                '我的昵称',
                textAlign: TextAlign.left,
              ),
              _buildNickname(),
              const SizedBox(
                height: 10,
              ),
              WidgetCommon.tips(
                '群内昵称',
                textAlign: TextAlign.left,
              ),
              _buildGroupRemark(),
            ],
          ),
        ),
      ),
    );
  }

  _buildNickname() {
    return TextField(
      controller: controller.nicknameController,
      decoration: const InputDecoration(),
      readOnly: true,
    );
  }

  _buildGroupRemark() {
    return TextField(
      maxLength: 15,
      controller: controller.remarkController,
      decoration: const InputDecoration(
        hintText: '请输入群内昵称',
      ),
    );
  }
}
