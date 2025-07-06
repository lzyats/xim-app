import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_bottom_check.dart';
import 'package:alpaca/pages/chat/chat_bottom_menu.dart';
import 'package:alpaca/pages/chat/chat_extra_group_packet.dart';
import 'package:alpaca/pages/chat/chat_message.dart';
import 'package:alpaca/pages/chat/chat_message_bubble.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/chat/chat_bottom.dart';
import 'package:alpaca/pages/group/group_details_page.dart';
import 'package:alpaca/pages/msg/msg_chat_controller.dart';
import 'package:alpaca/widgets/widget_checkbox.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 聊天页面
class MsgChatPage extends GetView<MsgChatController> {
  // 路由地址
  static const String routeName = '/msg_chat';
  const MsgChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MsgChatController());
    return GestureDetector(
      onTap: () {
        // 关闭小桌板
        EventSetting().handle(SettingModel(SettingType.close));
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 241, 241),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Obx(
            () => controller.chatTitle.value,
          ),
          actions: [
            WidgetAction(
              icon: const Icon(Icons.more_horiz),
              enable: ChatTalk.robot != ToolsStorage().chat().chatTalk,
              onTap: () {
                LocalChat localChat = ToolsStorage().chat();
                // 好友
                if (ChatTalk.friend == localChat.chatTalk) {
                  Get.toNamed(
                    FriendDetailsPage.routeName,
                    arguments: {
                      "userId": localChat.chatId,
                    },
                  );
                }
                // 群组
                else if (ChatTalk.group == localChat.chatTalk) {
                  Get.toNamed(
                    GroupDetailsPage.routeName,
                    arguments: localChat.chatId,
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Obx(() => _buildNotice()),
            Flexible(
              child: PagedListView<int, ChatHis>(
                pagingController: controller.pagingController,
                scrollController: controller.scrollController,
                shrinkWrap: true,
                reverse: true,
                builderDelegate: PagedChildBuilderDelegate<ChatHis>(
                  itemBuilder: (context, chatHis, index) {
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: controller.scrollController,
                      index: index,
                      child: Obx(
                        () => _buildChatItem(chatHis),
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(() {
          // 多选菜单
          if (controller.configCheckBox.isTrue) {
            return ChatBottomCheck(
              configCheckBox: controller.configCheckBox,
              checkboxList: controller.checkboxList,
            );
          }
          // 自定义菜单
          if ('[]' != controller.configMenu.value) {
            return ChatBottomMenu(
              menu: controller.configMenu,
            );
          }
          // 输入框
          if ('Y' == controller.configInput.value) {
            return IgnorePointer(
              ignoring: 'Y' == controller.configSpeak.value,
              child: ChatBottom(
                controller.scrollController,
                controller.textController,
                configSpeak: controller.configSpeak,
                configMedia: controller.configMedia,
                configPacket: controller.configPacket,
                configReply: controller.configReply,
              ),
            );
          }
          return const SizedBox(height: 0);
        }),
        floatingActionButton: _buildFloating(),
      ),
    );
  }

  _buildNotice() {
    if (controller.configNotice.value.isEmpty) {
      return Container();
    }
    return TDNoticeBar(
      context: controller.configNotice.value,
      prefixIcon: TDIcons.notification,
      marquee: true,
      style: TDNoticeBarStyle(
        backgroundColor: AppTheme.color,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        leftIconColor: Colors.white,
      ),
    );
  }

  // 渲染聊天
  _buildChatItem(ChatHis chatHis) {
    return GestureDetector(
      onTap: () {
        // 关闭小桌板
        EventSetting().handle(SettingModel(SettingType.close));
        // 验证复选框
        if (controller.configCheckBox.isFalse) {
          return;
        }
        if (controller.checkboxList.containsKey(chatHis.msgId)) {
          controller.checkboxList.remove(chatHis.msgId);
        } else if (controller.checkboxList.length > 9) {
          // 提醒
          EasyLoading.showToast('多选不能超过10条哦');
        } else {
          controller.checkboxList[chatHis.msgId] = chatHis;
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: IgnorePointer(
          ignoring: controller.configCheckBox.isTrue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCheckbox(chatHis),
              _buildPortrait(chatHis, !chatHis.self),
              Expanded(
                child: GestureDetector(
                  onLongPressStart: (LongPressStartDetails details) {
                    _buildDialog(details, chatHis);
                  },
                  child: Column(
                    crossAxisAlignment: chatHis.self
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      _buildNickname(chatHis),
                      _buildContent(chatHis),
                      _buildFail(chatHis),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildTime(chatHis),
                    ],
                  ),
                ),
              ),
              _buildPortrait(chatHis, chatHis.self),
            ],
          ),
        ),
      ),
    );
  }

  _buildPortrait(ChatHis chatHis, bool show) {
    switch (chatHis.msgType) {
      case MsgType.box:
      case MsgType.tips:
        return Container();
      default:
        break;
    }
    if (!show) {
      return const SizedBox(width: 60);
    }
    // 默认
    String portrait = chatHis.portrait;
    String title = '';
    String userId = chatHis.chatId;
    // 自己
    if (chatHis.self) {
      portrait = controller.localUser.portrait;
      userId = controller.localUser.userId;
    }
    // 群聊
    else if (ChatTalk.group == controller.localChat.chatTalk) {
      portrait = chatHis.source['portrait'];
      title = chatHis.source['title'] ?? '';
      userId = chatHis.source['userId'];
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          _buildTitle(title, chatHis.self),
          InkWell(
            onTap: () {
              // 自己/好友
              if (chatHis.self || ChatTalk.friend == chatHis.chatTalk) {
                Get.toNamed(
                  FriendDetailsPage.routeName,
                  arguments: {
                    "userId": userId,
                  },
                );
              }
              // 群组
              else if (ChatTalk.group == chatHis.chatTalk) {
                if ('Y' == controller.configDetails.value) {
                  Get.toNamed(
                    FriendDetailsPage.routeName,
                    arguments: {
                      "userId": userId,
                      "source": FriendSource.group,
                    },
                  );
                } else {
                  // 提醒
                  throw Exception('群聊开启了隐私保护');
                }
              }
            },
            onLongPress: () {
              // 自己
              if (chatHis.self) {
                return;
              }
              // 非群组
              if (ChatTalk.group != chatHis.chatTalk) {
                return;
              }
              String userId = chatHis.source['userId'];
              String nickname = chatHis.source['nickname'];
              // 拼接消息
              controller.textController.text += '@$nickname༺$userId༻';
            },
            onDoubleTap: () {
              // 自己
              if (chatHis.self) {
                return;
              }
              // 非群组
              if (ChatTalk.group != chatHis.chatTalk) {
                return;
              }
              // 红包
              if ('Y' != controller.configPacket.value) {
                return;
              }
              // 专属红包
              String userId = chatHis.source['userId'];
              String nickname = chatHis.source['nickname'];
              Get.to(const ChatExtraGroupPacketItem(), arguments: {
                "userId": userId,
                "nickname": nickname,
              });
            },
            child: WidgetCommon.showAvatar(portrait, size: 45),
          ),
        ],
      ),
    );
  }

  _buildCheckbox(ChatHis chatHis) {
    if (controller.configCheckBox.isFalse) {
      return Container();
    }
    return WidgetCheckbox(
      value: controller.checkboxList.containsKey(chatHis.msgId),
      onChanged: (bool value) {},
    );
  }

  // 头衔
  _buildTitle(String title, bool self) {
    String configTitle = controller.configTitle.value;
    if ('N' == configTitle) {
      return Container();
    }
    if (self) {
      return Container();
    }
    if (title.isEmpty) {
      return Container();
    }
    return Container(
      width: 50,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildNickname(ChatHis chatHis) {
    switch (chatHis.msgType) {
      case MsgType.box:
      case MsgType.tips:
        return Container();
      default:
        break;
    }
    if (chatHis.self) {
      return Container();
    }
    if (chatHis.chatTalk != ChatTalk.group) {
      return Container();
    }
    String nickname = chatHis.source['nickname'];
    String userId = chatHis.source['userId'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: WidgetCommon.tips(
        ToolsStorage().remark(
          userId,
          value: nickname,
          read: true,
        ),
        textAlign: chatHis.self ? TextAlign.right : TextAlign.left,
      ),
    );
  }

  _buildContent(ChatHis chatHis) {
    return ChatMessage(
      chatHis,
      controller.audioPlayer,
      controller.configAmount,
      controller.configReceive,
      controller.pagingController,
    );
  }

  _buildDialog(LongPressStartDetails details, ChatHis chatHis) {
    if (controller.keyboard.isVisible) {
      // 关闭小桌板
      EventSetting().handle(SettingModel(SettingType.close));
    } else {
      showGeneralDialog(
        context: AppConfig.navigatorKey.currentState!.context,
        barrierColor: Colors.black.withOpacity(0.0),
        barrierDismissible: true,
        barrierLabel: '',
        pageBuilder: (
          BuildContext buildContext,
          Animation animation,
          Animation secondaryAnimation,
        ) {
          return ChatMessageBubble(
            chatHis: chatHis,
            height: details.globalPosition.dy,
            configManager: controller.configManager,
            configCheckBox: controller.configCheckBox,
            configReply: controller.configReply,
          );
        },
      );
    }
  }

  _buildFail(ChatHis chatHis) {
    if (chatHis.self && chatHis.status == 'N') {
      return InkWell(
        child: const Icon(
          Icons.error,
          color: Colors.red,
        ),
        onTap: () {
          // 重新发送
          EventChatModel model = EventChatModel(
            ToolsStorage().chat(),
            chatHis.msgType,
            chatHis.content,
            handle: false,
          );
          // 发布消息
          EventMessage().listenSend.add(model);
          // 删除消息
          EventSetting().handle(
            SettingModel(
              SettingType.remove,
              primary: chatHis.chatId,
              dataList: [chatHis.msgId, chatHis.syncId],
            ),
          );
        },
      );
    }
    return Container();
  }

  _buildTime(ChatHis chatHis) {
    TextAlign textAlign = TextAlign.left;
    if (chatHis.self) {
      textAlign = TextAlign.right;
    }
    switch (chatHis.msgType) {
      case MsgType.tips:
      case MsgType.box:
        textAlign = TextAlign.center;
        break;
      default:
        break;
    }
    String label = formatDate(
      chatHis.createTime,
      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss],
    );
    return WidgetCommon.tips(
      label,
      textAlign: textAlign,
    );
  }

  _buildFloating() {
    return Obx(() {
      if (controller.atList.isEmpty) {
        return Container();
      }
      return TDFab(
        theme: TDFabTheme.primary,
        text: '+${controller.atList.length}',
        size: TDFabSize.medium,
        icon: const Icon(
          AppFonts.e8de,
          color: Colors.white,
        ),
        onClick: () {
          controller.doFloating();
        },
      );
    });
  }
}
