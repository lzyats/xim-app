// 消息总线
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_enum.dart';

// 监听Socket消息
class EventSocket {
  EventSocket._();
  static EventSocket? _singleton;
  factory EventSocket() => _singleton ??= EventSocket._();
  final StreamController<SocketMessage> event = StreamController.broadcast();

  // 监听Socket
  addListen() {
    return event.stream.listen((message) async {
      // 打印消息
      debugPrint(message.pushData);
      // 解析消息
      Map<String, dynamic>? data = isJson(message.pushData);
      if (data == null) {
        return;
      }
      // 解析消息
      SocketModel model = SocketModel.fromJson(data);
      // 消息类型
      String pushType = model.pushType;
      // 消息数据
      Map<String, dynamic> pushData = model.pushData;
      // 聊天消息
      if ('msg' == pushType) {
        await EventMessage().handle(message.pushAudio, pushData);
      }
      // 设置消息
      else if ('setting' == pushType) {
        SettingType setting = SettingType.init(pushData['type']);
        Map<String, dynamic> data = pushData['data'];
        await EventSetting().handle(
          SettingModel(
            setting,
            primary: data['primary'],
            label: data['label'],
            value: data['value'],
          ),
        );
      }
    });
  }

  // 判断json
  Map<String, dynamic>? isJson(String message) {
    try {
      return jsonDecode(message);
    } catch (e) {
      return null;
    }
  }
}

class SocketMessage {
  bool pushAudio;
  String pushData;

  SocketMessage(
    this.pushAudio,
    this.pushData,
  );
}

class SocketModel {
  String pushType;
  Map<String, dynamic> pushData;

  SocketModel(
    this.pushType,
    this.pushData,
  );

  factory SocketModel.fromJson(Map<String, dynamic> data) {
    return SocketModel(
      data['pushType'],
      data['pushData'],
    );
  }
}
