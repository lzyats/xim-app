import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_bottom_emoji.dart';
import 'package:alpaca/pages/chat/chat_bottom_voice.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/pages/chat/chat_bottom_input.dart';
import 'package:alpaca/pages/group/group_at_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

// 聊天=底部
class ChatBottom extends StatefulWidget {
  final AutoScrollController scrollController;
  final TextEditingController textController;
  final RxString configSpeak;
  final RxString configMedia;
  final RxString configPacket;
  final RxMap<String, dynamic> configReply;
  const ChatBottom(
    this.scrollController,
    this.textController, {
    super.key,
    required this.configSpeak,
    required this.configMedia,
    required this.configPacket,
    required this.configReply,
  });

  @override
  createState() => _ChatBottomState();
}

class _ChatBottomState extends State<ChatBottom> {
  // 键盘
  final KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  // 键盘类型
  _InputType _inputType = _InputType.input;
  // 扩展类型
  _ExtraType _extraType = _ExtraType.none;
  // 文本滚动
  final ScrollController _scrollController = ScrollController();
  // 文本焦点
  final FocusNode _focusNode = FocusNode();
  // 声音录制器
  final FlutterSoundRecord _soundRecord = FlutterSoundRecord();
  // 键盘高度
  double _keyboard = 0;
  // 当前对象
  LocalChat localChat = ToolsStorage().chat();
  // 发布订阅
  StreamSubscription? _subscription;
  // 输入框暂存
  String stackText = '';

