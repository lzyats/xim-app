// package:alpaca/tools/tools_comment.dart
/// 朋友圈动态模型
class FriendMomentModel {
  final int? momentId; // 动态ID
  final int userId; // 发布用户ID
  final String? content; // 文字内容
  final String? location; // 位置信息
  final int visibility; // 可见性：0-公开，1-私密，2-部分可见，3-不给谁看
  final DateTime createTime; // 创建时间
  final DateTime? updateTime; // 更新时间
  final int? isDeleted; // 逻辑删除标记
  // 新增字段：非必需的momId
  final int? momId; // 动态额外ID（非必需）

  FriendMomentModel({
    this.momentId,
    required this.userId,
    this.content,
    this.location,
    required this.visibility,
    required this.createTime,
    this.updateTime,
    this.isDeleted,
    // 新增momId参数，默认值为null
    this.momId,
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
      // 解析mom_id字段（JSON中为下划线命名）
      momId: json['mom_id'],
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
      'update_time': updateTime ?? DateTime.now().toIso8601String(),
      'is_deleted': isDeleted,
      // 转换momId为mom_id
      if (momId != null) 'mom_id': momId,
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
    int? momId,
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
      momId: momId ?? this.momId,
    );
  }
}

/// 朋友圈评论模型
/// 朋友圈评论模型
class FriendCommentModel {
  final int? commentId; // 评论ID（改为可选）
  final int? momentId; // 关联动态ID（改为可选）
  final int? userId; // 评论用户ID（改为可选）
  final int? replyTo; // 回复的评论ID（可为空）
  final String? content; // 评论内容（保持必填）
  final DateTime? createTime; // 创建时间（改为可选）
  final String? fromUser; // 评论者
  final String? toUser; // 被评论者（可为空）
  final bool? source; // 新增字段：是否为发起人，bool类型，非必填

  FriendCommentModel({
    this.commentId, // 改为可选
    this.momentId, // 改为可选
    this.userId, // 改为可选
    this.replyTo,
    this.content, // 保持必填
    this.createTime, // 改为可选
    this.fromUser,
    this.toUser,
    this.source, // 新增source参数，默认值为null
  });

  // 从JSON创建实例
  factory FriendCommentModel.fromJson(Map<String, dynamic> json) {
    return FriendCommentModel(
      commentId: json['comment_id'], // 直接读取，可为null
      momentId: json['moment_id'],
      userId: json['user_id'],
      replyTo: json['reply_to'],
      content: json['content'],
      fromUser: json['fromUser'],
      toUser: json['toUser'],
      createTime: json['create_time'] != null
          ? DateTime.parse(json['create_time'])
          : null, // 可选时间解析
      source: json['source'], // 解析source字段，JSON中为同名
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
      'from_user': fromUser,
      'to_user': toUser,
      if (source != null) 'source': source, // 仅当非null时包含
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
    String? fromUser,
    String? toUser,
    bool? source, // 新增source参数支持更新
  }) {
    return FriendCommentModel(
      commentId: commentId ?? this.commentId,
      momentId: momentId ?? this.momentId,
      userId: userId ?? this.userId,
      replyTo: replyTo ?? this.replyTo,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      fromUser: fromUser ?? this.fromUser,
      toUser: toUser ?? this.toUser,
      source: source ?? this.source, // 默认值使用原实例值
    );
  }
}

/// 朋友圈媒体资源模型
/// 朋友圈媒体资源模型
class FriendMediaResourceModel {
  final int? mediaId; // 媒体资源ID
  final int? momentId; // 关联动态ID
  final String url; // 资源URL
  final int? type; // 类型：0-图片，1-视频，2-音频
  final int? sortOrder; // 排序顺序
  final int? width; // 宽度（图片/视频）
  final int? height; // 高度（图片/视频）
  final int? duration; // 时长（视频/音频，单位：秒）
  final DateTime? createTime; // 创建时间
  final String? thumbnail; // 缩略图URL，非必需字符串参数
  final int? momId; // 新增：动态额外ID（非必需，int类型）

