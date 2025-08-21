import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
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

//拔打语音
import 'package:alpaca/pages/chat/chat_extra_call.dart';

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
                  '好友详情',
                  style: TextStyle(color: Colors.black),
                ),
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
            ),
          ),
          body: Column(
            children: [
              _buildHeader(chatFriend),
              WidgetLineRow(
                '昵称',
                value: chatFriend.nickname,
                divider: false,
              ),
              WidgetLineRow(
                '签名',
                value: chatFriend.intro,
                divider: false,
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
              WidgetLineRow(
                '好友备注',
                enable: FriendType.friend == chatFriend.friendType,
                divider: false,
                onTap: () {
                  Get.toNamed(FriendRemarkPage.routeName);
                },
              ),
              WidgetLineRow(
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
                '举报用户',
                enable: FriendType.friend == chatFriend.friendType,
                divider: false,
                color: Colors.amber,
                onTap: () {
                  Get.toNamed(
                    FriendInformPage.routeName,
                    arguments: controller.userId,
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
              // 仅当是好友时显示图形按钮区域
              if (FriendType.friend == chatFriend.friendType)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // 发起聊天按钮
                      GestureDetector(
                        onTap: () {
                          ToolsRoute().chatPage(
                            chatId: chatFriend.userId,
                            nickname: chatFriend.nickname,
                            portrait: chatFriend.portrait,
                            remark: chatFriend.remark,
                            chatTalk: ChatTalk.friend,
                          );
                        },
                        child: Column(
                          children: [
                            WidgetImage(
                              AppImage.hyfxx,
                              ImageType.asset,
                              width: 64,
                              height: 64,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              '发起聊天',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),

                      // 拨打语音按钮
                      GestureDetector(
                        onTap: () {
                          ToolsStorage().chat(
                              value: LocalChat(
                            chatId: chatFriend.userId,
                            nickname: chatFriend.nickname,
                            portrait: chatFriend.portrait,
                            title: chatFriend.nickname,
                            chatTalk: ChatTalk.friend,
                          ));
                          _even('voice');
                        },
                        child: Column(
                          children: [
                            WidgetImage(
                              AppImage.hxfyy,
                              ImageType.asset,
                              width: 64,
                              height: 64,
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              '拨打语音',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 顶部头像
  // 顶部头像及信息区域
  _buildHeader(ChatFriend chatFriend) {
    return Column(
      children: [
        // 原有头部信息
        Padding(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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

  Future<void> _even(String callType) async {
    //先将接收人信息存进去

    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      MsgType.call,
      {
        "callStatus": CallStatus.none.value,
        "callType": callType,
        "callTime": '0',
      },
      handle: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
    // 转圈
    ToolsSubmit.call();
  }
}
