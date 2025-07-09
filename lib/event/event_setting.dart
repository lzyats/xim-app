// 消息总线
import 'dart:async';
import 'dart:convert';

import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 监听Setting消息
class EventSetting {
  EventSetting._();
  static EventSetting? _singleton;
  factory EventSetting() => _singleton ??= EventSetting._();
  final StreamController<SettingModel> event = StreamController.broadcast();
  // 设置消息
  handle(SettingModel model) async {
    SettingType setting = model.setting;
    // 关闭
    if (SettingType.close == setting) {
      // 写入事件
      event.add(model);
    }
    // 消息
    else if (SettingType.message == setting) {
      // 写入事件
      event.add(model);
    }
    // 系统
    else if (SettingType.sys == setting) {
      String primary = model.primary;
      String label = model.label;
      String value = model.value;
      LocalConfig localConfig = ToolsStorage().config();
      switch (label) {
        // 通知
        case 'notice':
          // 写入存储
          localConfig.notice = value;
          // 存储数据
          ToolsStorage().config(value: localConfig);
          break;
        // 通话
        case 'call':
          // 更新消息
          ChatHis? chatHis = await ToolsSqlite().his.getById(primary);
          if (chatHis != null) {
            // 转换
            chatHis.content = jsonDecode(value);
            // 存储
            await ToolsSqlite().his.add(chatHis);
            // 广播
            EventMessage().listenHis.add(chatHis);
          }
          break;
      }
      // 写入事件
      event.add(model);
    }
    // 我的
    else if (SettingType.mine == setting) {
      String label = model.label;
      String value = model.value;
      // 转化数据
      LocalUser localUser = ToolsStorage().local();
      switch (label) {
        case 'nickname':
          localUser.nickname = value;
          break;
        case 'portrait':
          localUser.portrait = value;
          break;
        case 'gender':
          localUser.gender = value;
          break;
        case 'intro':
          localUser.intro = value;
          break;
        case 'city':
          List<String> array = value.split('&');
          localUser.province = array.first;
          localUser.city = array.last;
          break;
        case 'birthday':
          localUser.birthday = value;
          break;
        case 'privacyNo':
          localUser.privacyNo = value;
          break;
        case 'privacyPhone':
          localUser.privacyPhone = value;
          break;
        case 'privacyScan':
          localUser.privacyScan = value;
          break;
        case 'privacyCard':
          localUser.privacyCard = value;
          break;
        case 'privacyGroup':
          localUser.privacyGroup = value;
          break;
        case 'payment':
          localUser.payment = value;
          break;
        case 'pass':
          localUser.pass = value;
          break;
        case 'email':
          localUser.email = value;
          break;
        case 'auth':
          localUser.auth = AuthType.init(value);
          break;
      }
      // 存储数据
      ToolsStorage().local(value: localUser);
      // 更新
      if ('nickname' == label || 'portrait' == label) {
        String userId = localUser.userId;
        String nickname = localUser.nickname;
        String portrait = localUser.portrait;
        Map<String, Object?> values = {
          'nickname': nickname,
          'portrait': portrait,
        };
        // 更新自己
        await ToolsSqlite().friend.update(userId, values);
        // 更新消息
        await ToolsSqlite().msg.update(userId, values);
        // 更新消息
        await ToolsSqlite().his.update(userId, values);
        // 写入事件
        event.add(SettingModel(SettingType.friend, primary: userId));
        // 写入事件
        event.add(SettingModel(SettingType.message));
      }
      // 通知
      event.add(model);
    }
    // 好友
    else if (SettingType.friend == setting) {
      String userId = model.primary;
      String label = model.label;
      String value = model.value;
      // 新友
      if ('create' == label) {
        // 查询好友
        ChatFriend? chatFriend = await RequestFriend.getInfo(userId);
        if (chatFriend == null) {
          return;
        }
        // 写入数据库
        await ToolsSqlite().friend.add(chatFriend);
      }
      // 删除
      else if ('delete' == label) {
        // 删除好友
        await ToolsSqlite().friend.delete(userId);
        // 删除消息
        await ToolsSqlite().extend.clearMsg(userId);
        // 更新缓存
        ToolsStorage().top(userId, value: 'N');
        ToolsStorage().disturb(userId);
        ToolsStorage().remark(userId);
        ToolsStorage().draft(userId);
        ToolsStorage().reply(userId);
      }
      // 更新
      else {
        // 修改
        switch (label) {
          case 'remark':
            ToolsStorage().remark(userId, value: value);
            break;
          case 'top':
            ToolsStorage().top(userId, value: value);
            break;
          case 'disturb':
            ToolsStorage().disturb(userId, value: value);
            break;
          default:
            return;
        }
        // 更新
        await ToolsSqlite().friend.update(userId, {label: value});
        // 备注
        if ('remark' == label) {
          Map<String, Object?> values = {'nickname': value};
          // 更新消息
          await ToolsSqlite().msg.update(userId, values);
          // 更新消息
          await ToolsSqlite().his.update(userId, values);
        }
      }
      // 写入事件
      event.add(SettingModel(SettingType.message));
      // 写入事件
      event.add(SettingModel(SettingType.friend, primary: userId));
    }
    // 服务
    else if (SettingType.robot == setting) {
      String robotId = model.primary;
      String label = model.label;
      String value = model.value;
      // 修改
      switch (label) {
        case 'top':
          ToolsStorage().top(robotId, value: value);
          break;
        case 'disturb':
          ToolsStorage().disturb(robotId, value: value);
          break;
        default:
          return;
      }
      // 写入事件
      event.add(SettingModel(SettingType.message));
    }
    // 群聊
    else if (SettingType.group == setting) {
      String groupId = model.primary;
      String label = model.label;
      String value = model.value;
      // 新群
      if ('create' == label) {
        // 查询群聊
        await RequestGroup.getInfo(groupId);
      }
      // 删除
      else if ('delete' == label) {
        // 删除群聊
        await ToolsSqlite().group.delete(groupId);
        // 删除消息
        await ToolsSqlite().extend.clearMsg(groupId);
        // 更新缓存
        ToolsStorage().top(groupId);
        ToolsStorage().disturb(groupId);
        ToolsStorage().draft(groupId);
        ToolsStorage().reply(groupId);
        ToolsBadger().reset(groupId);
      }
      // 更新
      else {
        switch (label) {
          case 'groupName':
          case 'portrait':
          case 'notice':
          case 'noticeTop':
          case 'memberTop':
          case 'memberDisturb':
          case 'memberRemark':
          case 'memberType':
          case 'memberSpeak':
          case 'memberWhite':
          case 'memberTotal':
          case 'configMember':
          case 'configInvite':
          case 'configTitle':
          case 'configNickname':
          case 'configPacket':
          case 'configAmount':
          case 'configScan':
          case 'configReceive':
          case 'configAssign':
          case 'configMedia':
          case 'configSpeak':
          case 'configAudit':
          case 'privacyScan':
          case 'privacyNo':
          case 'privacyName':
            break;
          default:
            return;
        }
        // 更新
        await ToolsSqlite().group.update(groupId, {label: value});
        // 修改
        switch (label) {
          case 'groupName':
            ToolsStorage().remark(groupId, value: value);
            break;
          case 'top':
            ToolsStorage().top(groupId, value: value);
            break;
          case 'disturb':
            ToolsStorage().disturb(groupId, value: value);
            break;
        }
        if ('groupName' == label || 'portrait' == label) {
          Map<String, Object?> values = {label: value};
          if ('groupName' == label) {
            values = {'nickname': value};
          }
          // 更新消息
          await ToolsSqlite().msg.update(groupId, values);
          // 更新消息
          await ToolsSqlite().his.update(groupId, values);
        }
      }
      // 写入事件
      event.add(SettingModel(SettingType.message));
      // 写入事件
      event.add(SettingModel(SettingType.group, primary: groupId));
    }
    // 删除消息
    else if (SettingType.remove == setting) {
      String chatId = model.primary;
      String label = model.label;
      List<String>? dataList = model.dataList;
      // 删除消息
      if ('remove' == label) {
        await RequestMessage.removeMsg(dataList!);
      }
      // 删除消息
      await ToolsSqlite().extend.deleteMsg(chatId, dataList);
      // 写入事件
      event.add(SettingModel(SettingType.message));
      // 写入事件
      event.add(model);
    }
    // 清空消息
    else if (SettingType.clear == setting) {
      String chatId = model.primary;
      String groupId = model.value;
      // 删除消息
      await RequestMessage.clearMsg(groupId);
      // 删除消息
      await ToolsSqlite().extend.clearMsg(chatId, delete: false);
      // 写入事件
      event.add(SettingModel(SettingType.message));
      // 写入事件
      event.add(model);
    }
    // 计数器
    else if (SettingType.badger == setting) {
      switch (model.label) {
        case 'friend':
        case 'group':
        case 'message':
          break;
        default:
          return;
      }
      // 写入事件
      event.add(model);
    }
  }
}

class SettingModel {
  // 类型
  final SettingType setting;
  // 主键
  final String primary;
  // 字段
  final String label;
  // 数据
  final String value;
  // 参数
  final List<String>? dataList;

  SettingModel(
    this.setting, {
    this.primary = '',
    this.label = '',
    this.value = '',
    this.dataList,
  });
}
