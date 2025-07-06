import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_search_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 搜索群聊
class GroupSearchPage extends GetView<GroupSearchController> {
  // 路由地址
  static const String routeName = '/group_search';
  const GroupSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupSearchController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('搜索群聊'),
        ),
        body: GetBuilder<GroupSearchController>(
          builder: (builder) {
            return Column(
              children: [
                _buildSearch(),
                WidgetCommon.divider(),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: controller.refreshController,
                    onLoading: () {
                      controller.onLoading();
                    },
                    child: _buildList(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildSearch() {
    bool groupSearch = ToolsStorage().config().groupSearch == 'Y';
    return TDSearchBar(
      placeHolder: groupSearch ? '请输入群聊名称/ID' : '请输入群聊ID',
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

  _buildList(BuildContext context) {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      itemCount: controller.refreshList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      itemBuilder: (context, index) {
        if (controller.refreshList.length == index) {
          return Container();
        }
        GroupModel03 model = controller.refreshList[index];
        return _buildItem(context, model);
      },
    );
  }

  _buildItem(BuildContext context, GroupModel03 model) {
    return ListTile(
      leading: WidgetCommon.showAvatar(
        model.portrait,
        size: 55,
      ),
      title: Text(model.groupName),
      subtitle: Text('群ID：${model.groupNo}'),
      trailing: WidgetCommon.arrow(),
      onTap: () {
        // 收起小桌板
        FocusManager.instance.primaryFocus?.unfocus();
        // 成员
        if (model.isMember) {
          ToolsRoute().chatPage(
            chatId: model.groupId,
            nickname: model.groupName,
            portrait: model.portrait,
            chatTalk: ChatTalk.group,
          );
        }
        // 非成员
        else {
          _join(context, model);
        }
        //
      },
    );
  }

  // 加入群聊
  _join(BuildContext context, GroupModel03 model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认要加入当前群聊吗？',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.join(
                      model.groupId, model.source, model.configAudit);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
