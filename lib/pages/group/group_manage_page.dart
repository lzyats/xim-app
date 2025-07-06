import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/group/group_invite_page.dart';
import 'package:alpaca/pages/group/group_kicked_page.dart';
import 'package:alpaca/pages/group/group_level_page.dart';
import 'package:alpaca/pages/group/group_manager_page.dart';
import 'package:alpaca/pages/group/group_name_page.dart';
import 'package:alpaca/pages/group/group_nickname_page.dart';
import 'package:alpaca/pages/group/group_notice_page.dart';
import 'package:alpaca/pages/group/group_manage_controller.dart';
import 'package:alpaca/pages/group/group_packet_white_page.dart';
import 'package:alpaca/pages/group/group_speak_page.dart';
import 'package:alpaca/pages/group/group_trade_page.dart';
import 'package:alpaca/pages/group/group_transfer_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:alpaca/widgets/widget_upload.dart';

// 群聊管理
class GroupManagePage extends GetView<GroupManageController> {
  // 路由地址
  static const String routeName = '/group_manage';
  const GroupManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupManageController());
    return GetBuilder<GroupManageController>(
      builder: (builder) {
        ChatGroup chatGroup = controller.chatGroup;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('群管理'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ListView(
              children: [
                _buildHeader(context, chatGroup.portrait),
                WidgetLineRow(
                  '群名称',
                  value: chatGroup.groupName,
                  onTap: () {
                    Get.toNamed(GroupNamePage.routeName);
                  },
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
                  '成员类型',
                  value: chatGroup.memberType.label,
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '群聊扩容',
                  subtitle: '设置群聊最大可容纳成员总数',
                  value: '${controller.memberSize}/${chatGroup.memberTotal}',
                  onTap: () {
                    Get.toNamed(
                      GroupLevelPage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(
                  enable: AppConfig.groupTrade &&
                      MemberType.master == chatGroup.memberType,
                ),
                WidgetLineRow(
                  '未领红包',
                  enable: AppConfig.groupTrade &&
                      MemberType.master == chatGroup.memberType,
                  onTap: () {
                    Get.toNamed(
                      GroupTradePage.routeName,
                      arguments: chatGroup.groupId,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '群聊公告',
                  onTap: () {
                    Get.toNamed(GroupNoticePage.routeName);
                  },
                ),
                WidgetLineRow(
                  '公告置顶',
                  subtitle: '开启后群公告将在群聊窗口顶部显示',
                  widget: Switch(
                    value: chatGroup.noticeTop == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        controller.editNoticeTop(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  enable: MemberType.master == chatGroup.memberType,
                  '设置管理员',
                  subtitle: '设置群聊管理员',
                  onTap: () {
                    Get.toNamed(GroupManagerPage.routeName);
                  },
                ),
                WidgetLineRow(
                  enable: MemberType.master == chatGroup.memberType,
                  '转让群聊',
                  subtitle: '将群主转让给其他群聊成员',
                  onTap: () {
                    Get.toNamed(GroupTransferPage.routeName);
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '进群审批',
                  subtitle: '开启后进群需要群主/管理员审批才可进群',
                  widget: Switch(
                    value: chatGroup.configAudit == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigAudit(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '邀请好友',
                  subtitle: '邀请好友加入群聊',
                  onTap: () {
                    Get.toNamed(
                      GroupInvitePage.routeName,
                      arguments: chatGroup,
                    );
                  },
                ),
                WidgetLineRow(
                  '移除成员',
                  subtitle: '指定成员移出群聊',
                  onTap: () {
                    Get.toNamed(
                      GroupKickedPage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '扫码进群',
                  subtitle: '开启后允许他人通过扫码加入群聊',
                  widget: Switch(
                    value: chatGroup.privacyScan == 'Y',
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
                  '搜索群ID',
                  subtitle: '开启后允许他人通过搜索ID加入群聊',
                  widget: Switch(
                    value: chatGroup.privacyNo == 'Y',
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
                  '搜索群名称',
                  enable: ToolsStorage().config().groupSearch == 'Y',
                  subtitle: '开启后允许他人通过搜索群名称加入群聊',
                  widget: Switch(
                    value: chatGroup.privacyName == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editPrivacyName(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '全员禁言',
                  subtitle: '开启后只允许群主/管理员发言',
                  widget: Switch(
                    value: chatGroup.configSpeak == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigSpeak(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '成员禁言',
                  subtitle: '设置指定成员禁言',
                  onTap: () {
                    Get.toNamed(
                      GroupSpeakPage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '红包禁抢',
                  subtitle: '开启后仅白名单成员能领取红包，群主/管理员除外',
                  widget: Switch(
                    value: chatGroup.configReceive == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigReceive(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '禁抢白名单',
                  subtitle: '设置可以领取红包的成员，仅当[红包禁抢]开启生效',
                  onTap: () {
                    Get.toNamed(
                      GroupPacketWhitePage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '修改昵称',
                  subtitle: '开启后允许成员修改群内昵称',
                  widget: Switch(
                    value: chatGroup.configNickname == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigNickname(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '成员昵称',
                  subtitle: '设置成员在群聊中的昵称',
                  onTap: () {
                    Get.toNamed(
                      GroupNicknamePage.routeName,
                      arguments: chatGroup,
                    );
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
                WidgetLineRow(
                  '发送资源',
                  subtitle: '关闭后不允许成员发送图片、视频、文件等，管理员/群主除外',
                  widget: Switch(
                    value: chatGroup.configMedia == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigMedia(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '发送二维码',
                  subtitle: '关闭后不允许成员发送二维码图片，管理员/群主除外',
                  widget: Switch(
                    value: chatGroup.configScan == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigScan(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '红包开关',
                  subtitle: '关闭后不允许成员发送红包，管理员/群主除外',
                  widget: Switch(
                    value: chatGroup.configPacket == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigPacket(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '红包金额',
                  subtitle: '开启后显示红包具体金额',
                  widget: Switch(
                    value: chatGroup.configAmount == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigAmount(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '专属可见',
                  subtitle: '开启后专属红包仅专属人可见',
                  widget: Switch(
                    value: chatGroup.configAssign == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigAssign(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '群聊头衔',
                  subtitle: '开启后显示群主/管理员头衔',
                  widget: Switch(
                    value: chatGroup.configTitle == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigTitle(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '允许邀请',
                  subtitle: '开启后成员无法邀请好友进群，管理员/群主除外',
                  widget: Switch(
                    value: chatGroup.configInvite == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigInvite(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  '成员保护',
                  subtitle: '开启后成员相互无法添加好友，管理员/群主除外',
                  widget: Switch(
                    value: chatGroup.configMember == 'Y',
                    onChanged: (bool value) {
                      if (ToolsSubmit.call(dismissOnTap: true)) {
                        // 提交
                        controller.editConfigMember(value ? 'Y' : 'N');
                      }
                    },
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetCommon.border(
                  enable: MemberType.master == chatGroup.memberType,
                ),
                WidgetLineCenter(
                  enable: MemberType.master == chatGroup.memberType,
                  '解散群聊',
                  color: Colors.red,
                  onTap: () {
                    _dissolve(context);
                  },
                  divider: false,
                ),
                WidgetCommon.border(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 顶部头像
  _buildHeader(BuildContext context, String portrait) {
    return WidgetLineRow(
      '群头像',
      widget: WidgetCommon.showAvatar(
        portrait,
        size: 55,
      ),
      hight: 10,
      onTap: () {
        WidgetUpload.image(
          context,
          onTap: (value) {
            if (ToolsSubmit.call(dismissOnTap: true)) {
              // 提交
              controller.editPortrait(value);
            }
          },
        );
      },
    );
  }

  // 解散
  _dissolve(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            '重要提醒',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: const Text(
            '确认要解散当前群聊吗？',
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
                  controller.dissolve();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
