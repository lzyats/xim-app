// 群聊接口

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

class RequestGroup {
  static String get _prefix => '/group';

  // 搜索群聊
  static Future<List<GroupModel03>> search(int pageNum, String param) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/search',
      pageNum,
      data: {'param': param},
    );
    // 转换
    return ajaxData.getList((data) => GroupModel03.fromJson(data));
  }

  // 搜索群聊
  static Future<GroupModel03?> scan(String groupId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/scan/$groupId',
    );
    // 转换
    return ajaxData.getData((data) => GroupModel03.fromJson(data));
  }

  // 群聊列表
  static Future<List<ChatGroup>> getGroupList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/groupList',
      showError: false,
    );
    // 转换
    List<ChatGroup> dataList = ajaxData.getList((data) {
      ChatGroup group = ChatGroup.fromJson(data);
      ToolsStorage().top(group.groupId, value: group.memberTop);
      ToolsStorage().disturb(group.groupId, value: group.memberDisturb);
      return group;
    });
    // 存储
    await ToolsSqlite().group.addBatch(dataList);
    // 通知
    EventSetting().event.add(SettingModel(SettingType.group));
    return dataList;
  }

  // 群聊详情
  static Future<ChatGroup> getInfo(String groupId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getInfo/$groupId',
    );
    // 转换
    ChatGroup chatGroup = ajaxData.getData((data) {
      ChatGroup group = ChatGroup.fromJson(data);
      ToolsStorage().top(group.groupId, value: group.memberTop);
      ToolsStorage().disturb(group.groupId, value: group.memberDisturb);
      return group;
    });
    // 写入数据库
    await ToolsSqlite().group.add(chatGroup);
    // 返回
    return chatGroup;
  }

  // 群聊举报
  static Future<void> inform(String informType, String groupId,
      List<String> images, String content) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/inform',
      data: {
        "informType": informType,
        "groupId": groupId,
        "images": images,
        "content": content,
      },
    );
    EasyLoading.showToast('操作成功');
  }

  // 修改群昵称
  static Future<void> setRemark(String groupId, String remark) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setRemark',
      data: {
        'groupId': groupId,
        'remark': remark,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 置顶
  static Future<void> setTop(String groupId, String top) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setTop',
      data: {
        'groupId': groupId,
        'top': top,
      },
    );
    ToolsStorage().top(groupId, value: top);
  }

  // 静默
  static Future<void> setDisturb(String groupId, String disturb) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setDisturb',
      data: {
        'groupId': groupId,
        'disturb': disturb,
      },
    );
    ToolsStorage().disturb(groupId, value: disturb);
  }

  // 成员列表
  static Future<List<GroupModel02>> getMemberList(String groupId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getMemberList/$groupId',
    );
    // 转换
    return ajaxData.getList((data) => GroupModel02.fromJson(data));
  }

  // 邀请好友
  static Future<void> invite(String groupId, List<String> friendList) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/invite',
      data: {
        'groupId': groupId,
        'friendList': friendList,
      },
    );
    EasyLoading.showToast('操作成功');
  }

  // 创建群聊
  static Future<void> create(List<String> friendList) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/create',
      data: {
        'friendList': friendList,
      },
    );
    EasyLoading.showToast('操作成功');
  }

  // 退出
  static Future<void> logout(String groupId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/logout/$groupId',
    );
    ToolsStorage().top(groupId);
    ToolsStorage().disturb(groupId);
    // 提醒
    EasyLoading.showToast('退出成功');
  }

  // 申请入群
  static Future<void> join(
    String groupId,
    String source,
    String configAudit,
  ) async {
    // 执行
    await ToolsRequest().post('$_prefix/join', data: {
      'groupId': groupId,
      'source': source,
    });
    String msg = '申请成功';
    if ('Y' == configAudit) {
      msg = '申请成功，等待待管理员审核';
    }
    // 提醒
    EasyLoading.showToast(msg);
  }

  // 修改头像
  static Future<void> editPortrait(
    String groupId,
    String portrait,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editPortrait',
      data: {
        'groupId': groupId,
        'portrait': portrait,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改群名
  static Future<void> editGroupName(
    String groupId,
    String groupName,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editGroupName',
      data: {
        'groupId': groupId,
        'groupName': groupName,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改公告
  static Future<void> editNotice(String groupId, String notice) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editNotice',
      data: {
        'groupId': groupId,
        'notice': notice,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改公告置顶
  static Future<void> editNoticeTop(String groupId, String noticeTop) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editNoticeTop',
      data: {
        'groupId': groupId,
        'noticeTop': noticeTop,
      },
    );
  }

  // 进群审核
  static Future<void> editConfigAudit(
    String groupId,
    String configAudit,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigAudit',
      data: {
        'groupId': groupId,
        'configAudit': configAudit,
      },
    );
  }

  // 扫码进群
  static Future<void> editPrivacyScan(
    String groupId,
    String privacyScan,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editPrivacyScan',
      data: {
        'groupId': groupId,
        'privacyScan': privacyScan,
      },
    );
  }

  // 搜索进群
  static Future<void> editPrivacyNo(
    String groupId,
    String privacyNo,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editPrivacyNo',
      data: {
        'groupId': groupId,
        'privacyNo': privacyNo,
      },
    );
  }

  // 搜索进群
  static Future<void> editPrivacyName(
    String groupId,
    String privacyName,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editPrivacyName',
      data: {
        'groupId': groupId,
        'privacyName': privacyName,
      },
    );
  }

  // 禁止昵称开关
  static Future<void> editConfigNickname(
    String groupId,
    String configNickname,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigNickname',
      data: {
        'groupId': groupId,
        'configNickname': configNickname,
      },
    );
  }

  // 全员禁言
  static Future<void> editConfigSpeak(
    String groupId,
    String configSpeak,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigSpeak',
      data: {
        'groupId': groupId,
        'configSpeak': configSpeak,
      },
    );
  }

  // 资源开关
  static Future<void> editConfigMedia(
    String groupId,
    String configMedia,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigMedia',
      data: {
        'groupId': groupId,
        'configMedia': configMedia,
      },
    );
  }

  // 专属可见
  static Future<void> editConfigAssign(
    String groupId,
    String configAssign,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigAssign',
      data: {
        'groupId': groupId,
        'configAssign': configAssign,
      },
    );
  }

  // 红包开关
  static Future<void> editConfigPacket(
    String groupId,
    String configPacket,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigPacket',
      data: {
        'groupId': groupId,
        'configPacket': configPacket,
      },
    );
  }

  // 红包禁抢
  static Future<void> editConfigReceive(
    String groupId,
    String configReceive,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigReceive',
      data: {
        'groupId': groupId,
        'configReceive': configReceive,
      },
    );
  }

  // 显示金额
  static Future<void> editConfigAmount(
    String groupId,
    String configAmount,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigAmount',
      data: {
        'groupId': groupId,
        'configAmount': configAmount,
      },
    );
  }

  // 群聊头衔
  static Future<void> editConfigTitle(
    String groupId,
    String configTitle,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigTitle',
      data: {
        'groupId': groupId,
        'configTitle': configTitle,
      },
    );
  }

  // 成员邀请
  static Future<void> editConfigInvite(
    String groupId,
    String configInvite,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigInvite',
      data: {
        'groupId': groupId,
        'configInvite': configInvite,
      },
    );
  }

  // 成员保护
  static Future<void> editConfigMember(
    String groupId,
    String configMember,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigMember',
      data: {
        'groupId': groupId,
        'configMember': configMember,
      },
    );
  }

  // 二维码
  static Future<void> editConfigScan(
    String groupId,
    String configScan,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editConfigScan',
      data: {
        'groupId': groupId,
        'configScan': configScan,
      },
    );
  }

  // 解散群聊
  static Future<void> dissolve(String groupId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/manager/dissolve/$groupId',
    );
  }

  // 解散踢人
  static Future<void> kicked(
    String groupId,
    List<String> memberList,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/kicked',
      data: {
        'groupId': groupId,
        'dataList': memberList,
      },
    );
  }

  // 设置管理员
  static Future<void> setManager(
    String groupId,
    List<String> memberList,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/setManager',
      data: {
        'groupId': groupId,
        'memberList': memberList,
      },
    );
  }

  // 转让群聊
  static Future<void> transfer(String groupId, String userId) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/transfer',
      data: {
        'groupId': groupId,
        'userId': userId,
      },
    );
  }

  // 修改成员昵称
  static Future<void> setNickname(
    String groupId,
    String userId,
    String nickname,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/setNickname',
      data: {
        'groupId': groupId,
        'userId': userId,
        'nickname': nickname,
      },
    );
    ToolsStorage().top(userId);
    ToolsStorage().disturb(userId);
  }

  // 查询红包白名单
  static Future<List<String>> queryPacketWhite(String groupId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/manager/queryPacketWhite/$groupId',
    );
    return ajaxData.getList((data) => data);
  }

  // 修改红包白名单
  static Future<void> editPacketWhite(
    String groupId,
    List<String> memberList,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/editPacketWhite',
      data: {
        'groupId': groupId,
        'dataList': memberList,
      },
    );
  }

  // 修改红包白名单
  static Future<void> speak(
    String groupId,
    String userId,
    String speakType,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/manager/speak',
      data: {
        'groupId': groupId,
        'userId': userId,
        'speakType': speakType,
      },
    );
  }

  // 扩容价格
  static Future<List<GroupModel04>> groupLevelPrice(String groupId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/manager/groupLevelPrice/$groupId',
    );
    return ajaxData.getList((data) => GroupModel04.fromJson(data));
  }

  // 扩容支付
  static Future<void> groupLevelPay(
      String groupId, int level, String password) async {
    // 执行
    await ToolsRequest().post('$_prefix/manager/groupLevelPay', data: {
      "groupId": groupId,
      "groupLevel": level,
      "password": password,
    });
    // 提醒
    EasyLoading.showToast('扩容成功');
  }

  // 群聊审批
  static Future<List<GroupModel01>> applyList(int pageNum) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/manager/applyList',
      pageNum,
    );
    // 转换
    return ajaxData.getList((data) => GroupModel01.fromJson(data));
  }

  // 申请同意
  static Future<void> applyAgree(String applyId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/manager/applyAgree/$applyId',
    );
    EasyLoading.showToast('操作成功');
  }

  // 申请拒绝
  static Future<void> applyReject(String applyId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/manager/applyReject/$applyId',
    );
    EasyLoading.showToast('操作成功');
  }

  // 申请删除
  static Future<void> applyDelete(String applyId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/manager/applyDelete/$applyId',
    );
    EasyLoading.showToast('操作成功');
  }
}

