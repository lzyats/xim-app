import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_comment.dart'; // 假设数据模型文件路径
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/config/app_config.dart';

// 朋友圈接口
class RequestMoment {
  static String get _prefix => AppConfig.commentHost;

  // 获取朋友圈列表
  static Future<List<MomentModel>> getMomentList(
      int pageNum, int pageSize) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    print('当前用户ID：' + userId);

    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/t.php',
      pageNum,
      data: {'user_id': userId, 'page': pageNum, 'page_size': pageSize},
      pageSize: pageSize,
    );

    // 转换
    return ajaxData.getList((data) => MomentModel.fromJson(data));
  }

  // 发布朋友圈
  static Future<void> postMoment(String content, List<String> images) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    // 执行
    await ToolsRequest().post(
      '$_prefix/post',
      data: {
        'user_id': userId,
        'content': content,
        'images': images,
      },
    );
  }

  // 点赞朋友圈
  static Future<void> likeMoment(String momentId) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    // 执行
    await ToolsRequest().post(
      '$_prefix/like',
      data: {
        'user_id': userId,
        'momentId': momentId,
      },
    );
  }

  // 评论朋友圈
  static Future<void> commentMoment(String momentId, String content,
      {String? replyToUserId}) async {
    // 获取当前用户的 user_id
    String userId = ToolsStorage().local().userId;

    // 执行
    await ToolsRequest().post(
      '$_prefix/comment',
      data: {
        'user_id': userId,
        'momentId': momentId,
        'content': content,
        'replyToUserId': replyToUserId,
      },
    );
  }
}
