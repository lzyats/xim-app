import 'package:alpaca/res/style.dart';
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
import 'package:flutter_html/flutter_html.dart';

// 消息页面
class MsgIndexPage extends GetView<MsgIndexController> {
  const MsgIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<MsgIndexController>(() => MsgIndexController());
    final bool initialShowDialog; // 控制是否初始显示弹窗
    final String richContent; // 富文本内容
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
              stops: [0.0, 1.0], // 颜色分布点
            ),
          ),
          child: AppBar(
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '消息',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetCommon.buildAction(),
            ],
          ),
        ),
      ),
      drawer: AppConfig.mini ? const UniIndexPage() : null,
      body: Column(
        children: [
          Obx(
            () => _buildNotice(context),
          ),
          Obx(() {
            return _handleNoticeDialog(context);
          }),
          Flexible(
            child: GetBuilder<MsgIndexController>(builder: (builder) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: false, // 禁用上拉加载
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

  /// 显示另一个富文本内容
  void _showAnotherDialog(BuildContext context) {
    _showRichTextDialog(context, content: controller.notice.value);
  }

  /// 通用富文本弹窗
  void _showRichTextDialog(
    BuildContext context, {
    required String content,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // 点击背景是否关闭弹窗
      barrierColor: Colors.black54, // 背景遮罩颜色
      barrierLabel: '关闭弹窗', // 必须添加！非空字符串（用于辅助功能）
      transitionDuration: const Duration(milliseconds: 300), // 动画时长
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9, // 弹窗宽度占屏幕90%
            // 替换原来的 maxWidth 和 maxHeight 为 constraints
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: MediaQuery.of(context).size.height * 0.55,
            ), // 最大高度限制
            margin: const EdgeInsets.symmetric(horizontal: 26),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 标题行（含关闭按钮）
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(TDIcons.sound, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          "系统公告",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context), // 关闭弹窗
                    ),
                  ],
                ),
                const Divider(height: 2),
                // 富文本内容区域（可滚动）
                Expanded(
                  child: SingleChildScrollView(
                    child: Html(data: content, style: PageStyle.html_qi),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      // 动画效果（缩放显示）
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  _buildNotice(context) {
    if (controller.notice.value.isEmpty || controller.notype.value == 1) {
      return Container();
    }
    String content = controller.notice.value;
    content = PageStyle.extractTextFromHtml(content);
    return TDNoticeBar(
      context: content,
      prefixIcon: TDIcons.sound,
      style: TDNoticeBarStyle(
        backgroundColor: Color(0xFF0463F7),
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
            SettingModel(SettingType.sys, label: 'notice', value: ""),
          );
        },
      ),
      marquee: true,
    );
  }

  // 分离出的处理公告弹窗的方法
  Widget _handleNoticeDialog(BuildContext context) {
    if (controller.notype.value > 0 && controller.notice.value.isNotEmpty) {
      // 延迟一帧执行，避免在构建阶段直接弹窗导致异常
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showRichTextDialog(
          context,
          content: controller.notice.value,
        );
      });
    }
    // 此组件不渲染任何UI，仅用于监听状态
    return SizedBox.shrink();
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
              left: 50,
              top: 2,
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
