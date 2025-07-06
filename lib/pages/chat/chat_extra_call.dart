import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_bottom.dart';

// 聊天=扩展=通话
class ChatExtraCall extends StatelessWidget {
  const ChatExtraCall({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '通话',
      icon: Icons.video_camera_back,
      onTap: () async {
        // 权限
        bool result = await ToolsPerms.camera();
        if (!result) {
          return;
        }
        // 权限
        result = await ToolsPerms.microphone();
        if (!result) {
          return;
        }
        WidgetBottom([
          BottomModel(
            '视频通话',
            onTap: () async {
              // 关闭
              Get.back();
              // 事件
              _even('video');
            },
          ),
          BottomModel(
            '语音通话',
            onTap: () async {
              // 关闭
              Get.back();
              // 事件
              _even('voice');
            },
          ),
        ]);
      },
    ).buildItem();
  }

  Future<void> _even(String callType) async {
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      MsgType.call,
      {
        "callStatus": CallStatus.none.value,
        "callType": callType,
        "callTime": '0',
      },
      handle: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
    // 转圈
    ToolsSubmit.call();
  }
}
