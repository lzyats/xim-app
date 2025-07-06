import 'package:flutter/material.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

// 聊天=消息=通话
class ChatMessageCall extends StatefulWidget {
  final ChatHis chatHis;
  const ChatMessageCall(this.chatHis, {super.key});

  @override
  createState() => _ChatMessageCallState();
}

class _ChatMessageCallState extends State<ChatMessageCall> {
  @override
  Widget build(BuildContext context) {
    // 历史消息
    ChatHis chatHis = widget.chatHis;
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    String second = content['callTime'] ?? '0';
    CallStatus status = CallStatus.init(content['callStatus']);
    String callType = content['callType'];
    bool self = chatHis.self;
    return InkWell(
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
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(8),
          color: self ? const Color(0xFF9EEA6A) : Colors.yellow,
          child: Row(
            mainAxisAlignment:
                self ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              _buildButton(!self, self, callType),
              const SizedBox(
                width: 8,
              ),
              Text(
                _buildLabel(status, second),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              _buildButton(self, self, callType),
            ],
          ),
        ),
      ),
    );
  }

  _buildLabel(CallStatus status, String second) {
    Duration duration = Duration(seconds: int.parse(second));
    switch (status) {
      case CallStatus.none:
        return '未接听';
      case CallStatus.cancel:
        return '已取消';
      case CallStatus.reject:
        return '已拒接';
      case CallStatus.connect:
        return '通话中';
      case CallStatus.finish:
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        var twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
        var twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
        return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  _buildButton(bool show, bool self, String callType) {
    if (!show) {
      return Container();
    }
    return Transform.scale(
      scaleX: self ? -1 : 1,
      child: Icon(
        'video' == callType ? Icons.video_camera_back : Icons.call_end,
        size: 24,
      ),
    );
  }
}
