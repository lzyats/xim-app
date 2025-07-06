// 好友接口

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

class RequestFriend {
  static String get _prefix => '/friend';

  // 搜索好友
  static Future<FriendModel01> search(String param) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/search/$param',
    );
    // 转换
    return ajaxData.getData((data) => FriendModel01.fromJson(data));
  }

  // 好友列表
  static Future<List<ChatFriend>> getFriendList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getFriendList',
      showError: false,
    );
    // 转换
    List<ChatFriend> dataList = ajaxData.getList((data) {
      ChatFriend friend = ChatFriend.fromJson(data);
      ToolsStorage().top(friend.userId, value: friend.top);
      ToolsStorage().disturb(friend.userId, value: friend.disturb);
      ToolsStorage().remark(friend.userId, value: friend.remark);
      return friend;
    });
    // 存储
    await ToolsSqlite().friend.addBatch(dataList);
    // 通知
    EventSetting().event.add(SettingModel(SettingType.friend));
    return dataList;
  }

  // 好友详情
  static Future<ChatFriend?> getInfo(String userId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getInfo/$userId',
    );
    // 转换
    return ajaxData.getData((data) {
      if (data == null) {
        return null;
      }
      ChatFriend friend = ChatFriend.fromJson(data);
      ToolsStorage().top(friend.userId, value: friend.top);
      ToolsStorage().disturb(friend.userId, value: friend.disturb);
      ToolsStorage().remark(friend.userId, value: friend.remark);
      return friend;
    });
  }

  // 申请好友
  static Future<void> apply(
    String userId,
    FriendSource source,
    String reason,
    String remark,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/apply',
      data: {
        'userId': userId,
        'source': source.value,
        'reason': reason,
        'remark': remark
      },
    );
    EasyLoading.showToast('申请成功');
  }

  // 好友审批
  static Future<List<FriendModel02>> applyList(int pageNum) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/applyList',
      pageNum,
    );
    // 转换
    return ajaxData.getList((data) => FriendModel02.fromJson(data));
  }

  // 申请同意
  static Future<void> applyAgree(String applyId, String remark) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/applyAgree',
      data: {
        'applyId': applyId,
        'remark': remark,
      },
    );
    EasyLoading.showToast('操作成功');
  }

  // 申请拒绝
  static Future<void> applyReject(String applyId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/applyReject/$applyId',
    );
    EasyLoading.showToast('操作成功');
  }

  // 申请删除
  static Future<void> applyDelete(String applyId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/applyDelete/$applyId',
    );
    EasyLoading.showToast('操作成功');
  }

  // 好友举报
  static Future<void> inform(String informType, String userId,
      List<String> images, String content) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/inform',
      data: {
        "informType": informType,
        "userId": userId,
        "images": images,
        "content": content,
      },
    );
    EasyLoading.showToast('操作成功');
  }

  // 好友备注
  static Future<void> setRemark(String userId, String remark) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setRemark',
      data: {
        "userId": userId,
        "remark": remark,
      },
    );
    // 存储
    ToolsStorage().remark(userId, value: remark);
    EasyLoading.showToast('操作成功');
  }

  // 好友拉黑
  static Future<void> setBlack(String userId, String black) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setBlack',
      data: {
        "userId": userId,
        "black": black,
      },
    );
  }

  // 好友置顶
  static Future<void> setTop(String userId, String top) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setTop',
      data: {
        "userId": userId,
        "top": top,
      },
    );
    ToolsStorage().top(userId, value: top);
  }

  // 好友静默
  static Future<void> setDisturb(String userId, String disturb) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setDisturb',
      data: {
        "userId": userId,
        "disturb": disturb,
      },
    );
    ToolsStorage().disturb(userId, value: disturb);
  }

  // 好友删除
  static Future<void> delFriend(String userId) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/delFriend',
      data: {
        "userId": userId,
      },
    );
    ToolsStorage().top(userId);
    ToolsStorage().disturb(userId);
    ToolsStorage().remark(userId);
    ToolsStorage().draft(userId);
    ToolsStorage().reply(userId);
    EasyLoading.showToast('操作成功');
  }
}

class FriendModel01 {
  String userId;
  String nickname;
  String userNo;
  String portrait;
  FriendSource source;

  FriendModel01(
    this.userId,
    this.nickname,
    this.userNo,
    this.portrait,
    this.source,
  );

  factory FriendModel01.fromJson(Map<String, dynamic> data) {
    return FriendModel01(
      data['userId'] ?? '',
      data['nickname'] ?? '',
      data['userNo'] ?? '',
      data['portrait'] ?? '',
      FriendSource.init(data['source'] ?? ''),
    );
  }
}

class FriendModel02 {
  String applyId;
  String nickname;
  String portrait;
  String reason;
  String status;
  String remark;

  FriendModel02(
    this.applyId,
    this.nickname,
    this.portrait,
    this.reason,
    this.status,
    this.remark,
  );

  factory FriendModel02.fromJson(Map<String, dynamic>? data) {
    return FriendModel02(
      data?['applyId'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['reason'] ?? '',
      data?['status'] ?? '',
      data?['remark'] ?? '',
    );
  }
}
