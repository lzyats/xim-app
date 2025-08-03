import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_manage_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 群聊公告
class GroupNoticePage extends GetView<GroupManageController> {
  // 路由地址
  static const String routeName = '/group_notice';
  const GroupNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManageController());
    return Scaffold(
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
              '修改公告',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                onTap: () {
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.editNotice();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildNotice(),
          ],
        ),
      ),
    );
  }

  _buildNotice() {
    return TextField(
      minLines: 5,
      maxLines: null,
      keyboardType: TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'\n')),
      ],
      maxLength: 1000,
      controller: controller.noticeController,
      decoration: const InputDecoration(
        hintText: '请输入公告',
      ),
    );
  }
}
