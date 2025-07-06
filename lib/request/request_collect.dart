// 收藏接口
import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_submit.dart';

class RequestCollect {
  static String get _prefix => '/collect';

  // 列表
  static Future<List<CollectModel>> list(int pageNum, MsgType? msgType) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/list',
      pageNum,
      data: {
        "msgType": msgType == null ? '' : msgType.value,
      },
    );
    // 转换
    return ajaxData.getList((data) => CollectModel.fromJson(data));
  }

  // 新增
  static Future<void> add(MsgType msgType, Map<String, dynamic> content) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/add',
      data: {
        "msgType": msgType.value,
        "content": content,
      },
    );
    // 取消
    ToolsSubmit.cancel();
    // 取消
    EasyLoading.showToast('收藏成功');
  }

  // 删除
  static Future<void> remove(String id) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/remove/$id',
    );
  }
}

class CollectModel {
  String collectId;
  MsgType msgType;
  Map<String, dynamic> content;
  String createTime;

  CollectModel(
    this.collectId,
    this.msgType,
    this.content,
    this.createTime,
  );

  factory CollectModel.fromJson(Map<String, dynamic>? data) {
    return CollectModel(
      data?['collectId'] ?? '',
      MsgType.init(data?['msgType']),
      jsonDecode(data?['content']) ?? {},
      data?['createTime'] ?? '',
    );
  }
}
