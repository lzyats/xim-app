import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/robot/robot_index_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 服务列表
class RobotIndexPage extends GetView<RobotIndexController> {
  // 路由地址
  static const String routeName = '/robot_index';
  const RobotIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RobotIndexController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('官方服务'),
      ),
      body: GetBuilder<RobotIndexController>(builder: (builder) {
        if (controller.dataList.isEmpty) {
          return WidgetCommon.none();
        }
        return WidgetContact(
          search: false,
          dataList: controller.dataList,
          onTap: (ContactModel value) {
            ToolsRoute().chatPage(
              chatId: value.userId,
              nickname: value.nickname,
              portrait: value.portrait,
              chatTalk: ChatTalk.robot,
            );
          },
        );
      }),
    );
  }
}
