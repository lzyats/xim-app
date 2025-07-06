import 'dart:async';

import 'package:flutter/material.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

import 'package:just_audio/just_audio.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';

// 聊天=消息=声音
class ChatMessageVoice extends StatefulWidget {
  final ChatHis chatHis;
  final AudioPlayer audioPlayer;
  const ChatMessageVoice(this.chatHis, this.audioPlayer, {super.key});

  @override
  createState() => _ChatMessageVoiceState();
}

class _ChatMessageVoiceState extends State<ChatMessageVoice> {
  // 声音状态
  bool voiceStatus = false;

  late StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      // 停止播放
      _stopPlayer();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _subscription?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 历史消息
    ChatHis chatHis = widget.chatHis;
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    int second = content['second'];
    String data = content['data'];
    String msgId = chatHis.msgId;
    String voiceText = content['voiceText'] ?? '';
    bool self = chatHis.self;
    return Column(
      crossAxisAlignment:
          self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment:
              self ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            _buildLabel(content, msgId, self && chatHis.status == 'Y'),
            InkWell(
              onTap: () {
                _startPlayer(data, second);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 80,
                  height: 40,
                  color: self ? const Color(0xFF9EEA6A) : Colors.yellow,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$second''"),
                      const SizedBox(
                        width: 4,
                      ),
                      voiceStatus
                          ? WidgetImage(
                              AppImage.voice,
                              ImageType.asset,
                              width: 40,
                              height: 24,
                              fit: BoxFit.cover,
                              color: Colors.white,
                            )
                          : const Icon(
                              AppFonts.eae0,
                              size: 24,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            _buildLabel(content, msgId, !self),
          ],
        ),
        _buildText(voiceText, self),
      ],
    );
  }

  // 转文字
  _buildText(String voiceText, bool self) {
    if (voiceText.isEmpty) {
      return Container();
    }
    return WidgetCommon.tips(
      voiceText,
      textAlign: self ? TextAlign.right : TextAlign.left,
    );
  }

  // 转文字
  _buildLabel(Map<String, dynamic> content, String msgId, bool show) {
    if (!show) {
      return Container();
    }
    return InkWell(
      // 去掉水波纹
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (ToolsSubmit.call()) {
          RequestCommon.audio2Text(msgId).then((voiceText) {
            content['voiceText'] = voiceText;
            setState(() {});
            // 取消
            ToolsSubmit.cancel();
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: Color.fromARGB(255, 246, 242, 242),
        ),
        child: const Text(
          "转文字",
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  // 开始播放
  Future<void> _startPlayer(String data, int second) async {
    // 停止播放
    await _stopPlayer();
    // 声音消息
    AudioSource audioSource = AudioSource.uri(Uri.parse(data));
    await widget.audioPlayer.setAudioSource(audioSource);
    // 开始播放
    widget.audioPlayer.play();
    setState(() {
      voiceStatus = true;
    });
    Future.delayed(Duration(seconds: second), () {
      setState(() {
        voiceStatus = false;
      });
    });
  }

  // 停止播放
  Future<void> _stopPlayer() async {
    await widget.audioPlayer.stop();
    setState(() {
      voiceStatus = false;
    });
  }
}
