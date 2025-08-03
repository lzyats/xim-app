import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/friend/friend_approve_page.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/friend/friend_index_controller.dart';
import 'package:alpaca/pages/group/group_approve_page.dart';
import 'package:alpaca/pages/group/group_index_page.dart';
import 'package:alpaca/pages/robot/robot_index_page.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';
import 'package:alpaca/widgets/widget_line.dart';

double _iconSize = 40;

// 好友列表
class FriendIndexPage extends GetView<FriendIndexController> {
  const FriendIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendIndexController());
    return GetBuilder<FriendIndexController>(builder: (builder) {
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
                stops: [0.0, 1.0], // 颜色分布点
              ),
            ),
            child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('好友(${builder.dataList.length})'),
              actions: [
                WidgetCommon.buildAction(),
              ],
            ),
          ),
        ),
        body: WidgetContact(
          header: _buildHeader(),
          dataList: builder.dataList,
          onTap: (ContactModel value) {
            Get.toNamed(
              FriendDetailsPage.routeName,
              arguments: {
                "userId": value.userId,
              },
            );
          },
        ),
      );
    });
  }

  // 组装头部
  _buildHeader() {
    return Container(
      color: Color(0xFFFEFEFF), // 添加背景色
      child: Column(
        children: [
          Obx(
            () => WidgetLineRow(
              "好友通知",
              leading: Icon(
                AppFonts.e6f6,
                color: Colors.green,
                size: _iconSize,
              ),
              badger: controller.badger1.value,
              arrow: false,
              onTap: () {
                Get.toNamed(FriendApprovePage.routeName);
              },
            ),
          ),
          Obx(
            () => WidgetLineRow(
              "群聊通知",
              leading: Icon(
                AppFonts.e629,
                color: Colors.purple,
                size: _iconSize,
              ),
              badger: controller.badger2.value,
              arrow: false,
              onTap: () {
                Get.toNamed(GroupApprovePage.routeName);
              },
            ),
          ),
          WidgetLineRow(
            "我的群聊",
            leading: Icon(
              AppFonts.e61b,
              color: Colors.orange,
              size: _iconSize,
            ),
            arrow: false,
            onTap: () {
              Get.toNamed(GroupIndexPage.routeName);
            },
          ),
          WidgetLineRow(
            "官方服务",
            leading: Icon(
              AppFonts.e62f,
              color: Colors.blue,
              size: _iconSize,
            ),
            arrow: false,
            onTap: () async {
              ChatRobot chatRobot =
                  await ToolsSqlite().robot.getById(AppConfig.robotId);
              ToolsRoute().chatPage(
                chatId: chatRobot.robotId,
                nickname: chatRobot.nickname,
                portrait: chatRobot.portrait,
                chatTalk: ChatTalk.robot,
              );
            },
            divider: false,
          ),
        ],
      ),
    );
  }
}
