import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/group/group_member_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 群聊成员
class GroupMemberPage extends GetView<GroupMemberController> {
  // 路由地址
  static const String routeName = '/group_member';
  const GroupMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupMemberController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('群成员'),
      ),
      body: GetBuilder<GroupMemberController>(builder: (builder) {
        return _buildTabs();
      }),
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppTheme.color,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "管理员",
              ),
              Tab(
                text: "群成员",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WidgetContact(
              mark: '群主',
              dataList: controller.managerList,
              onTap: (model) {
                Get.toNamed(
                  FriendDetailsPage.routeName,
                  arguments: {
                    "userId": model.userId,
                    "source": FriendSource.group,
                  },
                );
              },
            ),
            WidgetContact(
              dataList: controller.dataList,
              onTap: (contact) {
                ChatGroup chatGroup = controller.chatGroup;
                // 私聊开关
                if ('Y' == chatGroup.configMember) {
                  // 成员判断
                  if (MemberType.normal == chatGroup.memberType) {
                    throw Exception('群聊开启了隐私保护');
                  }
                }
                Get.toNamed(
                  FriendDetailsPage.routeName,
                  arguments: {
                    "userId": contact.userId,
                    "source": FriendSource.group,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
