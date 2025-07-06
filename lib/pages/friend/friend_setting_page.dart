import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_history.dart';
import 'package:alpaca/pages/friend/friend_setting_controller.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 好友设置
class FriendSettingPage extends GetView<FriendSettingController> {
  // 路由地址
  static const String routeName = '/friend_setting';
  const FriendSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendSettingController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('资料设置'),
      ),
      body: GetBuilder<FriendSettingController>(
        builder: (builder) {
          ChatFriend chatFriend = controller.refreshData;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                WidgetLineRow(
                  '消息置顶',
                  subtitle: '开启后消息将显示在列表顶端',
                  widget: Switch(
                    value: chatFriend.top == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.setTop(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '消息免打扰',
                  subtitle: '开启后可继续接收消息，但不提醒',
                  widget: Switch(
                    value: chatFriend.disturb == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.setDisturb(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '拉进黑名单',
                  subtitle: '开启后将对方拉进黑名单，不再接收对方消息',
                  widget: Switch(
                    value: chatFriend.black == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.setBlack(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '聊天记录',
                  subtitle: '可查看与好友的聊天记录',
                  onTap: () {
                    Get.toNamed(
                      ChatHistory.routeName,
                      arguments: chatFriend.userId,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineCenter(
                  '删除好友',
                  color: Colors.red,
                  onTap: () {
                    _delete(context);
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
              ],
            ),
          );
        },
      ),
    );
  }

  // 删除好友
  _delete(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          title: const Text('提示'),
          content: const Text('确认删除当前好友吗？'),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                // 返回
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.delFriend();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
