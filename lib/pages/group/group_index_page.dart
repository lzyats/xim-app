import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_index_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 群聊列表
class GroupIndexPage extends GetView<GroupIndexController> {
  // 路由地址
  static const String routeName = '/group_index';
  const GroupIndexPage({super.key});

  // 定义顶部导航栏的渐变颜色
  // 修改为上下方向的渐变
  final Gradient _appBarGradient = const LinearGradient(
    colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)], // 调整颜色顺序增强垂直感
    begin: Alignment.topCenter, // 从上到下
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0], // 颜色分布点
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupIndexController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 10),
        child: Container(
          decoration: BoxDecoration(gradient: _appBarGradient),
          child: Column(
            children: [
              // 状态栏区域
              Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.transparent,
              ),
              Expanded(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Obx(
                    () => Text('群聊(${controller.groupCount.value})'),
                  ),
                  centerTitle: true,
                  actions: [
                    WidgetCommon.buildAction(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<GroupIndexController>(builder: (builder) {
        if (controller.dataList.isEmpty) {
          return WidgetCommon.none();
        }
        return WidgetContact(
          dataList: controller.dataList,
          onTap: (ContactModel value) {
            ToolsRoute().chatPage(
              chatId: value.userId,
              nickname: value.nickname,
              portrait: value.portrait,
              chatTalk: ChatTalk.group,
            );
          },
        );
      }),
    );
  }
}
