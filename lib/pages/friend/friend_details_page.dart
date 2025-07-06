import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/friend/friend_apply_page.dart';
import 'package:alpaca/pages/friend/friend_details_controller.dart';
import 'package:alpaca/pages/friend/friend_inform_page.dart';
import 'package:alpaca/pages/friend/friend_remark_page.dart';
import 'package:alpaca/pages/friend/friend_setting_page.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 好友详情
class FriendDetailsPage extends GetView<FriendDetailsController> {
  // 路由地址
  static const String routeName = '/friend_details';
  const FriendDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendDetailsController());
    return GetBuilder<FriendDetailsController>(
      builder: (builder) {
        ChatFriend chatFriend = controller.refreshData;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('好友详情'),
            actions: [
              if (FriendType.friend == chatFriend.friendType)
                WidgetAction(
                  icon: const Icon(Icons.more_horiz),
                  onTap: () {
                    Get.toNamed(
                      FriendSettingPage.routeName,
                      arguments: chatFriend,
                    );
                  },
                ),
            ],
          ),
          body: Column(
            children: [
              _buildHeader(chatFriend),
              WidgetCommon.border(
                enable: FriendType.other == chatFriend.friendType,
              ),
              WidgetLineCenter(
                '加为好友',
                enable: FriendType.other == chatFriend.friendType,
                divider: false,
                color: AppTheme.color,
                onTap: () {
                  Get.toNamed(
                    FriendApplyPage.routeName,
                    arguments: {
                      'source': chatFriend.friendSource,
                      'userId': controller.userId,
                    },
                  );
                },
              ),
              WidgetCommon.border(
                enable: FriendType.friend == chatFriend.friendType,
              ),
              WidgetLineCenter(
                '举报用户',
                enable: FriendType.friend == chatFriend.friendType,
                divider: false,
                color: Colors.red,
                onTap: () {
                  Get.toNamed(
                    FriendInformPage.routeName,
                    arguments: controller.userId,
                  );
                },
              ),
              WidgetCommon.border(
                enable: FriendType.friend == chatFriend.friendType,
              ),
              WidgetLineCenter(
                '好友备注',
                enable: FriendType.friend == chatFriend.friendType,
                divider: false,
                onTap: () {
                  Get.toNamed(FriendRemarkPage.routeName);
                },
              ),
              WidgetCommon.border(
                enable: FriendType.other != chatFriend.friendType,
              ),
              WidgetLineCenter(
                '发起聊天',
                divider: false,
                enable: FriendType.other != chatFriend.friendType,
                onTap: () {
                  ToolsRoute().chatPage(
                    chatId: chatFriend.userId,
                    nickname: chatFriend.nickname,
                    portrait: chatFriend.portrait,
                    remark: chatFriend.remark,
                    chatTalk: ChatTalk.friend,
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
              WidgetCommon.border(),
            ],
          ),
        );
      },
    );
  }

  // 顶部头像
  _buildHeader(ChatFriend chatFriend) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: WidgetCommon.showAvatar(
                chatFriend.portrait,
                size: 65,
              ),
              onTap: () {
                Get.to(
                  ShowImage(chatFriend.portrait),
                  transition: Transition.topLevel,
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatFriend.remark.isNotEmpty
                      ? chatFriend.remark
                      : chatFriend.nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                ),
                Text('ID：${chatFriend.userNo}'),
                Text(
                  '昵称：${chatFriend.nickname}',
                  overflow: TextOverflow.visible,
                ),
                Text(
                  '签名：${chatFriend.intro}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 清空历史
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
                    primary: controller.refreshData.userId,
                    value: controller.refreshData.groupId,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
