import 'package:dio/dio.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_comment.dart'; // 引入数据模型

class MomentApiService {
  static final String baseUrl = AppConfig.commentHost;
  final Dio _dio = Dio();

  // 1. 获取朋友圈列表（必须传入user_id、page、page_size）
  /// [userId]：当前用户ID（用于权限校验）
  /// [page]：页码（从1开始）
  /// [pageSize]：每页条数
  Future<List<Moment>> getMomentList({
    required String userId, // 强制传入当前用户ID
    required int page, // 强制传入分页码
    int pageSize = 10, // 每页条数，默认10
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/moments',
        queryParameters: {
          'user_id': userId, // 与数据库字段user_id对应
          'page': page, // 分页码
          'page_size': pageSize, // 每页条数
        },
      );
      // 解析响应数据（与数据表字段映射）
      List<dynamic> dataList = response.data['data']['list'];
      return dataList.map((json) => Moment.fromJson(json)).toList();
    } catch (e) {
      throw Exception('获取朋友圈列表失败：$e');
    }
  }

  // 2. 点赞朋友圈（必须传入user_id、moment_id）
  /// [userId]：点赞用户ID
  /// [momentId]：朋友圈ID
  Future<void> likeMoment({
    required String userId, // 与数据表likes.user_id对应
    required int momentId, // 与数据表likes.moment_id对应
  }) async {
    try {
      await _dio.post(
        '$baseUrl/moments/like',
        data: {
          'user_id': userId,
          'moment_id': momentId,
        },
      );
    } catch (e) {
      throw Exception('点赞失败：$e');
    }
  }

  // 3. 评论朋友圈（必须传入user_id、moment_id、content）
  /// [userId]：评论用户ID
  /// [momentId]：朋友圈ID
  /// [content]：评论内容
  Future<void> addComment({
    required String userId, // 与数据表comments.user_id对应
    required int momentId, // 与数据表comments.moment_id对应
    required String content, // 与数据表comments.content对应
  }) async {
    try {
      await _dio.post(
        '$baseUrl/moments/comment',
        data: {
          'user_id': userId,
          'moment_id': momentId,
          'content': content,
        },
      );
    } catch (e) {
      throw Exception('评论失败：$e');
    }
  }

  // 4. 发布朋友圈（参数与moments表字段完全对应）
  /// [userId]：发布者ID（与moments.user_id对应）
  /// [content]：内容（与moments.content对应）
  /// [images]：图片URL列表（转换为逗号分隔字符串，与moments.images对应）
  /// [location]：位置（与moments.location对应）
  /// [visibleRange]：可见范围（与moments.visible_range对应）
  Future<void> publishMoment({
    required String userId,
    required String content,
    List<String> images = const [],
    String location = '',
    required String visibleRange, // 仅支持"everyone"或"friends"
  }) async {
    try {
      await _dio.post(
        '$baseUrl/moments/publish',
        data: {
          'user_id': userId,
          'content': content,
          'images': images.join(','), // 转换为逗号分隔字符串，匹配数据库存储格式
          'location': location,
          'visible_range': visibleRange, // 与数据表moments.visible_range对应
        },
      );
    } catch (e) {
      throw Exception('发布朋友圈失败：$e');
    }
  }

  // 5. 获取单条朋友圈详情（用于刷新评论/点赞状态）
  /// [userId]：当前用户ID
  /// [momentId]：朋友圈ID
  /// [page]：评论分页页码
  Future<Moment> getMomentDetail({
    required String userId,
    required int momentId,
    required int page, // 评论分页码
    int pageSize = 20,
  }) async {
    try {
      final response = await _dio.get(
        '$baseUrl/moments/detail',
        queryParameters: {
          'user_id': userId,
          'moment_id': momentId,
          'page': page,
          'page_size': pageSize,
        },
      );
      return Moment.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('获取朋友圈详情失败：$e');
    }
  }
}
