import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_scan_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 扫码群聊
class GroupScanPage extends GetView<GroupScanController> {
  // 路由地址
  static const String routeName = '/group_scan';
  const GroupScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupScanController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('扫码加群'),
      ),
      body: GetBuilder<GroupScanController>(
        builder: (builder) {
          return _buildItem(context);
        },
      ),
    );
  }

  _buildItem(
    BuildContext context,
  ) {
    GroupModel03? model = controller.refreshData;
    if (model == null) {
      return Expanded(child: WidgetCommon.none());
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          WidgetCommon.showAvatar(
            model.portrait,
            size: 75,
          ),
          const SizedBox(
            height: 20,
          ),
          Text('群名：${model.groupName}'),
          const SizedBox(
            height: 20,
          ),
          Text('群ID：${model.groupNo}'),
          WidgetButton(
            label: '申请入群',
            onTap: () {
              _join(context);
            },
          ),
        ],
      ),
    );
  }

  // 加入群聊
  _join(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认要加入当前群聊吗？',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.join();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
