import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/friend/friend_search_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 好友搜索
class FriendSearchPage extends GetView<FriendSearchController> {
  // 路由地址
  static const String routeName = '/friend_search';
  const FriendSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendSearchController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('添加好友'),
        ),
        body: GetBuilder<FriendSearchController>(
          builder: (builder) {
            return Column(
              children: [
                _buildSearch(),
                WidgetCommon.divider(),
                _buildItem(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildSearch() {
    return TDSearchBar(
      placeHolder: '请输入ID/手机号',
      action: '搜索',
      controller: controller.textController,
      onActionClick: (value) {
        if (ToolsSubmit.progress()) {
          return;
        }
        // 校验
        if (controller.textController.text.trim().isEmpty) {
          throw Exception('请输入搜索内容');
        }
        if (ToolsSubmit.call()) {
          // 提交
          controller.search();
        }
      },
    );
  }

  _buildItem() {
    FriendModel01? model = controller.refreshData;
    if (model == null) {
      return Expanded(child: WidgetCommon.none());
    }
    return Column(
      children: [
        ListTile(
          leading: WidgetCommon.showAvatar(
            model.portrait,
            size: 55,
          ),
          title: Text(model.nickname),
          subtitle: Text('ID：${model.userNo}'),
          trailing: WidgetCommon.arrow(),
          onTap: () {
            Get.toNamed(
              FriendDetailsPage.routeName,
              arguments: {
                "userId": model.userId,
                "source": model.source,
              },
            );
          },
        ),
        WidgetCommon.divider(),
      ],
    );
  }
}
