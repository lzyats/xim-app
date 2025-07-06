import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_message_card.dart';
import 'package:alpaca/pages/chat/chat_message_file.dart';
import 'package:alpaca/pages/chat/chat_message_image.dart';
import 'package:alpaca/pages/chat/chat_message_location.dart';
import 'package:alpaca/pages/chat/chat_message_other.dart';
import 'package:alpaca/pages/chat/chat_message_reply.dart';
import 'package:alpaca/pages/chat/chat_message_text.dart';
import 'package:alpaca/pages/chat/chat_message_video.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=消息=转发
class ChatMessageForward extends StatelessWidget {
  final Map<String, dynamic> content;
  const ChatMessageForward(
    this.content, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 消息内容
    String title = content['title'];
    return GestureDetector(
      onTap: () {
        Get.to(
          ChatMessageForwardPage(content),
          preventDuplicates: false,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Flexible(
              child: Text(
                '[聊天记录]',
                style: TextStyle(
                  color: Color.fromARGB(255, 123, 122, 122),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessageForwardPage extends StatelessWidget {
  // 路由地址
  static const String routeName = '/chat_message_forward';
  final Map<String, dynamic> content;
  const ChatMessageForwardPage(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    // 消息内容
    String title = content['title'];
    List<dynamic> dataList = content['content'];
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(dataList.length, (index) {
            return _buildChatItem(dataList[index]);
          }),
        ),
      ),
    );
  }

  // 渲染聊天
  _buildChatItem(Map<String, dynamic> data) {
    return GestureDetector(
      onDoubleTap: () {
        // 消息类型
        MsgType msgType = MsgType.init(data['msgType']);
        if (MsgType.text == msgType) {
          Get.to(
            const WidgetText(),
            arguments: data['content']['data'],
            transition: Transition.topLevel,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), // 设置圆角
          color: const Color.fromARGB(255, 243, 241, 241), // 设置背景颜色
        ),
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPortrait(data['source']),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNickname(data['source']),
                  _buildItem(data),
                  _buildTime(data['createTime']),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPortrait(Map<String, dynamic> source) {
    String portrait = source['portrait'];
    return WidgetCommon.showAvatar(portrait, size: 40);
  }

  _buildNickname(Map<String, dynamic> source) {
    String nickname = source['nickname'];
    return WidgetCommon.tips(
      nickname,
      textAlign: TextAlign.left,
    );
  }

  _buildItem(Map<String, dynamic> data) {
    // 消息类型
    MsgType msgType = MsgType.init(data['msgType']);
    // 消息内容
    Map<String, dynamic> content = data['content'];
    // 结果
    Widget result = Container();
    switch (msgType) {
      // 文本消息
      case MsgType.text:
        result = ChatMessageText(
          content,
          text: '${content['data']}',
        );
        break;
      // 图片消息
      case MsgType.image:
        result = ChatMessageImage(
          content,
        );
        break;
      // 视频消息
      case MsgType.video:
        result = ChatMessageVideo(content);
        break;
      // 文件消息
      case MsgType.file:
        result = ChatMessageFile(
          content,
          width: 220,
        );
        break;
      // 名片消息
      case MsgType.card:
        result = ChatMessageCard(content);
        break;
      // 位置消息
      case MsgType.location:
        result = ChatMessageLocation(
          content,
          width: 220,
        );
        break;
      // 转发消息
      case MsgType.forward:
        result = ChatMessageForward(content);
        break;
      // 其他消息
      default:
        result = const ChatMessageOther();
        break;
    }
    return result;
  }

  _buildTime(String createTime) {
    String label = formatDate(
      DateTime.fromMillisecondsSinceEpoch(int.parse(createTime)),
      [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss],
    );
    return WidgetCommon.tips(
      label,
      textAlign: TextAlign.right,
    );
  }
}
