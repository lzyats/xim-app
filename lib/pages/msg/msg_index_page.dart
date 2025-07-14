import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/uni/uni_index_page.dart';
import 'package:alpaca/pages/msg/msg_index_controller.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 消息页面
class MsgIndexPage extends GetView<MsgIndexController> {
  const MsgIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MsgIndexController>(() => MsgIndexController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: AppConfig.mini
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : Container(),
        title: Obx(() => Text(AppConfig.onlineMark.value)),
        actions: [
          WidgetCommon.buildAction(),
        ],
      ),
      drawer: AppConfig.mini ? const UniIndexPage() : null,
      body: Column(
        children: [
          Obx(
            () => _buildNotice(),
          ),
          Flexible(
            child: GetBuilder<MsgIndexController>(builder: (builder) {
              return SmartRefresher(
                enablePullDown: true,
                controller: controller.refreshController,
                onRefresh: () {
                  print('onRefresh method called');
                  controller.onRefresh();
                },
                // 更新后的 WaterDropHeader 参数配置
                header: WaterDropHeader(
                  key: null, // 可根据需要设置 key
                  refresh: Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: Text(
                      '正在刷新...',
                      style: TextStyle(
                        color: AppTheme.color,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  complete: const SizedBox.shrink(), // 完成状态组件（此处为空）
                  completeDuration: const Duration(milliseconds: 600),
                  failed: const SizedBox.shrink(), // 失败状态组件（此处为空）
                  waterDropColor: AppTheme.color,
                  idleIcon: Icon(
                    Icons.autorenew,
                    size: 15,
                    color: AppTheme.color,
                  ),
                ),
                // 移除不支持的 onRefreshCompleted 参数
                // 刷新完成逻辑移至控制器中处理
                child: _buildContent(),
              );
            }),
          ),
        ],
      ),
    );
  }

  _buildNotice() {
    if (controller.notice.value.isEmpty) {
      return Container();
    }
    return TDNoticeBar(
      context: controller.notice.value,
      prefixIcon: TDIcons.sound,
      style: TDNoticeBarStyle(
        backgroundColor: AppTheme.color,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        leftIconColor: Colors.white,
      ),
      right: GestureDetector(
        child: const Icon(
          TDIcons.close,
          color: Colors.white,
        ),
        onTap: () {
          EventSetting().handle(
            SettingModel(
              SettingType.sys,
              label: 'notice',
            ),
          );
        },
      ),
      marquee: true,
    );
  }

  _buildContent() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return SlidableAutoCloseBehavior(
      child: GroupedListView(
        elements: controller.refreshList,
        groupBy: (element) => element.top.toString(),
        groupSeparatorBuilder: (value) => Container(),
        order: GroupedListOrder.DESC,
        itemComparator: (item1, item2) =>
            item1.createTime.compareTo(item2.createTime),
        indexedItemBuilder: (context, element, index) => _slidable(element),
      ),
    );
  }

  // 滑动组件（保持不变）
  _slidable(ChatMsg chatMsg) {
    String chatId = chatMsg.chatId;
    int badger = ToolsBadger().get(chatId);
    int length = 2;
    if (badger > 0) {
      length++;
    }
    return Slidable(
      key: ValueKey(chatId),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25 * length + 0.1,
        children: [
          if (badger > 0)
            SlidableAction(
              onPressed: (context) {
                if (ToolsSubmit.call()) {
                  controller.doRead(chatId);
                }
              },
              backgroundColor: AppTheme.color,
              foregroundColor: Colors.white,
              label: '已读',
            ),
          SlidableAction(
            onPressed: (context) {
              if (ToolsSubmit.call()) {
                controller.setDelete(chatId);
              }
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: '不显示',
          ),
          SlidableAction(
            onPressed: (context) {
              if (ToolsSubmit.call()) {
                controller.setClear(chatId, chatMsg.chatTalk);
              }
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: '删除',
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25 * (chatMsg.self ? 1 : 2) + 0.1,
        children: [
          if (!chatMsg.self)
            SlidableAction(
              onPressed: (context) {
                if (ToolsSubmit.call()) {
                  controller.setDisturb(chatMsg);
                }
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              label: chatMsg.disturb ? '  取消\n免打扰' : '免打扰',
            ),
          SlidableAction(
            onPressed: (context) {
              controller.setTop(chatMsg);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            label: chatMsg.top ? '取消\n置顶' : '置顶',
          ),
        ],
      ),
      child: Column(
        children: [
          _buildItem(chatMsg, badger),
          WidgetCommon.divider(),
        ],
      ),
    );
  }

  // 消息项（保持不变）
  _buildItem(ChatMsg chatMsg, int badger) {
    return Container(
      color: chatMsg.top ? Colors.grey[100] : Colors.white,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: WidgetCommon.showAvatar(chatMsg.portrait),
            title: RichText(
              text: TextSpan(
                children: [
                  if (ChatTalk.group == chatMsg.chatTalk)
                    const TextSpan(
                      text: '[群] ',
                      style: TextStyle(color: Colors.red),
                    ),
                  if (ChatTalk.robot == chatMsg.chatTalk)
                    const TextSpan(
                      text: '[官] ',
                      style: TextStyle(color: Colors.red),
                    ),
                  TextSpan(
                    text: chatMsg.nickname,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: _formatContent(chatMsg),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                WidgetCommon.timeFormat(
                  chatMsg.createTime,
                  chatMsg.msgId.isNotEmpty,
                ),
                if (chatMsg.disturb)
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(
                      AppFonts.ec83,
                      size: 18,
                      color: Color(0xFFa9a9a9),
                    ),
                  ),
              ],
            ),
            onTap: () {
              ToolsRoute().chatPage(
                chatId: chatMsg.chatId,
                nickname: chatMsg.nickname,
                portrait: chatMsg.portrait,
                chatTalk: chatMsg.chatTalk,
              );
            },
          ),
          if (badger > 0)
            Positioned(
              left: 54,
              top: 0,
              child: TDBadge(
                TDBadgeType.message,
                count: badger > 99 ? '99+' : badger.toString(),
                size: TDBadgeSize.large,
              ),
            ),
        ],
      ),
    );
  }

  // 内容格式化（保持不变）
  _formatContent(ChatMsg chatMsg) {
    String content;
    MsgType msgType = chatMsg.msgType;
    if (MsgType.at == msgType) {
      content = chatMsg.content['data'];
      return ToolsRegex.parsedAt(content, controller.userId);
    }
    if (ToolsStorage().draft(chatMsg.chatId, read: true).isNotEmpty ||
        ToolsStorage().reply(chatMsg.chatId, read: true).isNotEmpty) {
      msgType = MsgType.draft;
    }
    switch (msgType) {
      case MsgType.text:
      case MsgType.tips:
      case MsgType.box:
      case MsgType.reply:
        content = chatMsg.content['data'];
        break;
      case MsgType.packet:
      case MsgType.groupLuck:
      case MsgType.groupPacket:
      case MsgType.groupAssign:
        content = '[红包消息]';
        break;
      case MsgType.transfer:
      case MsgType.groupTransfer:
        content = '[转账消息]';
        break;
      default:
        content = msgType.label;
        break;
    }
    return Text(
      content,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        color: msgType.isRed ? Colors.red : const Color(0xFFa9a9a9),
      ),
      maxLines: 1,
    );
  }
}
