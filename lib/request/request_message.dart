// 消息接口
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_socket.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';

class RequestMessage {
  static String get _prefix => '/msg';

  // 发送消息
  static Future<MessageModel00> sendMsg(
    String chatId,
    ChatTalk chatTalk,
    MsgType msgType,
    Map<String, dynamic> content,
  ) async {
    AjaxData ajaxData;
    if (ChatTalk.friend == chatTalk) {
      ajaxData = await _sendFriendMsg(
        chatId,
        msgType,
        content,
      );
    } else if (ChatTalk.group == chatTalk) {
      ajaxData = await _sendGroupMsg(
        chatId,
        msgType,
        content,
      );
    } else {
      ajaxData = await _sendRobotMsg(
        chatId,
        msgType,
        content,
      );
    }
    // 转换
    return ajaxData.getData((data) => MessageModel00.fromJson(data));
  }

  // 发送好友信息
  static Future<AjaxData> _sendFriendMsg(
    String userId,
    MsgType msgType,
    Map<String, dynamic> content,
  ) async {
    // 执行
    return await ToolsRequest().post(
      '$_prefix/sendFriendMsg',
      data: {
        'userId': userId,
        'msgType': msgType.value,
        'content': content,
      },
    );
  }

  // 发送群聊信息
  static Future<AjaxData> _sendGroupMsg(
    String groupId,
    MsgType msgType,
    Map<String, dynamic> content,
  ) async {
    // 执行
    return await ToolsRequest().post(
      '$_prefix/sendGroupMsg',
      data: {
        'groupId': groupId,
        'msgType': msgType.value,
        'content': content,
      },
    );
  }

  // 发送好友信息
  static Future<AjaxData> _sendRobotMsg(
    String robotId,
    MsgType msgType,
    Map<String, dynamic> content,
  ) async {
    // 执行
    return await ToolsRequest().post(
      '$_prefix/sendRobotMsg',
      data: {
        'robotId': robotId,
        'msgType': msgType.value,
        'content': content,
      },
    );
  }

  // 删除消息
  static Future<void> removeMsg(List<String> dataList) async {
    // 执行
    await ToolsRequest().post('$_prefix/removeMsg', data: {
      'dataList': dataList,
    });
  }

  // 清空消息
  static Future<void> clearMsg(String groupId, {String msg = '清空成功'}) async {
    // 执行
    if (groupId.isNotEmpty) {
      await ToolsRequest().get(
        '$_prefix/clearMsg/$groupId',
      );
    }
    // 提醒
    EasyLoading.showToast(msg);
  }

  // 拉取消息
  static Future<void> pullMsg() async {
    // 没有网络
    if (!AppConfig.network) {
      return;
    }
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/pullMsg',
      showError: false,
    );
    // 转换
    List<SocketModel> dataList = ajaxData.getList(
      (data) => SocketModel.fromJson(data),
    );
    List<Map<String, dynamic>> messageList = [];
    for (var data in dataList) {
      messageList.add(data.pushData);
    }
    // 存储
    await EventMessage().addBatch(messageList);
    // 循环
    int messageLimit = ToolsStorage().config().messageLimit;
    if (dataList.length > messageLimit) {
      await pullMsg();
    }
  }

  // 清理消息
  static Future<void> deleteMsg() async {
    // 执行
    await ToolsRequest().get('$_prefix/deleteMsg');
  }

  // 结束通话
  static Future<String> callKit(
    String msgId,
    CallStatus callStatus, {
    int second = 0,
  }) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post('$_prefix/callKit', data: {
      'msgId': msgId,
      'status': callStatus.value,
      'second': second,
    });
    return ajaxData.getData((data) => data) ?? '';
  }
}

class MessageModel00 {
  String msgId;
  String syncId;
  String status;
  String statusLabel;
  String token;
  DateTime createTime;
  MessageModel00(
    this.msgId,
    this.syncId,
    this.status,
    this.statusLabel,
    this.token,
    this.createTime,
  );

  factory MessageModel00.fromJson(Map<String, dynamic>? data) {
    return MessageModel00(
      data?['msgId'] ?? '',
      data?['syncId'] ?? '',
      data?['status'] ?? '0',
      data?['statusLabel'] ?? '正常',
      data?['token'] ?? '',
      DateTime.fromMillisecondsSinceEpoch(int.parse(data?['createTime'] ?? '')),
    );
  }
}
