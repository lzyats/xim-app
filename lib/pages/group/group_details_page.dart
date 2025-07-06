import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_history.dart';
import 'package:alpaca/pages/group/group_details_controller.dart';
import 'package:alpaca/pages/group/group_inform_page.dart';
import 'package:alpaca/pages/group/group_invite_page.dart';
import 'package:alpaca/pages/group/group_manage_page.dart';
import 'package:alpaca/pages/group/group_member_page.dart';
import 'package:alpaca/pages/group/group_qrcode_page.dart';
import 'package:alpaca/pages/group/group_remark_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 群聊详情
class GroupDetailsPage extends GetView<GroupDetailsController> {
  // 路由地址
  static const String routeName = '/group_details';
  const GroupDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupDetailsController());
    return GetBuilder<GroupDetailsController>(
      builder: (builder) {
        ChatGroup chatGroup = controller.chatGroup;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('群详情'),
            actions: [
              WidgetAction(
                icon: const Icon(Icons.more_horiz),
                enable: MemberType.normal != chatGroup.memberType,
                onTap: () {
                  Get.toNamed(
                    GroupManagePage.routeName,
                    arguments: chatGroup.groupId,
                  );
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView(
              children: [
                WidgetLineRow(
                  '群头像',
                  widget: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      child: WidgetCommon.showAvatar(
                        chatGroup.portrait,
                        size: 55,
                      ),
                      onTap: () {
                        Get.to(
                          ShowImage(chatGroup.portrait),
                          transition: Transition.topLevel,
                        );
                      },
                    ),
                  ),
                  hight: 10,
                  arrow: false,
                ),
                WidgetLineRow(
                  '群名称',
                  value: chatGroup.groupName,
                  arrow: false,
                ),
                WidgetLineRow(
                  '群聊ID',
                  value: chatGroup.groupNo,
                  arrow: false,
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: chatGroup.groupNo));
                    EasyLoading.showToast('文本已复制');
                  },
                ),
                WidgetLineRow(
                  '群二维码',
                  widget: const Icon(Icons.qr_code),
                  onTap: () {
                    Get.toNamed(
                      GroupQrCodePage.routeName,
                      arguments: chatGroup,
                    );
                  },
                ),
                WidgetLineContent(
                  '群聊公告',
                  chatGroup.notice,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '成员类型',
                  value: chatGroup.memberType.label,
                  arrow: false,
                ),
                WidgetLineRow(
                  '群内昵称',
                  value: chatGroup.memberRemark,
                  // 备注
                  onTap: () {
                    if (MemberType.normal != chatGroup.memberType ||
                        'Y' == chatGroup.configNickname) {
                      Get.toNamed(
                        GroupRemarkPage.routeName,
                        arguments: chatGroup.groupId,
                      );
                    } else {
                      // 提醒
                      EasyLoading.showToast('管理员不允许成员修改群内昵称');
                    }
                  },
                  divider: false,
                  arrow: MemberType.normal != chatGroup.memberType ||
                      'Y' == chatGroup.configNickname,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '邀请好友',
                  subtitle: '邀请好友加入群聊',
                  enable: chatGroup.configInvite == 'Y',
                  onTap: () {
                    Get.toNamed(
                      GroupInvitePage.routeName,
                      arguments: chatGroup,
                    );
                  },
                ),
                WidgetLineRow(
                  '群聊成员',
                  subtitle: '可查看群内成员列表',
                  value: '${controller.memberSize}/${chatGroup.memberTotal}',
                  onTap: () {
                    Get.toNamed(
                      GroupMemberPage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '聊天记录',
                  subtitle: '可查看群内的聊天记录',
                  onTap: () {
                    Get.toNamed(
                      ChatHistory.routeName,
                      arguments: chatGroup.groupId,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '消息免打扰',
                  subtitle: '开启后可继续接收消息，但不提醒',
                  widget: Switch(
                    value: chatGroup.memberDisturb == 'Y',
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
                  '消息置顶',
                  subtitle: '开启后消息将显示在列表顶端',
                  widget: Switch(
                    value: chatGroup.memberTop == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        controller.setTop(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineCenter(
                  '举报群聊',
                  divider: false,
                  color: Colors.red,
                  onTap: () {
                    Get.toNamed(
                      GroupInformPage.routeName,
                      arguments: controller.groupId,
                    );
                  },
                ),
                WidgetCommon.border(),
                WidgetLineCenter(
                  '清空消息',
                  divider: false,
                  color: Colors.red,
                  onTap: () {
                    _clearHis(context);
                  },
                ),
                WidgetCommon.border(
                  enable: MemberType.master != chatGroup.memberType,
                ),
                WidgetLineCenter(
                  '退出群聊',
                  enable: MemberType.master != chatGroup.memberType,
                  color: Colors.red,
                  onTap: () {
                    _logout(context);
                  },
                ),
                WidgetCommon.border(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 清空消息
  _clearHis(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认清空消息吗？',
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
                Get.back();
                EventSetting().handle(
                  SettingModel(
                    SettingType.clear,
                    primary: controller.groupId,
                    value: controller.groupId,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // 退出群聊
  _logout(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认要退出当前群聊吗？',
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
                  controller.logout();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
