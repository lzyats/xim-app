import 'dart:ffi';

import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_comment.dart'; // 假设数据模型文件路径
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';

// 朋友圈接口
class RequestMoment {
  static String get _prefix => '/friend/moments';

  // 获取朋友圈列表
  static Future<dynamic> getMomentList(int pageNum, int pageSize) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getlist/$userId',
      param: {
        'pageNum': pageNum,
        'pageSize': pageSize,
      },
    );
    // 转换
    return ajaxData.result['data'];
  }

  // 发布朋友圈
  static Future<dynamic> postMoment(String content, List<String> images) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/post',
      data: {
        'user_id': userId,
        'content': content,
        'images': images,
      },
    );
    return ajaxData.result['code'];
  }

  // 点赞朋友圈
  static Future<dynamic> likeMoment(int momentId) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/addlike',
      data: {
        'userId': userId,
        'momentId': momentId,
      },
    );
    return ajaxData.result['code'];
  }

  // 评论朋友圈
  static Future<dynamic> addComment(
    int momentId,
    int replyTo,
    String content,
  ) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/comment',
      data: {
        'userId': userId,
        'momentId': momentId,
        'content': content,
        'replyTo': replyTo,
      },
    );
    return ajaxData.result['code'];
  }

  // 定义 postComment 方法
  static Future<void> postComment(
      String momentId, String commentContent) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/postComment',
      data: {
        "momentId": momentId,
        "commentContent": commentContent,
      },
    );
    // 可以添加提示信息
    EasyLoading.showToast('评论发布成功');
  }
}
