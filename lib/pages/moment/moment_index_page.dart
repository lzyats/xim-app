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
    Get.lazyPut(() => MomentIndexController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('朋友圈列表'),
      ),
      body: Obx(() {
        if (controller.momentList.isEmpty) {
          // 若列表为空，显示加载中或无数据提示
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.momentList.length,
          itemBuilder: (context, index) {
            // 使用自定义组件展示单条朋友圈信息
            return WidgetMomentItem(moment: controller.momentList[index]);
          },
        );
      }),
    );
  }
}
