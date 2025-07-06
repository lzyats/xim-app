import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/chat/chat_message_trade.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

// 聊天=消息=转账
class ChatMessageTransfer extends StatelessWidget {
  final ChatHis chatHis;
  const ChatMessageTransfer(this.chatHis, {super.key});

  @override
  Widget build(BuildContext context) {
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    String label = chatHis.msgType.label;
    String remark = content['remark'];
    if (remark.isEmpty) {
      if (chatHis.self) {
        remark = '你发起了一笔转账';
      } else {
        remark = '对方发起了一笔转账';
      }
    }
    double amount = double.parse(content['data'].toString());
    return GestureDetector(
      onTap: () {
        Get.to(ChatMessageTrade(chatHis.msgId));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: 220,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                color: Colors.orange.shade400,
                child: Row(
                  children: [
                    const Icon(
                      AppFonts.e686,
                      color: Colors.white,
                      size: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            remark,
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                letterSpacing: 1),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '¥ ${amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 143, 141, 141),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
