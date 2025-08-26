import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/common/common_notices_controller.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html/flutter_html.dart';

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
            Get.bottomSheet(
              CommonNoticesItemPage(model: model), // 传递 model 而非通过 arguments
              isScrollControlled: true, // 允许抽屉占满指定高度（关键配置）
              backgroundColor: Colors.transparent, // 透明背景，避免默认白色遮挡遮罩
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
            );
          },
        );
      },
    );
  }
}

// 通知公告
// 通知公告详情页（抽屉样式）
class CommonNoticesItemPage extends StatelessWidget {
  final CommonModel02 model;
  const CommonNoticesItemPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      // 点击遮罩层（抽屉外部区域）关闭页面
      onTap: () => Get.back(),
      child: Container(
        color: Colors.black54, // 半透明遮罩层，占满整个屏幕
        child: Align(
          alignment: Alignment.bottomCenter,
          // 抽屉内容区域（占屏幕75%高度）
          child: GestureDetector(
            // 关键：阻止抽屉内容区域的事件透传到外层遮罩
            onTap: () {},
            child: Container(
              height: screenHeight * 0.75,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    // 抽屉顶部指示器
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),

                    // 标题栏
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 24),
                          Text(
                            model.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Get.back(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints.tightFor(
                                width: 24, height: 24),
                          ),
                        ],
                      ),
                    ),

                    const Divider(height: 1),

                    // 公告内容区域
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              model.createTime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Html(
                                  data: model.content,
                                  style: {
                                    '.ql-align-left':
                                        Style(textAlign: TextAlign.left),
                                    '.ql-align-center':
                                        Style(textAlign: TextAlign.center),
                                    '.ql-align-right':
                                        Style(textAlign: TextAlign.right),
                                    '.ql-align-justify':
                                        Style(textAlign: TextAlign.justify),
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
