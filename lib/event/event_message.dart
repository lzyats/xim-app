// 消息总线
import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_call.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_upload.dart';
import 'package:uuid/uuid.dart';

// 监听聊天消息
class EventMessage {
  EventMessage._();
  static EventMessage? _singleton;
  factory EventMessage() => _singleton ??= EventMessage._();
  // 消息
  final StreamController<ChatMsg> listenMsg = StreamController.broadcast();
  // 历史
  final StreamController<ChatHis> listenHis = StreamController.broadcast();
  // 发送
  final StreamController<EventChatModel> listenSend =
      StreamController.broadcast();

  // 处理接收到的消息
  Future<void> handle(Map<String, dynamic> pushData) async {
    // 历史消息
    ChatHis? chatHis = _initChatHis(pushData);
    if (chatHis == null) {
      return;
    }
    // 处理
    switch (chatHis.msgType) {
      // 撤回
      case MsgType.recall:
        _recall(chatHis.chatId, chatHis.content['data'], badger: true);
        return;
      // 语音/视频
      case MsgType.call:
        // 通话中
        if (AppConfig.callKit) {
          RequestMessage.callKit(
            chatHis.msgId,
            CallStatus.reject,
          );
        }
        // 拉起
        else if (!chatHis.self) {
          String userId = chatHis.source['userId'];
          String nickname = chatHis.source['nickname'];
          Get.to(ToolsCall(
            nickname: ToolsStorage().remark(
              userId,
              value: nickname,
              read: true,
            ),
            portrait: chatHis.source['portrait'],
            video: 'video' == chatHis.content['callType'],
            channel: chatHis.msgId,
            chatId: chatHis.chatId,
          ));
        }
        break;
      default:
        break;
    }
    // 最新消息
    chatHis.requestId = chatHis.msgId;
    ChatMsg chatMsg = ChatMsg.fromChatHis(chatHis);
    // 插入历史
    await ToolsSqlite().his.add(chatHis);
    // 插入消息
    await ToolsSqlite().msg.add(chatMsg);
    // 广播消息
    listenHis.add(chatHis);
    // 广播消息
    listenMsg.add(chatMsg);
    // 消息提醒
    if (!chatHis.self && ToolsBadger().validaMsgId(chatHis.msgId)) {
      // 准备工作
      LocalUser localUser = ToolsStorage().local();
      // 提醒
      _tips(chatMsg, localUser.userId);
      // 计数器
      ToolsBadger().increment(chatHis.chatId);
      // 消息
      EventSetting().handle(SettingModel(
        SettingType.badger,
        label: 'message',
        value: '0',
      ));
    }
  }

