import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:alpaca/pages/moment/moment_info_controller.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/widgets/widget_moment.dart';

// 主页面
class MomentInfoPage extends StatelessWidget {
  static const routeName = "/moment_info";
  final String userId;
  final String nickname;

  const MomentInfoPage({
    super.key,
    required this.userId,
    required this.nickname,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MomentInfoController(userId: userId));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              nickname,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<MomentInfoController>(
        builder: (controller) {
          return SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoad(),
            child: ListView.builder(
              itemCount: controller.groupedPosts.length,
              itemBuilder: (context, index) {
                DateTime date = controller.groupedPosts[index].key;
                List<MomentModel> posts = controller.groupedPosts[index].value;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 150 * posts.length.toDouble(),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WidgetMoment.formatDate(date),
                            if (posts.isNotEmpty)
                              WidgetMoment.buildLocationWidget(
                                  posts.first.location,
                                  strlen: 16),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...posts
                              .map((post) => WidgetMoment.momentsItem(
                                    post: post,
                                    onImageTap: (mediaList, index) =>
                                        WidgetMoment.showImageViewer(
                                            context, mediaList, index),
                                    onVideoTap: (videoUrl) =>
                                        WidgetMoment.playVideoFullscreen(
                                            context, videoUrl),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
