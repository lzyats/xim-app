import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manage_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置群名
class GroupNamePage extends GetView<GroupManageController> {
  // 路由地址
  static const String routeName = '/group_name';
  const GroupNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManageController());
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
              '修改群名',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                onTap: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  // 校验
                  _checkGroupName();
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.editGroupName();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: _buildGroupName(),
    );
  }

  // 群名
  _buildGroupName() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: TextField(
        maxLength: 15,
        controller: controller.nameController,
        decoration: InputDecoration(
          hintText: '请输入群名',
          // 未聚焦状态边框
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 未聚焦时边框颜色
              width: 1,
            ),
          ),
          // 聚焦状态边框
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  // 校验
  _checkGroupName() {
    var nickname = controller.nameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('请输入群名');
    }
  }
}