  // 提醒
  void _tips(ChatMsg chatMsg, String userId) async {
    // 语音
    if (MsgType.call == chatMsg.msgType) {
      return;
    }
    // 静默
    bool disturb = chatMsg.disturb;
    if (disturb) {
      // @消息
      if (MsgType.at == chatMsg.msgType) {
        String text = chatMsg.content['data'];
        disturb = ToolsRegex.disturb(text, userId);
      }
    }
    if (disturb) {
      return;
    }
    // 开启响铃
    if ('Y' == ToolsStorage().setting().audio) {
      FlutterRingtonePlayer().play(
        android: AndroidSounds.notification, //android系统声音
        ios: IosSounds.glass, //ios系统声音
        looping: false, //铃声循环
        volume: 1.0,
      );
    }
    // 开启通知
    if ('Y' == ToolsStorage().setting().notice) {
      if (!AppConfig.open) {
        int badge = await AwesomeNotifications().incrementGlobalBadgeCounter();
        if (badge > 0) {
          await AwesomeNotifications()
              .cancelNotificationsByChannelKey('alerts');
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: -1,
              channelKey: 'alerts',
              body: '您有$badge条新消息，请注意查收',
              badge: badge,
            ),
          );
        }
      }
    }
  }

  // 离线消息
  Future<void> addBatch(List<Map<String, dynamic>> dataList) async {
    // 处理消息
    if (dataList.isNotEmpty) {
      List<ChatHis> messageList = [];
      // 请求ID
      String requestId = const Uuid().v8();
      for (var pushData in dataList) {
        // 历史消息
        ChatHis? chatHis = _initChatHis(
          pushData,
          requestId: requestId,
        );
        if (chatHis == null) {
          continue;
        }
        // 撤回
        if (MsgType.recall == chatHis.msgType) {
          _recall(chatHis.chatId, chatHis.content['data']);
          continue;
        }
        // 最新消息
        messageList.add(chatHis);
      }
      // 插入消息
      await ToolsSqlite().extend.addBatch(messageList, requestId);
    }
    // 获取脚标
    List<Map<String, dynamic>> resultList =
        await ToolsSqlite().extend.getBadger();
    // 清空
    ToolsBadger().clear();
    // 更新角标
    for (var result in resultList) {
      ToolsBadger().set(
        result['chatId'],
        result['value'],
      );
    }
    // 计算
    ToolsBadger().calculate(reset: true);
    // 写入事件
    EventSetting().handle(SettingModel(SettingType.message));
  }

  // 组装历史消息
  ChatHis? _initChatHis(Map<String, dynamic> pushData, {String? requestId}) {
    // 准备工作
    LocalUser localUser = ToolsStorage().local();
    Map<String, dynamic> source = pushData['source'];
    String sign = source['sign'] ?? '';
    // 同步消息
    if (localUser.sign == sign) {
      return null;
    }
    bool self = localUser.userId == source['userId'];
    int createTime = int.parse(pushData['createTime']);
    MsgType msgType = MsgType.init(pushData['msgType']);
    Map<String, dynamic> content = pushData['content'];
    if (MsgType.at == msgType) {
      String data = content['data'];
      bool tips =
          data.contains('༺0༻') || data.contains('༺${localUser.userId}༻');
      content['status'] = tips ? 'Y' : 'N';
    }
    return ChatHis(
      pushData['msgId'],
      requestId ?? pushData['msgId'],
      pushData['syncId'],
      pushData['chatId'],
      pushData['portrait'],
      pushData['nickname'],
      source,
      msgType,
      content,
      ChatTalk.init(pushData['chatTalk']),
      DateTime.fromMillisecondsSinceEpoch(createTime),
      self: self,
      pushData: pushData,
      badger: self ? 'N' : 'Y',
    );
  }

  // 监听聊天消息
  addListen() {
    return listenSend.stream.listen((chatModel) async {
      // 聊天对象
      LocalChat localChat = chatModel.chat;
      // 消息类型
      MsgType msgType = chatModel.msgType;
      // 聊天对象
      LocalUser localUser = ToolsStorage().local();
      // 请求ID
      String requestId = const Uuid().v8();
      // 消息内容
      Map<String, dynamic> content = chatModel.content;
      // 扩展内容
      dynamic extend = chatModel.extend;
      Map<String, dynamic> source = {
        'userId': localUser.userId,
        'nickname': localUser.nickname,
        'portrait': localUser.portrait,
        'sign': localUser.sign,
      };
      // 组装消息
      ChatHis chatHis = ChatHis(
        requestId,
        requestId,
        requestId,
        localChat.chatId,
        localChat.portrait,
        localChat.title,
        source,
        msgType,
        content,
        localChat.chatTalk,
        DateTime.now(),
        status: 'R',
      );
      // 写入消息
      if (chatModel.write) {
        // 广播消息
        listenHis.add(chatHis);
      }
      // 处理消息
      if (chatModel.handle) {
        // 处理消息
        content = await _doHandle(chatHis, extend);
      }
      // 发送消息
      MessageModel00 result = await RequestMessage.sendMsg(
        localChat.chatId,
        localChat.chatTalk,
        msgType,
        content,
      );
      // 处理 || 成功
      if (chatModel.result || '0' == result.status) {
        // 处理结果
        chatHis.msgId = result.msgId;
        chatHis.syncId = result.syncId;
        chatHis.createTime = result.createTime;
        chatHis.status = '0' == result.status ? 'Y' : 'N';
        chatHis.statusLabel = result.statusLabel;
        // 撤回
        if (MsgType.recall == msgType) {
          _recall(chatModel.content['chatId'], chatModel.content['data']);
        }
        // 事件
        else if (MsgType.even == msgType) {
        }
        // 正常
        else {
          // 语音视频
          if (MsgType.call == msgType) {
            Get.to(ToolsCall(
              nickname: localChat.nickname,
              portrait: localChat.portrait,
              video: 'video' == chatHis.content['callType'],
              channel: result.msgId,
              token: result.token,
              request: true,
            ));
          }
          // 插入历史
          await ToolsSqlite().his.add(chatHis);
          // 消息数据
          ChatMsg chatMsg = ChatMsg.fromChatHis(chatHis);
          // 插入消息
          await ToolsSqlite().msg.add(chatMsg);
          // 广播消息
          listenHis.add(chatHis);
          // 广播消息
          listenMsg.add(chatMsg);
        }
        // 不处理
        if (!chatModel.result) {
          // 关闭
          EventSetting().handle(SettingModel(SettingType.close));
        }
        // 取消
        ToolsSubmit.cancel();
      } else {
        throw Exception(result.statusLabel);
      }
    });
  }

  // 处理消息
  Future<Map<String, dynamic>> _doHandle(
    ChatHis chatHis,
    dynamic extend,
  ) async {
    MsgType msgType = chatHis.msgType;
    Map<String, dynamic> content = chatHis.content;
    // 处理消息
    switch (msgType) {
      // 图片
      case MsgType.image:
        // 上传
        String path = await ToolsUpload.uploadFile(
          content['data'],
        );
        // 赋值
        content = {
          'data': path,
          'height': content['height'],
          'width': content['width'],
          'scan': content['scan'],
        };
        // 赋值
        chatHis.content.addAll(content);
        break;
      // 视频
      case MsgType.video:
        String data = content['data'];
        // 上传缩略
        String thumbnail = await ToolsUpload.uploadFile(
          content['localThumbnail'],
        );
        // 赋值
        content = {
          'thumbnail': thumbnail,
          'height': content['height'],
          'width': content['width'],
        };
        // 赋值
        chatHis.content.addAll(content);
        // 上传视频
        content['data'] = await ToolsUpload.uploadVideo(
          data,
        );
        // 赋值
        chatHis.content.addAll(content);
        break;
      // 声音
      case MsgType.voice:
        String path = await ToolsUpload.uploadFile(
          content['data'].replaceFirst('file://', ''),
        );
        content = {
          'data': path,
          'second': content['second'],
        };
        // 路径
        chatHis.content['data'] = path;
        break;
      // 文件
      case MsgType.file:
        String path = await ToolsUpload.uploadFile(
          content['data'],
        );
        content = {
          'data': path,
          'mimeType': content['mimeType'],
          'size': content['size'],
          'title': content['title'],
        };
        // 路径
        chatHis.content['data'] = path;
        break;
      // 位置
      case MsgType.location:
        String path = await ToolsUpload.uploadBytesData(
          extend,
        );
        content = {
          'title': content['title'],
          'latitude': content['latitude'],
          'longitude': content['longitude'],
          'address': content['address'],
          'thumbnail': path,
        };
        // 缩略
        chatHis.content['thumbnail'] = path;
        break;
      default:
        break;
    }
    return content;
  }

  // 撤回
  _recall(String chatId, String msgId, {bool badger = false}) {
    EventSetting().handle(
      SettingModel(
        SettingType.remove,
        primary: chatId,
        dataList: [msgId],
      ),
    );
    // 去掉角标
    if (badger && ToolsBadger().validaMsgId(msgId)) {
      ToolsBadger().subtraction(chatId);
    }
  }
}

// 扩展对象
class EventChatModel {
  // 接收对象
  LocalChat chat;
  // 消息类型
  MsgType msgType;
  // 消息内容
  Map<String, dynamic> content;
  // 扩展
  dynamic extend;
  // 处理状态 true = 需要处理
  bool handle;
  // 写入状态 true = 需要写入
  bool write;
  // 处理结果 true = 需要处理
  bool result;

  EventChatModel(
    this.chat,
    this.msgType,
    this.content, {
    this.extend,
    this.handle = true,
    this.write = true,
    this.result = true,
  });
}
