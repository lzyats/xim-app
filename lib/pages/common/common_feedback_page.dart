import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/pages/common/common_feedback_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_grid.dart';

// 建议反馈
class CommonFeedbackPage extends GetView<CommonFeedbackController> {
  // 路由地址
  static const String routeName = '/common_feedback';
  const CommonFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonFeedbackController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('建议反馈'),
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
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(),
              Flexible(
                fit: FlexFit.tight,
                child: _buildImages(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImages() {
    return WidgetGrid(
      length: 3,
      onChange: (dataList) {
        controller.pathList = dataList;
      },
    );
  }

  _buildContent() {
    return TextField(
      controller: controller.contentController,
      maxLines: 5,
      maxLength: 200,
      decoration: const InputDecoration(
        hintText: '请输入内容',
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
