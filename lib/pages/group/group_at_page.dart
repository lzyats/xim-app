import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_at_controller.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// @页面
class GroupAtPage extends GetView<GroupAtController> {
  // 路由地址
  static const String routeName = '/group_at';
  const GroupAtPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupAtController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(controller.localChat.title),
        actions: [
          WidgetAction(
            onTap: () {
              // 提交
              controller.submit();
            },
          ),
        ],
      ),
      body: GetBuilder<GroupAtController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