  @override
  void initState() {
    super.initState();
    // 输入框文字
    widget.textController.addListener(() {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
      _scrollToIndex();
      _onChangeInput();
      setState(() {});
    });
    // 键盘变化
    _keyboardVisibilityController.onChange.listen((bool visible) {
      if (mounted) {
        if (visible) {
          _extraType = _ExtraType.input;
          _scrollToIndex();
        } else if (_extraType == _ExtraType.input) {
          _extraType = _ExtraType.none;
        }
        setState(() {});
      }
    });
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      // 收起小桌板
      FocusManager.instance.primaryFocus?.unfocus();
      if (mounted) {
        setState(() {
          _extraType = _ExtraType.none;
        });
      }
    });
  }

  // 滚动到开始
  _scrollToIndex() {
    widget.scrollController.jumpTo(0);
  }

  // 改变输入框
  _onChangeInput() async {
    // 过滤
    if (ChatTalk.group != localChat.chatTalk) {
      return;
    }
    String text = widget.textController.text;
    // 过滤
    if (text == stackText) {
      return;
    }
    // 减法
    if (stackText.length > text.length) {
      // 赋值
      stackText = text;
      return;
    }
    // 赋值
    stackText = text;
    // 判断后缀
    if (!stackText.endsWith('@')) {
      return;
    }
    // 拉起成员
    dynamic result = await Get.toNamed(GroupAtPage.routeName);
    if (result == null) {
      return;
    }
    widget.textController.text = text + result;
  }

  @override
  void dispose() {
    if (mounted) {
      _focusNode.dispose();
      _scrollController.dispose();
      _soundRecord.dispose();
      _subscription?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 键盘高度
    _keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      margin: EdgeInsets.only(bottom: Platform.isIOS ? 10 : 0),
      padding: const EdgeInsets.symmetric(vertical: 6),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 238, 238),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色
            blurRadius: 1, // 模糊半径
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildVoiceButton(),
              Expanded(
                child: 'Y' == widget.configSpeak.value
                    ? _buildInputForbid()
                    : _buildInputButton(),
              ),
              _buildEmojiButton(),
              _buildExtraButton(),
            ],
          ),
          if (_extraType != _ExtraType.none)
            Container(
              padding: const EdgeInsets.only(top: 6),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: _extraType != _ExtraType.input ? 282 : _keyboard,
              width: double.infinity,
              child: _extraType == _ExtraType.emoji
                  ? ChatBottomEmoji(widget.textController)
                  : _extraType == _ExtraType.extra
                      ? ChatExtra(
                          configMedia: widget.configMedia,
                          configPacket: widget.configPacket,
                        )
                      : Container(),
            ),
        ],
      ),
    );
  }

  // 声音按钮
  _buildVoiceButton() {
    return GestureDetector(
      onTap: () {
        if (_inputType == _InputType.voice) {
          _inputType = _InputType.input;
          _focusNode.requestFocus();
        } else {
          _inputType = _InputType.voice;
          _extraType = _ExtraType.none;
        }
        setState(() {});
      },
      child: _buildIcon(
        _inputType == _InputType.voice ? AppFonts.e618 : AppFonts.e664,
        left: true,
      ),
    );
  }

  // 输入框按钮
  _buildInputButton() {
    if (_inputType == _InputType.voice) {
      return ChatBottomVoice(_soundRecord);
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
          ),
          child: ChatBottomInput(
            focusNode: _focusNode,
            textController: widget.textController,
            scrollController: _scrollController,
          ),
        ),
        Obx(() {
          if (widget.configReply.isEmpty) {
            return Container();
          }
          // 类型
          MsgType msgType = MsgType.init(widget.configReply['msgType']);
          // 昵称
          String nickname = widget.configReply['nickname'] ?? '好友';
          // 内容
          String content;
          switch (msgType) {
            case MsgType.text:
            case MsgType.reply:
              content = jsonDecode(widget.configReply['content'])['data'];
              break;
            default:
              content = msgType.label;
              break;
          }
          return GestureDetector(
            onTap: () {
              widget.configReply.value = {};
            },
            child: Container(
              height: 35,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 223, 223),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '$nickname：$content',
                      style: TextStyle(color: Colors.grey[800]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.grey[100],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  // 输入框按钮
  _buildInputForbid() {
    return TextField(
      controller: TextEditingController(text: '禁言中'),
      readOnly: true,
      textAlign: TextAlign.center,
    );
  }

  // 表情按钮
  _buildEmojiButton() {
    return GestureDetector(
      onTap: () {
        if (_extraType == _ExtraType.emoji) {
          _extraType = _ExtraType.input;
          _focusNode.requestFocus();
        } else {
          _extraType = _ExtraType.emoji;
          _inputType = _InputType.input;
          _scrollToIndex();
          // 收起小桌板
          FocusManager.instance.primaryFocus?.unfocus();
        }
        setState(() {});
      },
      child: _buildIcon(
        _extraType == _ExtraType.emoji ? AppFonts.e618 : AppFonts.e644,
        left: true,
      ),
    );
  }

  // 扩展按钮
  _buildExtraButton() {
    if (_inputType != _InputType.voice &&
        widget.textController.text.isNotEmpty) {
      return GestureDetector(
        onTap: () {
          // 发送文本消息
          _sendText();
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: AppTheme.color,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Text(
              '发 送',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
    // 扩展
    return GestureDetector(
      onTap: () {
        if (_extraType == _ExtraType.extra) {
          _extraType = _ExtraType.none;
        } else {
          _extraType = _ExtraType.extra;
          _scrollToIndex();
        }
        // 收起小桌板
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: _buildIcon(AppFonts.e726),
    );
  }

  // 按钮图标
  _buildIcon(IconData icon, {bool left = false}) {
    return Padding(
      padding: EdgeInsets.only(left: (left ? 8 : 4), right: 8),
      child: Icon(
        icon,
        size: 30,
      ),
    );
  }

  // 发送文本消息
  _sendText() {
    // 文本数据
    String text = widget.textController.text.trim();
    // 清空数据
    widget.textController.clear();
    // 发布消息
    if (text.isEmpty) {
      return;
    }
    // 消息内容
    Map<String, dynamic> content = {
      'data': text,
    };
    MsgType msgType = MsgType.text;
    // 判断消息类型
    if (RegExp(r'@.*༺.*༻').hasMatch(text)) {
      msgType = MsgType.at;
    }
    // 引用消息
    else if (widget.configReply.isNotEmpty) {
      msgType = MsgType.reply;
      content.addAll(widget.configReply);
      widget.configReply.value = {};
    }
    // 组装消息
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}

// 键盘类型
enum _InputType {
  input,
  voice,
}

// 扩展类型
enum _ExtraType {
  none,
  input,
  emoji,
  extra,
}
