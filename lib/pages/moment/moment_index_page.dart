// package:alpaca/pages/moment/moment_index_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_index_controller.dart';
//import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/widgets/widget_moment_item.dart'; // 假设该组件用于展示单条朋友圈信息

// 朋友圈列表页面
class MomentIndexPage extends GetView<MomentIndexController> {
  // 路由地址
  static const String routeName = '/moment_index';
  const MomentIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('朋友圈'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.momentList.isEmpty) {
          return const Center(child: Text('暂无朋友圈内容'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: controller.momentList.length,
          itemBuilder: (context, index) {
            return WidgetMomentItem(
              moment: controller.momentList[index],
              onUserTap: () {
                // 处理用户点击事件
                final userId = controller.momentList[index].userId;
                Get.toNamed('/user/detail', arguments: userId);
              },
              onImageTap: (imageIndex) {
                // 处理图片点击事件
                final images = controller.momentList[index].mediaResources
                    .where((res) => res.resourceType == '1')
                    .map((res) => res.url)
                    .toList();

                if (images.isNotEmpty) {
                  Get.toNamed('/image/viewer', arguments: {
                    'images': images,
                    'initialIndex': imageIndex,
                  });
                }
              },
              onLikeTap: () async {
                // 处理点赞事件
                final momentId = controller.momentList[index].momentId;
                await controller.toggleLike(momentId);
              },
              onCommentTap: () {
                // 处理评论事件
                final momentId = controller.momentList[index].momentId;
                _showCommentDialog(context, momentId);
              },
            );
          },
        );
      }),
    );
  }

  // 显示评论对话框
  void _showCommentDialog(BuildContext context, String momentId) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('发表评论'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: '说点什么...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                final comment = commentController.text.trim();
                if (comment.isNotEmpty) {
                  Navigator.of(context).pop();
                  await controller.postComment(momentId, comment);
                }
              },
              child: const Text('发送'),
            ),
          ],
        );
      },
    );
  }
}
