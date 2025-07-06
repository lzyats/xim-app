import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_inform_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_grid.dart';
import 'package:alpaca/widgets/widget_inform.dart';

// 好友举报
class FriendInformPage extends GetView<FriendInformController> {
  // 路由地址
  static const String routeName = '/friend_inform';
  const FriendInformPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendInformController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('用户举报'),
          actions: [
            WidgetAction(
              onTap: () {
                _submit();
              },
            ),
          ],
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

  // 提交
  _submit() {
    if (ToolsSubmit.progress()) {
      return;
    }
    // 校验
    _checkContent();
    if (ToolsSubmit.call()) {
      // 提交
      controller.submit();
    }
  }
}
