// package:alpaca/tools/tools_comment.dart
/// 朋友圈动态模型
class FriendMomentModel {
  final int momentId; // 动态ID
  final int userId; // 发布用户ID
  final String? content; // 文字内容
  final String? location; // 位置信息
  final int visibility; // 可见性：0-公开，1-私密，2-部分可见，3-不给谁看
  final DateTime createTime; // 创建时间
  final DateTime updateTime; // 更新时间
  final int isDeleted; // 逻辑删除标记

  FriendMomentModel({
    required this.momentId,
    required this.userId,
    this.content,
    this.location,
    required this.visibility,
    required this.createTime,
    required this.updateTime,
    required this.isDeleted,
  });

  // 从JSON创建实例
  factory FriendMomentModel.fromJson(Map<String, dynamic> json) {
    return FriendMomentModel(
      momentId: json['moment_id'],
      userId: json['user_id'],
      content: json['content'],
      location: json['location'],
      visibility: json['visibility'],
      createTime: DateTime.parse(json['create_time']),
      updateTime: DateTime.parse(json['update_time']),
      isDeleted: json['is_deleted'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'moment_id': momentId,
      'user_id': userId,
      'content': content,
      'location': location,
      'visibility': visibility,
      'create_time': createTime.toIso8601String(),
      'update_time': updateTime.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  // 复制实例（支持字段更新）
  FriendMomentModel copyWith({
    int? momentId,
    int? userId,
    String? content,
    String? location,
    int? visibility,
    DateTime? createTime,
    DateTime? updateTime,
    int? isDeleted,
  }) {
    return FriendMomentModel(
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      location: location ?? this.location,
      visibility: visibility ?? this.visibility,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

/// 朋友圈评论模型
class FriendCommentModel {
  final int? commentId; // 评论ID（改为可选）
  final int? momentId; // 关联动态ID（改为可选）
  final int? userId; // 评论用户ID（改为可选）
  final int? replyTo; // 回复的评论ID（可为空）
  final String content; // 评论内容（保持必填）
  final DateTime? createTime; // 创建时间（改为可选）
  final int isDeleted; // 逻辑删除标记（根据需求调整）

  final String fromUser; // 评论者
  final String? toUser; // 被评论者（可为空）

  FriendCommentModel({
    this.commentId, // 改为可选
    this.momentId, // 改为可选
    this.userId, // 改为可选
    this.replyTo,
    required this.content, // 保持必填
    this.createTime, // 改为可选
    this.isDeleted = 0, // 设置默认值
    required this.fromUser,
    this.toUser,
  });

  // 从JSON创建实例
  factory FriendCommentModel.fromJson(Map<String, dynamic> json) {
    return FriendCommentModel(
      commentId: json['comment_id'], // 直接读取，可为null
      momentId: json['moment_id'],
      userId: json['user_id'],
      replyTo: json['reply_to'],
      content: json['content'],
      createTime: json['create_time'] != null
          ? DateTime.parse(json['create_time'])
          : null, // 可选时间解析
      isDeleted: json['is_deleted'] ?? 0, // 设置默认值
      fromUser: json['from_user'],
      toUser: json['to_user'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      if (commentId != null) 'comment_id': commentId, // 仅当非null时包含
      if (momentId != null) 'moment_id': momentId,
      if (userId != null) 'user_id': userId,
      'reply_to': replyTo,
      'content': content,
      if (createTime != null) 'create_time': createTime?.toIso8601String(),
      'is_deleted': isDeleted,
      'from_user': fromUser,
      'to_user': toUser,
    };
  }

  // 复制实例（支持字段更新）
  FriendCommentModel copyWith({
    int? commentId,
    int? momentId,
    int? userId,
    int? replyTo,
    String? content,
    DateTime? createTime,
    int? isDeleted,
    String? fromUser,
    String? toUser,
  }) {
    return FriendCommentModel(
      commentId: commentId ?? this.commentId,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      replyTo: replyTo ?? this.replyTo,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      isDeleted: isDeleted ?? this.isDeleted,
      fromUser: fromUser ?? this.fromUser,
      toUser: toUser ?? this.toUser,
    );
  }
}

/// 朋友圈媒体资源模型
class FriendMediaResourceModel {
  final int mediaId; // 媒体资源ID
  final int momentId; // 关联动态ID
  final String url; // 资源URL
  final int type; // 类型：0-图片，1-视频，2-音频
  final int sortOrder; // 排序顺序
  final int width; // 宽度（图片/视频）
  final int height; // 高度（图片/视频）
  final int duration; // 时长（视频/音频，单位：秒）
  final DateTime createTime; // 创建时间

  FriendMediaResourceModel({
    required this.mediaId,
    required this.momentId,
    required this.url,
    required this.type,
    required this.sortOrder,
    required this.width,
    required this.height,
    required this.duration,
    required this.createTime,
  });

  // 从JSON创建实例
  factory FriendMediaResourceModel.fromJson(Map<String, dynamic> json) {
    return FriendMediaResourceModel(
      mediaId: json['media_id'],
      momentId: json['moment_id'],
      url: json['url'],
      type: json['type'],
      sortOrder: json['sort_order'],
      width: json['width'],
      height: json['height'],
      duration: json['duration'],
      createTime: DateTime.parse(json['create_time']),
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'media_id': mediaId,
      'moment_id': momentId,
      'url': url,
      'type': type,
      'sort_order': sortOrder,
      'width': width,
      'height': height,
      'duration': duration,
      'create_time': createTime.toIso8601String(),
    };
  }

  // 复制实例（支持字段更新）
  FriendMediaResourceModel copyWith({
    int? mediaId,
    int? momentId,
    String? url,
    int? type,
    int? sortOrder,
    int? width,
    int? height,
    int? duration,
    DateTime? createTime,
  }) {
    return FriendMediaResourceModel(
      mediaId: mediaId ?? this.mediaId,
      momentId: momentId ?? this.momentId,
      url: url ?? this.url,
      type: type ?? this.type,
      sortOrder: sortOrder ?? this.sortOrder,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      createTime: createTime ?? this.createTime,
    );
  }
}

/// 朋友圈点赞模型
class FriendLikeModel {
  final int likeId; // 点赞ID
  final int momentId; // 关联动态ID
  final int userId; // 点赞用户ID
  final DateTime createTime; // 创建时间
  final int isDeleted; // 逻辑删除标记

  FriendLikeModel({
    required this.likeId,
    required this.momentId,
    required this.userId,
    required this.createTime,
    required this.isDeleted,
  });

  // 从JSON创建实例
  factory FriendLikeModel.fromJson(Map<String, dynamic> json) {
    return FriendLikeModel(
      likeId: json['like_id'],
      momentId: json['moment_id'],
      userId: json['user_id'],
      createTime: DateTime.parse(json['create_time']),
      isDeleted: json['is_deleted'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'like_id': likeId,
      'moment_id': momentId,
      'user_id': userId,
      'create_time': createTime.toIso8601String(),
      'is_deleted': isDeleted,
    };
  }

  // 复制实例（支持字段更新）
  FriendLikeModel copyWith({
    int? likeId,
    int? momentId,
    int? userId,
    DateTime? createTime,
    int? isDeleted,
  }) {
    return FriendLikeModel(
      likeId: likeId ?? this.likeId,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      createTime: createTime ?? this.createTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

/// 新添加的 Moment 类模型
class MomentModel {
  final int momentId; // 动态ID
  final int userId; // 用户ID
  final String portrait; // 用户头像
  final String nickname; // 用户昵称
  final String content; // 动态正文
  final String createTime; // 发布时间（改为字符串类型）
  final List<String> images; // 图片列表
  final List<FriendCommentModel> comments; // 评论内容
  final List<String> likes; // 点赞列表

  MomentModel({
    required this.momentId,
    required this.userId,
    required this.portrait,
    required this.nickname,
    required this.content,
    required this.createTime, // 字符串类型
    required this.images,
    required this.comments,
    required this.likes,
  });

  // 从JSON创建实例
  factory MomentModel.fromJson(Map<String, dynamic> json) {
    return MomentModel(
      momentId: json['momentId'],
      userId: json['userId'],
      portrait: json['portrait'],
      nickname: json['nickname'],
      content: json['content'],
      createTime: json['createTime'].toString(), // 直接转为字符串
      images: List<String>.from(json['images']),
      comments: (json['comments'] as List<dynamic>)
          .map((comment) => FriendCommentModel.fromJson(comment))
          .toList(),
      likes: List<String>.from(json['likes']),
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'momentId': momentId,
      'userId': userId,
      'portrait': portrait,
      'nickname': nickname,
      'content': content,
      'createTime': createTime, // 直接序列化字符串
      'images': images,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likes': likes,
    };
  }

  // 复制实例（支持字段更新）
  MomentModel copyWith({
    int? momentId,
    int? userId,
    String? portrait,
    String? nickname,
    String? content,
    String? createTime, // 字符串类型参数
    List<String>? images,
    List<FriendCommentModel>? comments,
    List<String>? likes,
  }) {
    return MomentModel(
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      portrait: portrait ?? this.portrait,
      nickname: nickname ?? this.nickname,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      images: images ?? this.images,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }
}
