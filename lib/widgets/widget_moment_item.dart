// package:alpaca/widgets/widget_moment_item.dart
import 'package:flutter/material.dart';
import 'package:alpaca/tools/tools_comment.dart';

// 单条朋友圈信息展示组件
class WidgetMomentItem extends StatelessWidget {
  final MomentModel moment;

  const WidgetMomentItem({super.key, required this.moment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 显示用户头像和昵称
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(moment.userAvatarUrl),
                ),
                const SizedBox(width: 8),
                Text(moment.userName),
              ],
            ),
            const SizedBox(height: 8),
            // 显示朋友圈内容
            Text(moment.content),
            const SizedBox(height: 8),
            // 显示朋友圈图片
            if (moment.images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: moment.images.map((imageUrl) {
                  return Image.network(
                    imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  );
                }).toList(),
              ),
            const SizedBox(height: 8),
            // 显示点赞和评论数量
            Row(
              children: [
                Text('点赞: ${moment.likeCount}'),
                const SizedBox(width: 16),
                Text('评论: ${moment.comments.length}'),
              ],
            ),
            const SizedBox(height: 8),
            // 显示评论列表
            if (moment.comments.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: moment.comments.map((comment) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${comment.userName}: ${comment.content}'),
                      if (comment.replayList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: comment.replayList.map((replay) {
                              return Text(
                                  '${replay.userName} 回复 ${replay.replayName}: ${replay.replayContent}');
                            }).toList(),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
