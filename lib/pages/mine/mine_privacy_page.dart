import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_privacy_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_line.dart';

// 账号隐私
class MinePrivacyPage extends GetView<MinePrivacyController> {
  // 路由地址
  static const String routeName = '/mine_privacy';
  const MinePrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MinePrivacyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('账号隐私'),
      ),
      body: GetBuilder<MinePrivacyController>(
        builder: (builder) {
          LocalUser localUser = controller.localUser;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                WidgetLineRow(
                  'ID查找',
                  subtitle: '开启后允许他人通过ID搜索加你为好友',
                  widget: Switch(
                    value: localUser.privacyNo == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyNo(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '手机号码',
                  subtitle: '开启后允许他人通过手机号码搜索加你为好友',
                  widget: Switch(
                    value: localUser.privacyPhone == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyPhone(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '二维码',
                  subtitle: '开启后允许他人通过二维码搜索加你为好友',
                  widget: Switch(
                    value: localUser.privacyScan == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyScan(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '名片',
                  subtitle: '开启后允许他人通过名片加你为好友',
                  widget: Switch(
                    value: localUser.privacyCard == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyCard(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '群聊',
                  subtitle: '开启后允许他人通过群聊加你为好友',
                  widget: Switch(
                    value: localUser.privacyGroup == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyGroup(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
