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
          // 初始加载中状态显示
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SmartRefresher(
            controller: controller.refreshController,
            onRefresh: () => controller.onRefresh(),
            onLoading: () => controller.onLoad(),
            // 下拉刷新时显示加载状态
            header: const MaterialClassicHeader(),
            // 上拉加载时显示加载状态
            footer: CustomFooter(
              builder: (context, mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = const Text("上拉加载更多");
                } else if (mode == LoadStatus.loading) {
                  body = const CircularProgressIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = const Text("加载失败，请重试");
                } else if (mode == LoadStatus.canLoading) {
                  body = const Text("释放加载更多");
                } else {
                  body = const Text("没有更多数据了");
                }
                return SizedBox(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: ListView.builder(
              // 没有数据时显示空状态
              itemCount: controller.groupedPosts.isEmpty
                  ? 1
                  : controller.groupedPosts.length,
              itemBuilder: (context, index) {
                // 空状态显示
                if (controller.groupedPosts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("暂无动态数据"),
                    ),
                  );
                }

                DateTime date = controller.groupedPosts[index].key;
                List<MomentModel> posts = controller.groupedPosts[index].value;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        // 动态计算高度，避免内容溢出
                        height: 150 * posts.length.toDouble(),
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WidgetMoment.formatDate(date),
                            if (posts.isNotEmpty)
                              WidgetMoment.buildLocationWidget(
                                  posts.first.location,
                                  strlen: 22),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...posts
                              .map((post) => WidgetMoment.momentsItem(
                                    context,
                                    post: post,
                                    onImageTap: (mediaList, index) =>
                                        WidgetMoment.showImageViewer(
                                            context, mediaList, index),
                                    onVideoTap: (mediaList, index) =>
                                        WidgetMoment.playVideoFullscreen(
                                            context, mediaList[index]),
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