  FriendMediaResourceModel({
    this.mediaId,
    this.momentId,
    required this.url,
    this.type,
    this.sortOrder,
    this.width,
    this.height,
    this.duration,
    this.createTime,
    this.thumbnail,
    this.momId, // 新增参数，默认值为null
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
      createTime: json['create_time'] != null
          ? DateTime.parse(json['create_time'])
          : null,
      thumbnail: _parseString(json['thumbnail']),
      momId: json['mom_id'], // 解析JSON中的mom_id字段（下划线命名）
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
      if (createTime != null) 'create_time': createTime?.toIso8601String(),
      if (thumbnail != null) 'thumbnail': thumbnail,
      if (momId != null) 'mom_id': momId, // 仅当非null时包含mom_id字段
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
    String? thumbnail,
    int? momId, // 支持更新momId字段
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
      thumbnail: thumbnail ?? this.thumbnail,
      momId: momId ?? this.momId, // 新增字段的默认值处理
    );
  }

  // 辅助方法：解析String类型，处理null值
  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString().trim().isNotEmpty ? value.toString() : null;
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

/// 媒体资源简化模型
/// 仅包含类型和URL字段
/// 媒体资源简化模型
/// 仅包含类型、URL、宽高字段
class Media {
  final int? type; // 媒体类型：0-图片，1-视频，2-音频
  final String url; // 媒体资源URL
  final int? width; // 媒体宽度（可选）
  final int? height; // 媒体高度（可选）
  final String? thumbnail; // 新增：缩略图URL，非必需字符串

  /// 构造函数
  /// - type: 可选的媒体类型，默认null
  /// - url: 必需的资源URL
  /// - width: 可选的宽度，默认null
  /// - height: 可选的高度，默认null
  /// - thumbnail: 可选的缩略图URL，默认null
  Media({
    this.type,
    required this.url,
    this.width,
    this.height,
    this.thumbnail, // 新增字段
  });

  /// 从JSON创建实例
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      type: json['type'],
      url: json['url'] ?? '',
      width: json['width'],
      height: json['height'],
      thumbnail: json['thumbnail'], // 解析缩略图字段
    );
  }

  /// 转换为JSON格式
  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      'url': url,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (thumbnail != null) 'thumbnail': thumbnail, // 仅在非空时包含
    };
  }

  /// 复制实例（支持字段更新）
  Media copyWith({
    int? type,
    String? url,
    int? width,
    int? height,
    String? thumbnail, // 支持更新缩略图
  }) {
    return Media(
      type: type ?? this.type,
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      thumbnail: thumbnail ?? this.thumbnail, // 新增字段的默认值处理
    );
  }

  /// 重写toString方法用于调试
  @override
  String toString() {
    return 'Media(type: $type, url: $url, width: $width, height: $height, thumbnail: $thumbnail)';
  }

  /// 重写hashCode用于对象比较（包含thumbnail）
  @override
  int get hashCode => Object.hash(type, url, width, height, thumbnail);

  /// 重写equals方法用于对象相等性判断（包含thumbnail）
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Media &&
        other.type == type &&
        other.url == url &&
        other.width == width &&
        other.height == height &&
        other.thumbnail == thumbnail; // 新增字段的相等性判断
  }
}

/// 新添加的 Moment 类模型
/// 朋友圈动态模型，支持空值判断和可选字段
class MomentModel {
  final int? momentId; // 动态ID，改为可选类型
  final int? userId; // 用户ID，改为可选类型
  final String? portrait; // 用户头像，改为可选类型
  final String? nickname; // 用户昵称，改为可选类型
  final String? content; // 动态正文，改为可选类型
  final String? location; // 新增：位置信息，字符类型，可为空
  final String? createTime; // 发布时间，改为可选类型
  final List<Media>? images; // 图片列表，改为可选类型
  final List<FriendCommentModel>? comments; // 评论内容，改为可选类型
  final List<String>? likes; // 点赞列表，改为可选类型
  final int? visibility; // 新增：可见性（非必需，int类型）0-公开，1-私密，2-部分可见，3-不给谁看

  // 构造函数使用可选参数，并设置默认值
  MomentModel({
    this.momentId,
    this.userId,
    this.portrait = '', // 字符串类型设置默认空字符串
    this.nickname = '',
    this.content = '',
    this.createTime,
    this.location, // 新增字段在构造函数中声明
    this.visibility, // 新增可见性字段（非必需，无默认值）
    // 关键修改：从字符串列表改为媒体资源对象列表
    List<Media>? images,
    List<FriendCommentModel>? comments,
    List<String>? likes,
  })  : images = images ?? const [], // 列表类型设置默认空列表
        comments = comments ?? const [],
        likes = likes ?? const [];

