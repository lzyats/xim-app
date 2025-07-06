import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:uuid/uuid.dart';

// 聊天=底部=语音
class ChatBottomVoice extends StatefulWidget {
  // 声音录制器
  final FlutterSoundRecord soundRecord;
  const ChatBottomVoice(this.soundRecord, {super.key});

  @override
  createState() => _ChatBottomVoiceState();
}

class _ChatBottomVoiceState extends State<ChatBottomVoice> {
  // 遮罩层
  OverlayEntry? _overlayEntry;
  late OverlayState _overlayState;
  // 类型
  VoiceType _voiceType = VoiceType.none;
  // 声音地址
  String? _path;
  // 声音时间
  int _second = 0;
  // 定时任务
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _overlayState = Overlay.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // 长按开始
      onLongPress: () async {
        // 权限
        bool result = await ToolsPerms.microphone();
        if (!result) {
          return;
        }
        // 更新状态
        setState(() {
          _voiceType = VoiceType.send;
        });
        // 显示遮罩
        await _showMask();
      },
      // 长按移动
      onLongPressMoveUpdate: (value) {
        // 更新状态
        setState(() {
          _voiceType =
              value.localPosition.dy > -50 ? VoiceType.send : VoiceType.cancel;
        });
        // 更新遮罩
        _updateMask();
      },
      // 长按结束
      onLongPressEnd: (value) async {
        // 隐藏遮罩
        await _hideMask();
        // 更新状态
        setState(() {
          _voiceType = VoiceType.none;
        });
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: const Center(
          child: Text('按住 说话'),
        ),
      ),
    );
  }

  // 开始录制
  Future<void> _startVoice() async {
    _timer?.cancel();
    _second = 0;
    await widget.soundRecord.start();
    await widget.soundRecord.isRecording();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _second++;
      // 设置了最大录音时长
      if (_second >= 60) {
        _stopVoice();
      }
    });
  }

  // 停止录制
  Future<void> _stopVoice() async {
    _timer?.cancel();
    _path = await widget.soundRecord.stop();
  }

  // 显示遮罩
  Future<void> _showMask() async {
    // 隐藏遮罩
    await _hideMask();
    // 开始录音
    await _startVoice();
    // 显示遮罩
    _overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return ChatVoiceMask(_voiceType);
    });
    _overlayState.insert(_overlayEntry!);
  }

  // 更新遮罩
  void _updateMask() {
    if (_overlayEntry == null) {
      return;
    }
    _overlayEntry?.markNeedsBuild();
  }

  // 隐藏遮罩
  Future<void> _hideMask() async {
    if (_overlayEntry == null) {
      return;
    }
    // 停止录音
    await _stopVoice();
    // 隐藏遮罩
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (VoiceType.send != _voiceType) {
      return;
    }
    if (_second < 1) {
      EasyLoading.showToast('说话时间太短了');
      return;
    }
    // 发送声音
    _sendVoice();
  }

  // 发送声音消息
  _sendVoice() {
    Map<String, dynamic> content = {
      'data': _path,
      'second': _second,
      'title': '${const Uuid().v8()}.aac',
    };
    // 组装消息
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      MsgType.voice,
      content,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}

// 扩展类型
enum VoiceType {
  none,
  send,
  cancel,
}

// 遮罩层
class ChatVoiceMask extends StatefulWidget {
  final VoiceType voiceType;
  const ChatVoiceMask(this.voiceType, {super.key});

  @override
  createState() => _ChatVoiceMaskState();
}

class _ChatVoiceMaskState extends State<ChatVoiceMask> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Material(
        // 颜色透明度
        color: Colors.black.withOpacity(0.5),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    height: 120,
                    width: 200,
                    decoration: BoxDecoration(
                      // 动态颜色
                      color: widget.voiceType == VoiceType.send
                          ? AppTheme.color
                          : Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: WidgetImage(
                        AppImage.voice,
                        ImageType.asset,
                        width: 120,
                        height: 54,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // 文字区域
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                widget.voiceType == VoiceType.send ? '松开 发送' : '松开 取消',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            WidgetCommon.customClipper(),
          ],
        ),
      ),
    );
  }
}
