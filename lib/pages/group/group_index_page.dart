import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_index_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 群聊列表
class GroupIndexPage extends GetView<GroupIndexController> {
  // 路由地址
  static const String routeName = '/group_index';
  const GroupIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupIndexController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Obx(
          () => Text('群聊(${controller.groupCount.value})'),
        ),
      ),
      body: GetBuilder<GroupIndexController>(builder: (builder) {
        if (controller.dataList.isEmpty) {
          return WidgetCommon.none();
        }
        return WidgetContact(
          dataList: controller.dataList,
          onTap: (ContactModel value) {
            ToolsRoute().chatPage(
              chatId: value.userId,
              nickname: value.nickname,
              portrait: value.portrait,
              chatTalk: ChatTalk.group,
            );
          },
        );
      }),
    );
  }
}
