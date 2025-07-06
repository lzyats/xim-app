import 'package:flutter/material.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=消息=tips
class ChatMessageTips extends StatelessWidget {
  final Map<String, dynamic> content;
  const ChatMessageTips(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WidgetCommon.tips(content['data']),
      ),
    );
  }
}
