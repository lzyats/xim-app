import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/common/common_notices_controller.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 通知公告
class CommonNoticesPage extends GetView<CommonNoticesController> {
  // 路由地址
  static const String routeName = '/common_notices';
  const CommonNoticesPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonNoticesController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            title: const Text(
              '通知公告',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<CommonNoticesController>(builder: (builder) {
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: controller.refreshController,
          onRefresh: () {
            controller.onRefresh();
          },
          onLoading: () {
            controller.onLoading();
          },
          child: _buildList(),
        );
      }),
    );
  }

  // 加载列表
  _buildList() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: controller.refreshList.length,
      itemBuilder: (context, index) {
        CommonModel02 model = controller.refreshList[index];
        return WidgetLineRow(
          leading: Icon(Icons.notifications, color: Colors.orange),
          model.title,
          subtitle: model.createTime,
          onTap: () {
            Get.to(const CommonNoticesItemPage(), arguments: model);
          },
        );
      },
    );
  }
}

// 通知公告
class CommonNoticesItemPage extends StatelessWidget {
  const CommonNoticesItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CommonModel02 model = Get.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            title: const Text(
              '公告详情',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SafeArea(
        // 避免内容被系统状态栏/导航栏遮挡
        child: Padding(
          // 水平+垂直内边距，让卡片不贴边
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Card(
            elevation: 2, // 卡片阴影深度
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // 卡片圆角
            ),
            child: Padding(
              padding: const EdgeInsets.all(16), // 卡片内边距
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 公告标题
                  Text(
                    model.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8), // 标题与时间的间距
                  // 公告时间
                  Text(
                    model.createTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey, // 浅灰色弱化时间视觉层级
                    ),
                  ),
                  const Divider(
                    // 分隔线（时间与内容区）
                    height: 16,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  // 公告内容（长文本支持滚动）
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        model.content,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.6, // 行高（增强可读性）
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
