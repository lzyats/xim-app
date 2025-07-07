// 朋友圈信息模型
class Moment {
  final int id; // 对应moments.id
  final String userId; // 对应moments.user_id
  final String content; // 对应moments.content
  final List<String> images; // 对应moments.images（拆分逗号）
  final String location; // 对应moments.location
  final String visibleRange; // 对应moments.visible_range
  final String createTime; // 对应moments.create_time
  final List<Comment> comments; // 关联comments表
  final List<Like> likes; // 关联likes表

  Moment({
    required this.id,
    required this.userId,
    required this.content,
    required this.images,
    required this.location,
    required this.visibleRange,
    required this.createTime,
    required this.comments,
    required this.likes,
  });

  factory Moment.fromJson(Map<String, dynamic> json) {
    return Moment(
      id: json['id'],
      userId: json['user_id'],
      content: json['content'],
      images: json['images']?.split(',') ?? [], // 拆分逗号字符串为列表
      location: json['location'] ?? '',
      visibleRange: json['visible_range'] ?? 'everyone',
      createTime: json['create_time'],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((c) => Comment.fromJson(c))
              .toList() ??
          [],
      likes: (json['likes'] as List<dynamic>?)
              ?.map((l) => Like.fromJson(l))
              .toList() ??
          [],
    );
  }
}

// 评论模型
class Comment {
  final String id;
  final String userId;
  final String momentId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    required this.momentId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['userId'],
      momentId: json['momentId'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

// 点赞模型
class Like {
  final String id;
  final String userId;
  final String momentId;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.userId,
    required this.momentId,
    required this.createdAt,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      userId: json['userId'],
      momentId: json['momentId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
