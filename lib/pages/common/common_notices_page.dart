import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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
      appBar: AppBar(
        title: const Text('通知公告'),
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
      appBar: AppBar(
        title: const Text('详情'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.title,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              model.createTime,
            ),
          ),
          WidgetCommon.divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Html(
              data: model.content,
            ),
          ),
          WidgetCommon.divider(),
        ],
      ),
    );
  }
}
