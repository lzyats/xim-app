import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manager_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 设置管理员
class GroupManagerPage extends GetView<GroupManagerController> {
  // 路由地址
  static const String routeName = '/group_manager';
  const GroupManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManagerController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '设置管理员',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                onTap: () {
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.setManager();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<GroupManagerController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          selectList: controller.selectList,
          mark: '管理员',
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
