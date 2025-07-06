import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_text.dart';

// 聊天=消息=at
class ChatMessageAt extends StatelessWidget {
  final ChatHis chatHis;
  const ChatMessageAt(this.chatHis, {super.key});

  @override
  Widget build(BuildContext context) {
    // 消息内容
    String data = chatHis.content['data'];
    return GestureDetector(
      onDoubleTap: () {
        Get.to(
          const WidgetText(),
          arguments: data.replaceAll(RegExp(r'༺\d{1,19}༻'), ' '),
          transition: Transition.topLevel,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: chatHis.self ? const Color(0xFF9EEA6A) : Colors.yellow,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ToolsRegex.parsedText(data),
      ),
    );
  }
}
