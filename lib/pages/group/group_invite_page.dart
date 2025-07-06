import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_invite_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 邀请好友
class GroupInvitePage extends GetView<GroupInviteController> {
  // 路由地址
  static const String routeName = '/group_invite';
  const GroupInvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupInviteController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('邀请好友'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              if (controller.selectList.isEmpty) {
                throw Exception('请至少选择一个好友哦');
              }
              if (ToolsSubmit.call()) {
                // 提交
                controller.invite();
              }
            },
          ),
        ],
      ),
      body: GetBuilder<GroupInviteController>(builder: (builder) {
        String memberTotal = controller.chatGroup.memberTotal;
        return WidgetContact(
          header: WidgetCommon.tips('当前群容量：$memberTotal人'),
          dataList: controller.dataList,
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
