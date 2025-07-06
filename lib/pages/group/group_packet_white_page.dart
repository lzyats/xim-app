import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_packet_white_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 红包白名单
class GroupPacketWhitePage extends GetView<GroupPacketWhiteController> {
  // 路由地址
  static const String routeName = '/group_packet_white';
  const GroupPacketWhitePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupPacketWhiteController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('红包白名单'),
        actions: [
          WidgetAction(
            onTap: () {
              if (ToolsSubmit.call()) {
                // 提交
                controller.editPacketWhite();
              }
            },
          ),
        ],
      ),
      body: GetBuilder<GroupPacketWhiteController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          selectList: controller.selectList,
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