class GroupModel01 {
  String applyId;
  String nickname;
  String portrait;
  String groupName;
  String status;
  String remark;

  GroupModel01(
    this.applyId,
    this.nickname,
    this.portrait,
    this.groupName,
    this.status,
    this.remark,
  );

  factory GroupModel01.fromJson(Map<String, dynamic>? data) {
    return GroupModel01(
      data?['applyId'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['groupName'] ?? '',
      data?['status'] ?? '',
      data?['remark'] ?? '',
    );
  }
}

class GroupModel02 {
  // 用户ID
  String userId;
  // 用户号码
  String userNo;
  // 用户昵称
  String nickname;
  // 用户头像
  String portrait;
  // 禁言时间
  String speakTime;
  // 成员类型
  MemberType memberType;

  GroupModel02(
    this.userId,
    this.userNo,
    this.nickname,
    this.portrait,
    this.speakTime,
    this.memberType,
  );

  factory GroupModel02.fromJson(Map<String, dynamic>? data) {
    return GroupModel02(
      data?['userId'] ?? '',
      data?['userNo'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['speakTimeLabel'] ?? '',
      MemberType.init(data?['memberType'] ?? ''),
    );
  }
}

class GroupModel03 {
  // 群聊ID
  String groupId;
  // 群聊名称
  String groupName;
  // 群聊号码
  String groupNo;
  // 群聊头像
  String portrait;
  // 群聊来源
  String source;
  // 群聊审核
  String configAudit;
  // 群聊成员
  bool isMember;

  GroupModel03(
    this.groupId,
    this.groupName,
    this.groupNo,
    this.portrait,
    this.source,
    this.configAudit,
    this.isMember,
  );

  factory GroupModel03.fromJson(Map<String, dynamic> data) {
    return GroupModel03(
      data['groupId'] ?? '',
      data['groupName'] ?? '',
      data['groupNo'] ?? '',
      data['portrait'] ?? '',
      data['source'] ?? '',
      data['configAudit'] ?? '',
      'Y' == data['isMember'],
    );
  }
}

class GroupModel04 {
  // 级别
  int level;
  // 数量
  String amount;
  // 扩展
  String extend;
  // 人数
  int count;
  // 剩余
  int between;
  // 描述
  String remark;

  GroupModel04(
    this.level,
    this.amount,
    this.extend,
    this.count,
    this.between,
    this.remark,
  );

  factory GroupModel04.fromJson(Map<String, dynamic>? data) {
    return GroupModel04(
      data?['level'] ?? '',
      data?['amount'] ?? '',
      data?['extendLabel'] ?? '',
      data?['count'] ?? '',
      data?['between'] ?? '',
      data?['remark'] ?? '',
    );
  }
}
