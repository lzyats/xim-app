import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/pages/mine/mine_collect_page.dart';
import 'package:alpaca/request/request_collect.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 聊天=扩展=收藏
class ChatExtraCollect extends StatelessWidget {
  const ChatExtraCollect({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '收藏',
      icon: AppFonts.e60d,
      onTap: () {
        Get.to(const ChatExtraCollectItem());
      },
    ).buildItem();
  }
}

class ChatExtraCollectItem extends StatelessWidget {
  const ChatExtraCollectItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('选择收藏'),
      ),
      body: MineCollectWidget(
        onTap: (CollectModel value) {
          showCupertinoDialog(
            context: context,
            builder: (builder) {
              return CupertinoAlertDialog(
                title: const Text('确认发送？'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('取消'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('发送'),
                    onPressed: () {
                      Get.back();
                      // 消息类型
                      MsgType msgType = value.msgType;
                      // 组装消息
                      Map<String, dynamic> content = value.content;
                      // 组装对象
                      EventChatModel model = EventChatModel(
                        ToolsStorage().chat(),
                        msgType,
                        content,
                        handle: false,
                      );
                      // 发布消息
                      EventMessage().listenSend.add(model);
                      // 关闭页面
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
