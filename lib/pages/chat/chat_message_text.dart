import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/widgets/widget_text.dart';

// 聊天=消息=文本
class ChatMessageText extends StatelessWidget {
  final Map<String, dynamic> content;
  final bool self;
  final String text;
  const ChatMessageText(
    this.content, {
    super.key,
    this.self = false,
    this.text = '',
  });

  @override
  Widget build(BuildContext context) {
    // 消息内容
    String data = content['data'];
    return GestureDetector(
      onDoubleTap: () {
        Get.to(
          const WidgetText(),
          arguments: data,
          transition: Transition.topLevel,
        );
      },
      child: text.isNotEmpty
          ? Text(
              text,
              style: TextStyle(color: Colors.grey[800]),
              overflow: TextOverflow.ellipsis,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: self ? const Color(0xFF9EEA6A) : Colors.yellow,
                child: ToolsRegex.parsedText(data),
              ),
            ),
    );
  }
}
