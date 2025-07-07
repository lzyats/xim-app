// package:alpaca/widgets/widget_moment_item.dart
import 'package:flutter/material.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/tools/tools_image.dart';
import 'package:alpaca/config/app_color.dart';
import 'package:alpaca/config/app_fonts.dart';

class WidgetMomentItem extends StatelessWidget {
  final MomentModel moment;
  final VoidCallback onUserTap;
  final Function(int index) onImageTap;
  final Function() onLikeTap;
  final Function() onCommentTap;

  const WidgetMomentItem({
    Key? key,
    required this.moment,
    required this.onUserTap,
    required this.onImageTap,
    required this.onLikeTap,
    required this.onCommentTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: AppColor.lineColor, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息行
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户头像
              GestureDetector(
                onTap: onUserTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: ToolsImage.loadNetworkImage(
                    moment.userAvatar,
                    width: 44,
                    height: 44,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // 用户名称和内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 用户名称
                    Text(
                      moment.userName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 4),

                    // 朋友圈内容
                    Text(
                      moment.content,
                      style: const TextStyle(
                          fontSize: 15, color: AppColor.textColor),
                    ),

                    const SizedBox(height: 8),

                    // 媒体资源
                    _buildMediaResources(),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 底部操作栏
          Row(
            // 修正这里的对齐方式
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 发布时间
              Text(
                moment.createTime,
                style: TextStyle(fontSize: 12, color: AppColor.hintColor),
              ),

              // 操作按钮
              Row(
                children: [
                  // 点赞按钮
                  GestureDetector(
                    onTap: onLikeTap,
                    child: Row(
                      children: [
                        Icon(
                          moment.isLiked ? AppFonts.likeFill : AppFonts.like,
                          size: 18,
                          color: moment.isLiked
                              ? AppColor.primaryColor
                              : AppColor.hintColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          moment.likeCount > 0
                              ? moment.likeCount.toString()
                              : '',
                          style: TextStyle(
                              fontSize: 12, color: AppColor.hintColor),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 20),

                  // 评论按钮
                  GestureDetector(
                    onTap: onCommentTap,
                    child: Row(
                      children: [
                        Icon(
                          AppFonts.comment,
                          size: 18,
                          color: AppColor.hintColor,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          moment.commentCount > 0
                              ? moment.commentCount.toString()
                              : '',
                          style: TextStyle(
                              fontSize: 12, color: AppColor.hintColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 评论列表
          if (moment.comments.isNotEmpty) _buildComments(),
        ],
      ),
    );
  }

  // 构建评论列表
  Widget _buildComments() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: moment.comments.map((comment) {
          return Container(
            margin: const EdgeInsets.only(bottom: 6),
            child: RichText(
              text: TextSpan(
                text: comment.userName,
                style: const TextStyle(
                  color: AppColor.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  if (comment.replyToUserName != null)
                    TextSpan(
                      text: ' 回复 ${comment.replyToUserName}:',
                      style: const TextStyle(
                        color: AppColor.textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  TextSpan(
                    text: ' ${comment.content}',
                    style: const TextStyle(
                      color: AppColor.textColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 构建媒体资源
  Widget _buildMediaResources() {
    final resources = moment.mediaResources;
    if (resources.isEmpty) return const SizedBox();

    // 单张图片
    if (resources.length == 1 && resources[0].resourceType == '1') {
      return GestureDetector(
        onTap: () => onImageTap(0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: const BoxConstraints(maxHeight: 200),
          child: ToolsImage.loadNetworkImage(
            resources[0].url,
            fit: BoxFit.contain,
          ),
        ),
      );
    }

    // 多张图片
    if (resources.any((r) => r.resourceType == '1')) {
      final imageResources =
          resources.where((r) => r.resourceType == '1').toList();
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(imageResources.length),
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1,
          ),
          itemCount: imageResources.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onImageTap(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ToolsImage.loadNetworkImage(
                  imageResources[index].url,
                ),
              ),
            );
          },
        ),
      );
    }

    // 视频资源
    if (resources.any((r) => r.resourceType == '2')) {
      final videoResource = resources.firstWhere((r) => r.resourceType == '2');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 200,
        decoration: BoxDecoration(
          color: AppColor.greyColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 视频封面
            if (videoResource.thumbnailUrl.isNotEmpty)
              ToolsImage.loadNetworkImage(
                videoResource.thumbnailUrl,
                width: double.infinity,
                height: double.infinity,
              ),

            // 播放按钮
            const Icon(
              Icons.play_circle_outline,
              size: 50,
              color: Colors.white,
            ),
          ],
        ),
      );
    }

    // 音频资源（如果有）
    if (resources.any((r) => r.resourceType == '3')) {
      final audioResource = resources.firstWhere((r) => r.resourceType == '3');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.audiotrack,
              color: AppColor.primaryColor,
            ),
            const SizedBox(width: 10),
            Text(
              '音频消息',
              style: TextStyle(color: AppColor.textColor),
            ),
            // 这里可以添加音频播放控件
          ],
        ),
      );
    }

    return const SizedBox();
  }

  // 获取图片网格的列数
  int _getCrossAxisCount(int imageCount) {
    if (imageCount == 1) return 1;
    if (imageCount <= 3) return 3;
    if (imageCount <= 6) return 3;
    return 3;
  }
}