  // 从JSON创建实例，添加全面的空值判断
  factory MomentModel.fromJson(Map<String, dynamic> json) {
    return MomentModel(
      momentId: _parseInt(json['momentId']),
      userId: _parseInt(json['userId']),
      portrait: _parseString(json['portrait']),
      nickname: _parseString(json['nickname']),
      content: _parseString(json['content']),
      createTime: _parseString(json['createTime']),
      location: _parseString(json['location']), // 新增字段的JSON解析
      visibility: _parseInt(json['visibility']), // 新增可见性字段的JSON解析
      images: _parseMediaResourceList(json['images']),
      comments: _parseCommentList(json['comments']),
      likes: _parseStringList(json['likes']),
    );
  }

  // 转换为JSON，忽略null值
  Map<String, dynamic> toJson() {
    final localImages = images;
    final localcomments = comments;
    final locallikes = likes;
    return {
      if (momentId != null) 'momentId': momentId,
      if (userId != null) 'userId': userId,
      if (portrait != null && portrait != '') 'portrait': portrait,
      if (nickname != null && nickname != '') 'nickname': nickname,
      if (content != null && content != '') 'content': content,
      if (createTime != null) 'createTime': createTime,
      if (location != null && location != '')
        'location': location, // 新增字段的JSON输出
      if (visibility != null)
        'visibility': visibility, // 新增可见性字段的JSON输出（非null时才包含）
      // 序列化媒体资源列表
      if (localImages != null && localImages.isNotEmpty)
        'images': localImages.map((img) => img.toJson()).toList(),
      if (localcomments != null && localcomments.isNotEmpty)
        'comments': localcomments.map((comment) => comment.toJson()).toList(),
      if (locallikes != null && locallikes.isNotEmpty) 'likes': likes,
    };
  }

  // 复制实例，支持字段更新
  MomentModel copyWith({
    int? momentId,
    int? userId,
    String? portrait,
    String? nickname,
    String? content,
    String? createTime,
    String? location, // 新增字段在copyWith中支持更新
    int? visibility, // 新增可见性字段的复制更新支持
    List<Media>? images,
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
      location: location ?? this.location, // 新增字段的默认值使用原实例值
      visibility: visibility ?? this.visibility, // 可见性字段的默认值处理
      images: images ?? this.images,
      comments: comments ?? this.comments,
      likes: likes ?? this.likes,
    );
  }

  // 新增：解析媒体资源列表的辅助方法
  static List<Media> _parseMediaResourceList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) {
        if (item is Map<String, dynamic>) {
          try {
            // 调用FriendMediaResourceModel的fromJson方法
            return Media.fromJson(item);
          } catch (e) {
            print('媒体资源解析失败: $e');
            // 解析失败时返回默认媒体资源（URL为空）
            return Media(url: '');
          }
        }
        print('无效的媒体资源数据: $item');
        return Media(url: '');
      }).toList();
    }
    print('无效的媒体资源列表类型: $value');
    return [];
  }

  // 辅助方法：解析评论列表（保持不变）
  static List<FriendCommentModel> _parseCommentList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) {
        if (item is Map<String, dynamic>) {
          try {
            return FriendCommentModel.fromJson(item);
          } catch (e) {
            print('评论解析失败: $e');
            return FriendCommentModel(content: '解析失败的评论');
          }
        }
        print('无效的评论数据: $item');
        return FriendCommentModel(content: '无效的评论数据');
      }).toList();
    }
    print('无效的评论列表类型: $value');
    return [];
  }

  // 辅助方法：解析int类型，处理null值
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      try {
        return int.parse(value);
      } catch (e) {
        print('解析int失败: $value');
        return null;
      }
    }
    print('无效的int类型: $value');
    return null;
  }

  // 辅助方法：解析String类型，处理null值
  static String? _parseString(dynamic value) {
    if (value == null) return null;
    return value.toString().trim().isNotEmpty ? value.toString() : null;
  }

  // 辅助方法：解析String列表，处理null值
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value.map((item) => _parseString(item) ?? '').toList();
    }
    print('无效的列表类型: $value');
    return [];
  }
}
