import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alpaca/pages/chat/chat_message_at.dart';
import 'package:alpaca/pages/chat/chat_message_box.dart';
import 'package:alpaca/pages/chat/chat_message_call.dart';
import 'package:alpaca/pages/chat/chat_message_card.dart';
import 'package:alpaca/pages/chat/chat_message_file.dart';
import 'package:alpaca/pages/chat/chat_message_forward.dart';
import 'package:alpaca/pages/chat/chat_message_image.dart';
import 'package:alpaca/pages/chat/chat_message_location.dart';
import 'package:alpaca/pages/chat/chat_message_other.dart';
import 'package:alpaca/pages/chat/chat_message_packet.dart';
import 'package:alpaca/pages/chat/chat_message_reply.dart';
import 'package:alpaca/pages/chat/chat_message_text.dart';
import 'package:alpaca/pages/chat/chat_message_tips.dart';
import 'package:alpaca/pages/chat/chat_message_transfer.dart';
import 'package:alpaca/pages/chat/chat_message_video.dart';
import 'package:alpaca/pages/chat/chat_message_voice.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

// 聊天=消息
class ChatMessage extends StatefulWidget {
  final ChatHis chatHis;
  final AudioPlayer audioPlayer;
  final RxString configAmount;
  final RxString configReceive;
  final PagingController<int, ChatHis> pagingController;

  const ChatMessage(
    this.chatHis,
    this.audioPlayer,
    this.configAmount,
    this.configReceive,
    this.pagingController, {
    super.key,
  });

  @override
  createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  @override
  Widget build(BuildContext context) {
    // 历史消息
    ChatHis chatHis = widget.chatHis;
    // 消息类型
    MsgType msgType = chatHis.msgType;
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    // 消息状态
    String status = chatHis.status;
    // 结果
    Widget result;
    switch (msgType) {
      // 提示消息
      case MsgType.tips:
        result = ChatMessageTips(content);
        break;
      // 文本消息
      case MsgType.text:
        result = ChatMessageText(content, self: chatHis.self);
        break;
      // 引用消息
      case MsgType.reply:
        result = ChatMessageReply(chatHis);
        break;
      // at消息
      case MsgType.at:
        result = ChatMessageAt(chatHis);
        break;
      // 图片消息
      case MsgType.image:
        List<ChatHis> messageList = widget.pagingController.itemList ?? [];
        result = ChatMessageImage(
          chatHis.content,
          status: chatHis.status,
          msgId: chatHis.msgId,
          messageList: messageList,
        );
        break;
      // 视频消息
      case MsgType.video:
        result = ChatMessageVideo(
          content,
          status: status,
        );
        break;
      // 文件消息
      case MsgType.file:
        result = ChatMessageFile(content, status: status);
        break;
      // 声音消息
      case MsgType.voice:
        result = ChatMessageVoice(chatHis, widget.audioPlayer);
        break;
      // 名片消息
      case MsgType.card:
        result = ChatMessageCard(content);
        break;
      // 位置消息
      case MsgType.location:
        result = ChatMessageLocation(content);
        break;
      // 红包消息
      case MsgType.packet:
      case MsgType.groupPacket:
      case MsgType.groupLuck:
      case MsgType.groupAssign:
        result = ChatMessagePacket(
          chatHis,
          widget.configAmount,
          widget.configReceive,
        );
        break;
      // 转账消息
      case MsgType.transfer:
      case MsgType.groupTransfer:
        result = ChatMessageTransfer(chatHis);
        break;
      // 卡片消息
      case MsgType.box:
        result = ChatMessageBox(chatHis);
        break;
      // 转发消息
      case MsgType.forward:
        result = ChatMessageForward(content);
        break;
      // 语音视频
      case MsgType.call:
        result = ChatMessageCall(chatHis);
        break;
      // 其他消息
      default:
        result = const ChatMessageOther();
        break;
    }
    return result;
  }
}
