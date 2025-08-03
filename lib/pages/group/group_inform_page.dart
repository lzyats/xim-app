import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_inform_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_grid.dart';
import 'package:alpaca/widgets/widget_inform.dart';

// 群聊举报
class GroupInformPage extends GetView<GroupInformController> {
  // 路由地址
  static const String routeName = '/group_inform';
  const GroupInformPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupInformController());
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                '群聊举报',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                WidgetAction(
                  onTap: () {
                    if (ToolsSubmit.progress()) {
                      return;
                    }
                    // 校验
                    _checkContent();
                    if (ToolsSubmit.call()) {
                      // 提交
                      controller.submit();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetInform(
                onChange: (String value) {
                  controller.informType = value;
                },
              ),
              _buildContent(),
              Flexible(
                fit: FlexFit.tight,
                child: WidgetGrid(
                  length: 3,
                  onChange: (dataList) {
                    controller.pathList = dataList;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        maxLines: 5,
        maxLength: 200,
        controller: controller.contentController,
        decoration: const InputDecoration(
          hintText: '请输入举报内容',
        ),
      ),
    );
  }

  // 校验
  _checkContent() {
    var content = controller.contentController.text.trim();
    if (content.isEmpty) {
      throw Exception('请输入内容');
    }
  }
}
