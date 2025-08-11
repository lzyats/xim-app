// 消息总线
import 'dart:async';
import 'dart:convert';

import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:uuid/uuid.dart';

// 监听朋友圈消息
class EventMoment {
  EventMoment._();
  static EventMoment? _singleton;
  factory EventMoment() => _singleton ??= EventMoment._();

  // 动态消息流
  final StreamController<Moment> listenMoment = StreamController.broadcast();

  // 处理接收到的朋友圈消息
  Future<void> handle(bool pushAudio, Map<String, dynamic> pushData) async {
    print("收到新动态:" + pushData.toString());
    // 组装动态对象
    Moment? moment = _initMoment(pushData);
    if (moment == null) {
      return;
    }
    // 插入数据库
    await ToolsSqlite().moment.add(moment); // 假设数据库有对应的moment表操作
    // 广播动态消息
    listenMoment.add(moment);
    // 假设存在验证动态ID的方法
  }

  // 处理离线动态
  Future<void> addBatch(List<Map<String, dynamic>> dataList) async {
    if (dataList.isNotEmpty) {
      List<Moment> momentList = [];
      String requestId = const Uuid().v8();
      for (var pushData in dataList) {
        Moment? moment = _initMoment(pushData);
        if (moment == null) {
          continue;
        }
        // 处理删除动态
        if (moment.isDeleted == 'Y') {
          _deleteMoment(moment.momentId);
          continue;
        }
        momentList.add(moment);
      }
      // 批量插入
      await ToolsSqlite().moment.addBatch(momentList); // 假设存在批量插入方法
    }
  }

  // 组装Moment对象
  Moment? _initMoment(Map<String, dynamic> pushData) {
    // 准备工作
    LocalUser localUser = ToolsStorage().local();
    Map<String, dynamic> source = pushData['source'];
    String sign = source['sign'] ?? '';
    // 同步消息
    if (localUser.sign == sign) {
      //return null;
    }
    try {
      return Moment(
        momentId: pushData['momentId']?.toString() ?? '', // 关键修复：int转String
        msgId: pushData['msgId']?.toString() ?? '', // 关键修复：int转String
        userId: pushData['userId']?.toString() ?? '', // 关键修复：int转String
        content: pushData['content'] ?? '',
        location: pushData['location'] ?? '',
        visibility: pushData['visibility'] ?? '0',
        portrait: pushData['portrait'] ?? '',
        nickname: pushData['nickname'] ?? '',
        createTime: () {
          // 先尝试将createTime转为整数（时间戳）
          final int? timestamp = pushData['createTime'] is int
              ? pushData['createTime']
              : (pushData['createTime']?.toString().isNotEmpty ?? false
                  ? int.tryParse(pushData['createTime'].toString())
                  : null);
          // 若时间戳有效，则转为DateTime字符串；否则用空字符串兜底
          return timestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(timestamp).toString()
              : '';
        }(),
        isDeleted: pushData['isDeleted'] ?? 'N',
        visuser: pushData['visuser'] != null
            ? jsonEncode(pushData['visuser'])
            : '[]',
        images:
            pushData['images'] != null ? jsonEncode(pushData['images']) : '[]',
        comments: pushData['comments'] != null
            ? jsonEncode(pushData['comments'])
            : '[]',
        likes: pushData['likes'] != null ? jsonEncode(pushData['likes']) : '[]',
      );
    } catch (e) {
      print("组装动态失败: $e");
      return null;
    }
  }

  // 处理动态删除
  void _deleteMoment(String momentId) {
    // 实现删除动态的逻辑，如从数据库移除
    ToolsSqlite().moment.delete(momentId); // 假设存在删除方法
  }

  // 处理动态相关操作（如点赞、评论）
  Future<void> handleMomentAction(Map<String, dynamic> actionData) async {
    String actionType = actionData['actionType']; // like, comment, delete等
    String momentId = actionData['momentId'];

    switch (actionType) {
      case 'like':
        await _handleLike(momentId, actionData['userId']);
        break;
      case 'comment':
        await _handleComment(momentId, actionData['comment']);
        break;
      case 'delete':
        await _handleDelete(momentId);
        break;
    }
  }

  // 处理点赞
  Future<void> _handleLike(String momentId, String userId) async {
    Moment? moment = await ToolsSqlite().moment.getById(momentId);
    if (moment != null) {
      List<Map<String, dynamic>> likes = moment.getLikesList();
      likes.add({
        'userId': userId,
        'time': DateTime.now().millisecondsSinceEpoch.toString()
      });
      moment.likes = jsonEncode(likes);
      await ToolsSqlite().moment.update(moment);
      listenMoment.add(moment); // 广播更新
    }
  }

  // 处理评论
  Future<void> _handleComment(
      String momentId, Map<String, dynamic> comment) async {
    Moment? moment = await ToolsSqlite().moment.getById(momentId);
    if (moment != null) {
      List<Map<String, dynamic>> comments = moment.getCommentsList();
      comments.add(comment);
      moment.comments = jsonEncode(comments);
      await ToolsSqlite().moment.update(moment);
      listenMoment.add(moment); // 广播更新
    }
  }

  // 处理删除
  Future<void> _handleDelete(String momentId) async {
    Moment? moment = await ToolsSqlite().moment.getById(momentId);
    if (moment != null) {
      moment.isDeleted = 'Y';
      await ToolsSqlite().moment.update(moment);
      listenMoment.add(moment); // 广播更新
    }
  }
}
