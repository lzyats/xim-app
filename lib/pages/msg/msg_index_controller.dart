import 'dart:async';

import 'package:alpaca/request/request_common.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/request/request_robot.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MsgIndexController extends BaseController {
  String userId = ToolsStorage().local().userId;
  RxString notice = ''.obs;
  final Map<String, ChatMsg> _dataMap = {};

  // 不显示
  Future<void> setDelete(String chatId) async {
    // 删除
    await ToolsSqlite().msg.delete(chatId);
    // 移除
    refreshList.remove(_dataMap[chatId]);
    // 删除
    ToolsStorage().draft(chatId);
    // 删除
    ToolsStorage().reply(chatId);
    // 删除
    doRead(chatId);
    // 取消
    ToolsSubmit.cancel();
  }

  // 已读
  Future<void> doRead(String chatId) async {
    // 更新
    ToolsBadger().reset(chatId);
    // 已读
    await ToolsSqlite().his.update(chatId, {'badger': 'N'});
    // 更新
    update();
    // 取消
    ToolsSubmit.cancel();
    // 消息
    EventSetting().handle(SettingModel(
      SettingType.badger,
      label: 'message',
      value: '0',
    ));
  }

  // 删除
  Future<void> setClear(String chatId, ChatTalk chatTalk) async {
    // 请求
    String groupId = '';
    switch (chatTalk) {
      case ChatTalk.friend:
        // 查询
        ChatFriend? friend = await ToolsSqlite().friend.getById(chatId);
        if (friend != null) {
          groupId = friend.groupId;
        }
        break;
      default:
        groupId = chatId;
        break;
    }
    // 删除消息
    await RequestMessage.clearMsg(groupId, msg: '删除成功');
    // 删除消息
    await ToolsSqlite().extend.clearMsg(chatId);
    // 移除消息
    refreshList.remove(_dataMap[chatId]);
    // 删除草稿
    ToolsStorage().draft(chatId);
    // 删除草稿
    ToolsStorage().reply(chatId);
    // 删除角标
    doRead(chatId);
    // 取消
    ToolsSubmit.cancel();
  }

  // 静默
  Future<void> setDisturb(ChatMsg chatMsg) async {
    String chatId = chatMsg.chatId;
    ChatTalk chatTalk = chatMsg.chatTalk;
    String disturb = chatMsg.disturb ? 'N' : 'Y';
    // 好友
    if (ChatTalk.friend == chatTalk) {
      // 执行
      await RequestFriend.setDisturb(chatId, disturb);
    }
    // 群组
    else if (ChatTalk.group == chatTalk) {
      // 执行
      await RequestGroup.setDisturb(chatId, disturb);
    }
    // 机器人
    else if (ChatTalk.robot == chatTalk) {
      // 执行
      await RequestRobot.setDisturb(chatId, disturb);
    }
    // 更新
    chatMsg.disturb = !chatMsg.disturb;
    update();
    // 取消
    ToolsSubmit.cancel();
  }

  // 置顶
  Future<void> setTop(ChatMsg chatMsg) async {
    String chatId = chatMsg.chatId;
    ChatTalk chatTalk = chatMsg.chatTalk;
    String top = chatMsg.top ? 'N' : 'Y';
    // 好友
    if (ChatTalk.friend == chatTalk) {
      // 执行
      await RequestFriend.setTop(chatId, top);
    }
    // 群组
    else if (ChatTalk.group == chatTalk) {
      // 执行
      await RequestGroup.setTop(chatId, top);
    }
    // 机器人
    else if (ChatTalk.robot == chatTalk) {
      // 执行
      await RequestRobot.setTop(chatId, top);
    }
    chatMsg.top = !chatMsg.top;
    update();
    // 取消
    ToolsSubmit.cancel();
  }

  // 消息刷新
  _onRefresh() async {
    // 更新
    refreshList = await ToolsSqlite().msg.getList();
    for (ChatMsg data in refreshList) {
      _dataMap[data.chatId] = data;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // 监听消息
    _listenMessage();
    // 监听设置
    _listenSetting();
    // 消息刷新
    _onRefresh();
    // 定时任务
    _listenTimer();
  }

  // 监听设置（处理最新通知/处理消息刷新）
  _listenSetting() {
    // 获取通知
    _notice();
    // 监听通知
    subscription2 = EventSetting().event.stream.listen((model) {
      if (SettingType.sys == model.setting) {
        // 获取通知
        _notice();
      } else if (SettingType.message == model.setting) {
        // 消息刷新
        _onRefresh();
      }
    });
  }

  // 获取通知
  _notice() {
    notice.value = ToolsStorage().config().notice;
  }

  // 监听消息（当有新消息，显示到消息顶部）
  _listenMessage() {
    subscription1 = EventMessage().listenMsg.stream.listen((chatMsg) {
      // 移除
      refreshList.remove(_dataMap[chatMsg.chatId]);
      // 插入
      _dataMap[chatMsg.chatId] = chatMsg;
      refreshList.add(chatMsg);
      // 更新
      update();
    });
  }

  // 定时任务（每间隔1分钟，刷新一次页面时间显示）
  _listenTimer() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      update();
    });
  }

  // 下拉刷新
  void onRefresh() {
    // 获取配置
    RequestCommon.getConfig();
    // 获取消息
    superRefresh(
      RequestMessage.pullMsg(),
    );
  }
}
