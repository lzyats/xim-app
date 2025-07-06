// 类型
import 'package:flutter/material.dart';
import 'package:alpaca/config/app_fonts.dart';

enum SettingType {
  // 关闭
  close('close'),
  // 系统
  sys('sys'),
  // 我的
  mine('mine'),
  // 好友
  friend('friend'),
  // 群聊
  group('group'),
  // 服务
  robot('robot'),
  // 删除
  delete('delete'),
  // 消息
  message('message'),
  // 删除消息
  remove('remove'),
  // 清空消息
  clear('clear'),
  // 计数器
  badger('badger'),
  ;

  const SettingType(this.value);
  final String value;

  static SettingType init(String value) {
    return SettingType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => SettingType.close,
    );
  }
}

// 对象枚举
enum ChatTalk {
  // 单聊
  friend('friend'),
  // 群聊
  group('group'),
  // 机器人
  robot('robot'),
  ;

  const ChatTalk(this.value);
  final String value;

  static ChatTalk init(String value) {
    return ChatTalk.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ChatTalk.friend,
    );
  }
}

// 消息枚举
enum MsgType {
  // 全部
  all('all', '[未知消息]', isRed: true),
  // 提示
  tips('tips', '[提示消息]'),
  // 文本
  text('text', '[文本消息]', isForward: true),
  // at消息
  at('at', '[at消息]'),
  // 图片
  image('image', '[图片消息]', isForward: true),
  // 视频
  video('video', '[视频消息]', isForward: true),
  // 声音
  voice('voice', '[声音消息]'),
  // 文件
  file('file', '[文件消息]', isForward: true),
  // 名片
  card('card', '[名片消息]', isForward: true),
  // 位置
  location('location', '[位置消息]', isForward: true),
  // 撤回
  recall('recall', '[撤回消息]'),
  // 草稿
  draft('draft', '[草稿消息]', isRed: true),
  // 红包
  packet('packet', '[个人红包]', isRed: true),
  // 转账
  transfer('transfer', '[个人转账]', isRed: true),
  // 手气红包
  groupLuck('group_luck', '[手气红包]', isRed: true),
  // 普通红包
  groupPacket('group_packet', '[普通红包]', isRed: true),
  // 专属红包
  groupAssign('group_assign', '[专属红包]', isRed: true),
  // 群内转账
  groupTransfer('group_transfer', '[群内转账]', isRed: true),
  // 卡片消息
  box('box', '[卡片消息]'),
  // 事件消息
  even('even', '[事件消息]'),
  // 聊天记录
  forward('forward', '[聊天记录]', isForward: true),
  // 引用消息
  reply('reply', '[引用消息]', isForward: true),
  // 语音视频
  call('call', '[语音视频]'),
  ;

  const MsgType(
    this.value,
    this.label, {
    this.isRed = false,
    this.isForward = false,
  });
  final String value;
  final String label;
  final bool isRed;
  final bool isForward;

  static MsgType init(String value) {
    return MsgType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MsgType.all,
    );
  }
}

// 成员枚举
enum MemberType {
  // 群主
  master('master', '群主'),
  // 管理员
  manager('manager', '管理员'),
  // 成员
  normal('normal', '成员'),
  ;

  const MemberType(this.value, this.label);
  final String value;
  final String label;

  static MemberType init(String value) {
    return MemberType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MemberType.normal,
    );
  }
}

// 好友枚举
enum FriendSource {
  // 自己
  self('0'),
  // 扫码
  scan('1'),
  // 名片
  card('2'),
  // id查询
  no('3'),
  // 账号
  phone('4'),
  // 群聊
  group('7'),
  // 未知
  other('9'),
  ;

  const FriendSource(this.value);
  final String value;

  static FriendSource init(String value) {
    return FriendSource.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FriendSource.other,
    );
  }
}

// 好友枚举
enum FriendType {
  // 自己
  self('self'),
  // 好友
  friend('friend'),
  // 其他
  other('other'),
  ;

  const FriendType(this.value);
  final String value;

  static FriendType init(String value) {
    return FriendType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FriendType.other,
    );
  }
}

// 支付类型
enum PayType {
  none('9', '无', AppFonts.e606, Colors.orange),
  platform('0', '平台', AppFonts.e606, Colors.orange),
  alipay('1', '支付宝', AppFonts.e634, Colors.blue),
  wechat('2', '微信', AppFonts.eb7d, Colors.green);

  const PayType(this.value, this.label, this.icon, this.color);
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  static PayType init(String value) {
    return PayType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PayType.none,
    );
  }
}

// 交易类型
enum TradeType {
  all('1000', '账单明细', '账单明细'),
  recharge('1001', '充值', '充值记录'),
  cash('1002', '提现', '提现记录'),
  transfer('1003', '个人转账', '转账记录'),
  packet('1004', '个人红包', '红包记录'),
  packetAssign('1005', '专属红包', '红包记录'),
  packetLuck('1006', '手气红包', '红包记录'),
  packetNormal('1007', '普通红包', '红包记录'),
  scan('1008', '扫码转账', '转账记录'),
  refund('1009', '退款', '退款记录'),
  shopping('1010', '消费', '消费记录'),
  groupTansfer('1011', '群内转账', '转账记录');

  const TradeType(this.value, this.label, this.title);
  final String value;
  final String label;
  final String title;

  static TradeType init(String value) {
    return TradeType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TradeType.all,
    );
  }
}

// 状态枚举
enum MiddleStatus {
  // 无状态
  none('none'),
  // 登录
  login('login'),
  // 密码
  pass('pass'),
  // 封禁
  banned('banned'),
  // 正常
  normal('normal'),
  ;

  const MiddleStatus(this.value);
  final String value;

  static MiddleStatus init(String value) {
    return MiddleStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MiddleStatus.login,
    );
  }
}

// 实名认证
enum AuthType {
  none('0', '未认证'),
  apply('1', '审核中'),
  pass('2', '已认证'),
  reject('3', '已驳回'),
  ;

  const AuthType(this.value, this.label);
  final String value;
  final String label;

  static AuthType init(String value) {
    return AuthType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => AuthType.none,
    );
  }
}

// 语音状态
enum CallStatus {
  none('await', '等待接听'),
  reject('reject', '拒绝通话'),
  connect('connect', '已在其他设备接听'),
  cancel('cancel', '取消通话'),
  finish('finish', '通话结束'),
  ;

  const CallStatus(this.value, this.label);
  final String value;
  final String label;

  static CallStatus init(String value) {
    return CallStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CallStatus.none,
    );
  }
}

// 语音状态
enum UniEvent {
  close('close', '关闭'),
  oauth('oauth', '授权'),
  payment('payment', '支付'),
  ;

  const UniEvent(this.value, this.label);
  final String value;
  final String label;

  static UniEvent init(String value) {
    return UniEvent.values.firstWhere(
      (e) => e.value == value,
      orElse: () => UniEvent.close,
    );
  }
}
