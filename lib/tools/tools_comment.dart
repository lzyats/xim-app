// package:alpaca/tools/tools_comment.dart
class MomentModel {
  final String momentId; // 朋友圈ID
  final String userId; // 发布用户ID
  final String content; // 内容
  final String createTime; // 创建时间
  final String status; // 状态：0-正常，1-删除
  final int likeCount; // 点赞数
  final int commentCount; // 评论数
  final bool isLiked; // 当前用户是否已点赞

  // 用户信息（关联查询）
  final String userName; // 用户名
  final String userAvatar; // 用户头像

  // 媒体资源列表
  final List<MediaResourceModel> mediaResources;

  // 评论列表
  final List<CommentModel> comments;

  factory MomentModel.fromJson(Map<String, dynamic> data) {
    // 安全解析媒体资源列表
    final mediaResources = _safeParseList(
        data['media_resources'], (item) => MediaResourceModel.fromJson(item));

    // 安全解析评论列表
    final comments =
        _safeParseList(data['comments'], (item) => CommentModel.fromJson(item));

    return MomentModel._(
      momentId: _safeParseString(data['moment_id']),
      userId: _safeParseString(data['user_id']),
      content: _safeParseString(data['content']),
      createTime: _safeParseString(data['create_time']),
      status: _safeParseString(data['status']),
      likeCount: _safeParseInt(data['like_count']),
      commentCount: _safeParseInt(data['comment_count']),
      isLiked: _safeParseBool(data['is_liked']),
      userName: _safeParseString(data['user_name']),
      userAvatar: _safeParseString(data['user_avatar']),
      mediaResources: mediaResources,
      comments: comments,
    );
  }

  // 私有构造函数
  MomentModel._({
    required this.momentId,
    required this.userId,
    required this.content,
    required this.createTime,
    required this.status,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    required this.userName,
    required this.userAvatar,
    required this.mediaResources,
    required this.comments,
  });

  // 添加 copyWith 方法
  MomentModel copyWith({
    String? momentId,
    String? userId,
    String? content,
    String? createTime,
    String? status,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
    String? userName,
    String? userAvatar,
    List<MediaResourceModel>? mediaResources,
    List<CommentModel>? comments,
  }) {
    return MomentModel._(
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      status: status ?? this.status,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      mediaResources: mediaResources ?? this.mediaResources,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moment_id': momentId,
      'user_id': userId,
      'content': content,
      'create_time': createTime,
      'status': status,
      'like_count': likeCount,
      'comment_count': commentCount,
      'is_liked': isLiked,
      'user_name': userName,
      'user_avatar': userAvatar,
      'media_resources':
          mediaResources.map((resource) => resource.toJson()).toList(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  // 静态安全解析工具方法
  static String _safeParseString(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    return value.toString();
  }

  static int _safeParseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is double) return value.toInt();
    return 0;
  }

  static bool _safeParseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    if (value is int) return value == 1;
    return false;
  }

  static List<T> _safeParseList<T>(
      dynamic value, T Function(dynamic) converter) {
    if (value == null) return [];
    if (value is! List) return [];
    return value.map(converter).whereType<T>().toList();
  }
}

class CommentModel {
  final String commentId; // 评论ID
  final String momentId; // 朋友圈ID
  final String userId; // 评论用户ID
  final String content; // 评论内容
  final String createTime; // 创建时间
  final String status; // 状态：0-正常，1-删除
  final int likeCount; // 点赞数
  final bool isLiked; // 当前用户是否已点赞

  // 用户信息（关联查询）
  final String userName; // 用户名
  final String userAvatar; // 用户头像

  // 回复信息
  final String? replyToUserId; // 回复用户ID
  final String? replyToUserName; // 回复用户名

  factory CommentModel.fromJson(Map<String, dynamic> data) {
    return CommentModel._(
      commentId: MomentModel._safeParseString(data['comment_id']),
      momentId: MomentModel._safeParseString(data['moment_id']),
      userId: MomentModel._safeParseString(data['user_id']),
      content: MomentModel._safeParseString(data['content']),
      createTime: MomentModel._safeParseString(data['create_time']),
      status: MomentModel._safeParseString(data['status']),
      likeCount: MomentModel._safeParseInt(data['like_count']),
      isLiked: MomentModel._safeParseBool(data['is_liked']),
      userName: MomentModel._safeParseString(data['user_name']),
      userAvatar: MomentModel._safeParseString(data['user_avatar']),
      replyToUserId: MomentModel._safeParseString(data['reply_to_user_id']),
      replyToUserName: MomentModel._safeParseString(data['reply_to_user_name']),
    );
  }

