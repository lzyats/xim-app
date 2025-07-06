import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_history_image.dart';
import 'package:alpaca/pages/chat/chat_history.dart';
import 'package:alpaca/pages/chat/chat_history_text.dart';
import 'package:alpaca/pages/chat/chat_history_video.dart';
import 'package:alpaca/pages/msg/msg_chat_page.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 消息路由
List<GetPage> getMsgPages = [
  // 聊天页面
  getPage(
    name: MsgChatPage.routeName,
    page: () => const MsgChatPage(),
  ),
  // 消息转发
  getPage(
    name: MsgForwardPage.routeName,
    page: () => const MsgForwardPage(),
  ),
  // 聊天记录
  getPage(
    name: ChatHistory.routeName,
    page: () => const ChatHistory(),
  ),
  // 聊天记录-文字
  getPage(
    name: ChatHistoryText.routeName,
    page: () => const ChatHistoryText(),
  ),
  // 聊天记录-图片
  getPage(
    name: ChatHistoryImage.routeName,
    page: () => const ChatHistoryImage(),
  ),
  // 聊天记录-视频
  getPage(
    name: ChatHistoryVideo.routeName,
    page: () => const ChatHistoryVideo(),
  ),
];
