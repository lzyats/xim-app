import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

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
  // 播放进度
  Duration? _position;
  late StreamSubscription? _subscription;
  late StreamSubscription? _positionSubscription;

  @override
  void initState() {
    super.initState();
    // 监听关闭事件
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      // 停止播放
      _stopPlayer();
    });

    // 监听播放进度
    _positionSubscription =
        widget.audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _positionSubscription?.cancel();
    super.dispose();
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

  // 转文字标签
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
    try {
      print(data);
      // 停止当前播放
      await _stopPlayer();

      // 处理iOS平台的音频路径
      String audioPath = data;
      if (Platform.isIOS) {
        // 如果是本地文件，确保路径正确
        if (data.startsWith('file://')) {
          audioPath = data.replaceFirst('file://', '');
        }

        // 检查文件是否存在
        final file = File(audioPath);
        if (!await file.exists()) {
          throw Exception("音频文件不存在: $audioPath");
        }
      }

      // 创建音频源
      AudioSource audioSource;
      if (data.startsWith('http')) {
        // 网络音频
        audioSource = AudioSource.uri(
          Uri.parse(data),
          headers: {'Content-Type': 'audio/m4a'}, // 假设是MP3格式
        );
      } else {
        // 本地音频，使用适当的路径格式
        audioSource = AudioSource.file(audioPath);
      }

      // 设置音频源并播放
      await widget.audioPlayer.setAudioSource(audioSource);
      await widget.audioPlayer.play();

      setState(() {
        voiceStatus = true;
      });

      // 监听播放完成事件（更可靠的方式）
      widget.audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            voiceStatus = false;
          });
        }
      });
    } catch (e) {
      // 捕获并打印错误信息
      debugPrint("音频播放错误: $e");
      // 显示错误提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("播放失败: ${e.toString()}")),
      );
      setState(() {
        voiceStatus = false;
      });
    }
  }

  // 停止播放
  Future<void> _stopPlayer() async {
    try {
      await widget.audioPlayer.stop();
      await widget.audioPlayer.seek(Duration.zero);
    } catch (e) {
      debugPrint("停止播放错误: $e");
    } finally {
      setState(() {
        voiceStatus = false;
      });
    }
  }
}