  // 私有构造函数
  CommentModel._({
    required this.commentId,
    required this.momentId,
    required this.userId,
    required this.content,
    required this.createTime,
    required this.status,
    required this.likeCount,
    required this.isLiked,
    required this.userName,
    required this.userAvatar,
    this.replyToUserId,
    this.replyToUserName,
  });

  // 添加 copyWith 方法
  CommentModel copyWith({
    String? commentId,
    String? momentId,
    String? userId,
    String? content,
    String? createTime,
    String? status,
    int? likeCount,
    bool? isLiked,
    String? userName,
    String? userAvatar,
    String? replyToUserId,
    String? replyToUserName,
  }) {
    return CommentModel._(
      commentId: commentId ?? this.commentId,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      status: status ?? this.status,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      replyToUserId: replyToUserId ?? this.replyToUserId,
      replyToUserName: replyToUserName ?? this.replyToUserName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'moment_id': momentId,
      'user_id': userId,
      'content': content,
      'create_time': createTime,
      'status': status,
      'like_count': likeCount,
      'is_liked': isLiked,
      'user_name': userName,
      'user_avatar': userAvatar,
      'reply_to_user_id': replyToUserId,
      'reply_to_user_name': replyToUserName,
    };
  }
}

class LikeModel {
  final String likeId; // 点赞ID
  final String momentId; // 朋友圈ID
  final String userId; // 用户ID
  final String createTime; // 创建时间

  factory LikeModel.fromJson(Map<String, dynamic> data) {
    return LikeModel._(
      likeId: MomentModel._safeParseString(data['like_id']),
      momentId: MomentModel._safeParseString(data['moment_id']),
      userId: MomentModel._safeParseString(data['user_id']),
      createTime: MomentModel._safeParseString(data['create_time']),
    );
  }

  // 私有构造函数
  LikeModel._({
    required this.likeId,
    required this.momentId,
    required this.userId,
    required this.createTime,
  });

  // 添加 copyWith 方法
  LikeModel copyWith({
    String? likeId,
    String? momentId,
    String? userId,
    String? createTime,
  }) {
    return LikeModel._(
      likeId: likeId ?? this.likeId,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      createTime: createTime ?? this.createTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'like_id': likeId,
      'moment_id': momentId,
      'user_id': userId,
      'create_time': createTime,
    };
  }
}

class MediaResourceModel {
  final String resourceId; // 资源ID
  final String momentId; // 朋友圈ID
  final String resourceType; // 资源类型：1-图片，2-视频，3-音频
  final String url; // 资源URL
  final String thumbnailUrl; // 缩略图URL（图片/视频）
  final int sortOrder; // 排序序号
  final String createTime; // 创建时间

  factory MediaResourceModel.fromJson(Map<String, dynamic> data) {
    return MediaResourceModel._(
      resourceId: MomentModel._safeParseString(data['resource_id']),
      momentId: MomentModel._safeParseString(data['moment_id']),
      resourceType: MomentModel._safeParseString(data['resource_type']),
      url: MomentModel._safeParseString(data['url']),
      thumbnailUrl: MomentModel._safeParseString(data['thumbnail_url']),
      sortOrder: MomentModel._safeParseInt(data['sort_order']),
      createTime: MomentModel._safeParseString(data['create_time']),
    );
  }

  // 私有构造函数
  MediaResourceModel._({
    required this.resourceId,
    required this.momentId,
    required this.resourceType,
    required this.url,
    required this.thumbnailUrl,
    required this.sortOrder,
    required this.createTime,
  });

  // 添加 copyWith 方法
  MediaResourceModel copyWith({
    String? resourceId,
    String? momentId,
    String? resourceType,
    String? url,
    String? thumbnailUrl,
    int? sortOrder,
    String? createTime,
  }) {
    return MediaResourceModel._(
      resourceId: resourceId ?? this.resourceId,
      momentId: momentId ?? this.momentId,
      resourceType: resourceType ?? this.resourceType,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      sortOrder: sortOrder ?? this.sortOrder,
      createTime: createTime ?? this.createTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resource_id': resourceId,
      'moment_id': momentId,
      'resource_type': resourceType,
      'url': url,
      'thumbnail_url': thumbnailUrl,
      'sort_order': sortOrder,
      'create_time': createTime,
    };
  }
}
