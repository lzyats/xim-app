import 'dart:convert';

// package:alpaca/tools/tools_comment.dart
class MomentModel {
  final String id;
  final String userId;
  final String userName;
  final String userAvatarUrl;
  final String content;
  final List<String> images;
  final String createTime;
  final String likeCount;
  final String likeStatus; // 0未点赞 1 已点赞
  final List<CommentData> comments;

  MomentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatarUrl,
    required this.content,
    required this.images,
    required this.createTime,
    required this.likeCount,
    required this.likeStatus,
    required this.comments,
  });

  factory MomentModel.fromJson(Map<String, dynamic> data) {
    return MomentModel(
      id: data['id'],
      userId: data['userId'],
      userName: data['userName'],
      userAvatarUrl: data['userAvatarUrl'],
      content: data['content'],
      images: List<String>.from(data['images']),
      createTime: data['createTime'],
      likeCount: data['likeCount'],
      likeStatus: data['likeStatus'],
      comments: List<CommentData>.from(
        data['comments'].map((comment) => CommentData.fromJson(comment)),
      ),
    );
  }
}

class CommentData {
  final String id;
  final String uid;
  final String userName;
  final String userAvatarUrl;
  final String time;
  final String type;
  final String content;
  final String likes;
  final String likeStatus; // 0未点赞 1 已点赞
  final String replayName; // 被回复者
  final String replayUid; // 被回复者 uid
  final String replayContent; // 回复内容
  final List<CommentData> replayList;

  CommentData({
    required this.id,
    required this.uid,
    required this.userName,
    required this.userAvatarUrl,
    required this.time,
    required this.type,
    required this.content,
    required this.likes,
    required this.likeStatus,
    required this.replayName,
    required this.replayUid,
    required this.replayContent,
    required this.replayList,
  });

  factory CommentData.fromJson(Map<String, dynamic> data) {
    return CommentData(
      id: data['id'],
      uid: data['uid'],
      userName: data['userName'],
      userAvatarUrl: data['userAvatarUrl'],
      time: data['time'],
      type: data['type'],
      content: data['content'],
      likes: data['likes'],
      likeStatus: data['likeStatus'],
      replayName: data['replayName'],
      replayUid: data['replayUid'],
      replayContent: data['replayContent'],
      replayList: List<CommentData>.from(
        data['replayList'].map((replay) => CommentData.fromJson(replay)),
      ),
    );
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
