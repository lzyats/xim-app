import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_message_forward.dart';
import 'package:alpaca/pages/chat/chat_message_image.dart';
import 'package:alpaca/pages/chat/chat_message_location.dart';
import 'package:alpaca/pages/chat/chat_message_other.dart';
import 'package:alpaca/pages/chat/chat_message_text.dart';
import 'package:alpaca/pages/chat/chat_message_video.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

// 聊天=消息=引用
class ChatMessageReply extends StatelessWidget {
  final ChatHis chatHis;
  const ChatMessageReply(this.chatHis, {super.key});

  @override
  Widget build(BuildContext context) {
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    // 消息内容
    String data = content['data'];
    // 类型
    MsgType msgType = MsgType.init(content['msgType']);
    // 引用
    Map<String, dynamic> reply = jsonDecode(content['content']);
    // 昵称
    String nickname = content['nickname'] ?? '好友';
    // 内容
    Widget result;
    switch (msgType) {
      // 文本消息
      case MsgType.text:
      case MsgType.reply:
        result = ChatMessageText(
          reply,
          text: '$nickname：${reply['data']}',
        );
        break;
      // 图片消息
      case MsgType.image:
        result = IntrinsicWidth(
          child: Row(
            children: [
              Expanded(
                child: _text('$nickname：'),
              ),
              ChatMessageImage(
                reply,
                size: 30.0,
              ),
            ],
          ),
        );
        break;
      // 视频消息
      case MsgType.video:
        result = IntrinsicWidth(
          child: Row(
            children: [
              Expanded(
                child: _text('$nickname：'),
              ),
              ChatMessageVideo(
                reply,
                size: 30.0,
              ),
            ],
          ),
        );
        break;
      // 文件消息
      case MsgType.file:
        result = _text('$nickname：${msgType.label} ${reply['title']}');
        break;
      // 名片消息
      case MsgType.card:
        result = GestureDetector(
          onTap: () {
            Get.toNamed(
              FriendDetailsPage.routeName,
              arguments: {
                "userId": reply['userId'],
                "source": FriendSource.card,
              },
            );
          },
          child: _text('$nickname：${msgType.label} ${reply['nickname']}'),
        );
        break;
      // 位置消息
      case MsgType.location:
        result = GestureDetector(
          onTap: () async {
            // 权限
            bool result = await ToolsPerms.location();
            if (!result) {
              return;
            }
            Get.to(const ChatMessageLocationItem(), arguments: reply);
          },
          child: _text('$nickname：${msgType.label} ${reply['title']}'),
        );
        break;
      // 转发消息
      case MsgType.forward:
        result = GestureDetector(
          onTap: () {
            Get.to(
              ChatMessageForwardPage(reply),
              preventDuplicates: false,
            );
          },
          child: _text('$nickname：${msgType.label} ${reply['title']}'),
        );
        break;
      // 其他消息
      default:
        result = const ChatMessageOther();
        break;
    }
    return Column(
      crossAxisAlignment:
          chatHis.self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: chatHis.self ? const Color(0xFF9EEA6A) : Colors.yellow,
              child: ToolsRegex.parsedText(data),
            ),
          ),
          onDoubleTap: () {
            Get.to(
              const WidgetText(),
              arguments: data,
              transition: Transition.topLevel,
            );
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 223, 223),
            borderRadius: BorderRadius.circular(7),
          ),
          child: result,
        ),
      ],
    );
  }

  _text(String data) {
    return Text(
      data,
      style: TextStyle(color: Colors.grey[800]),
      overflow: TextOverflow.ellipsis,
    );
  }
}

// 视频组件
class WidgetText extends StatelessWidget {
  const WidgetText({super.key});

  @override
  Widget build(BuildContext context) {
    String data = Get.arguments;
    // 选中文本
    var text = '';
    return GestureDetector(
      onTap: () {
        // 返回
        Get.back();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectionArea(
                child: GestureDetector(
                  onTap: () {
                    // 返回
                    Get.back();
                  },
                  child: Text(
                    data,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                onSelectionChanged: (SelectedContent? selectContent) {
                  text = selectContent?.plainText ?? '';
                },
                contextMenuBuilder: (context, selectableRegionState) {
                  final List<ContextMenuButtonItem> buttonItems = [
                    ContextMenuButtonItem(
                      label: '复制',
                      onPressed: () {
                        if (text.isNotEmpty) {
                          Clipboard.setData(ClipboardData(text: text));
                          EasyLoading.showToast('复制成功');
                        }
                      },
                    ),
                    ContextMenuButtonItem(
                      label: '全选',
                      onPressed: () {
                        selectableRegionState.selectAll(
                          SelectionChangedCause.toolbar,
                        );
                      },
                    ),
                    ContextMenuButtonItem(
                      label: '转发',
                      onPressed: () async {
                        if (text.isNotEmpty) {
                          // 转发
                          dynamic result = await Get.toNamed(
                            MsgForwardPage.routeName,
                            arguments: [
                              ForwardModel(MsgType.text, {'data': text.trim()}),
                            ],
                          );
                          if (result != null) {
                            Get.back();
                          }
                        }
                      },
                    ),
                  ];
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    buttonItems: buttonItems,
                    anchors: selectableRegionState.contextMenuAnchors,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
