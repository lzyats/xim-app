import 'dart:convert';

// 朋友圈动态模型
class MomentModel {
  final String momentId;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String content;
  final List<String> images;
  final String createTime;
  final int likeCount;
  final bool isLiked;
  final List<CommentModel> comments;

  MomentModel({
    required this.momentId,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.content,
    required this.images,
    required this.createTime,
    required this.likeCount,
    required this.isLiked,
    required this.comments,
  });

  factory MomentModel.fromJson(Map<String, dynamic> data) {
    return MomentModel(
      momentId: data['moment_id'] ?? '',
      userId: data['user_id'] ?? '',
      userName: data['user_name'] ?? '',
      userAvatarUrl: data['user_avatar_url'] ?? '',
      content: data['content'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      createTime: data['create_time'] ?? '',
      likeCount: data['like_count'] ?? 0,
      isLiked: data['is_liked'] ?? false,
      comments: (data['comments'] as List<dynamic>?)
              ?.map((comment) => CommentModel.fromJson(comment))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'moment_id': momentId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar_url': userAvatarUrl,
      'content': content,
      'images': images,
      'create_time': createTime,
      'like_count': likeCount,
      'is_liked': isLiked,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}

// 评论模型
class CommentModel {
  final String commentId;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String content;
  final String createTime;
  final int likeCount;
  final bool isLiked;
  final String? replyToUserId;
  final String? replyToUserName;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.content,
    required this.createTime,
    required this.likeCount,
    required this.isLiked,
    this.replyToUserId,
    this.replyToUserName,
  });

  factory CommentModel.fromJson(Map<String, dynamic> data) {
    return CommentModel(
      commentId: data['comment_id'] ?? '',
      userId: data['user_id'] ?? '',
      userName: data['user_name'] ?? '',
      userAvatarUrl: data['user_avatar_url'] ?? '',
      content: data['content'] ?? '',
      createTime: data['create_time'] ?? '',
      likeCount: data['like_count'] ?? 0,
      isLiked: data['is_liked'] ?? false,
      replyToUserId: data['reply_to_user_id'],
      replyToUserName: data['reply_to_user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment_id': commentId,
      'user_id': userId,
      'user_name': userName,
      'user_avatar_url': userAvatarUrl,
      'content': content,
      'create_time': createTime,
      'like_count': likeCount,
      'is_liked': isLiked,
      'reply_to_user_id': replyToUserId,
      'reply_to_user_name': replyToUserName,
    };
  }
}
