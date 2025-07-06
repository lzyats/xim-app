import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/group/group_approve_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 群聊审批
class GroupApprovePage extends GetView<GroupApproveController> {
  const GroupApprovePage({super.key});
  static const String routeName = '/group_approve';

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupApproveController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('群聊通知'),
      ),
      body: GetBuilder<GroupApproveController>(
        builder: (builder) {
          return SlidableAutoCloseBehavior(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: controller.refreshController,
              onLoading: () {
                controller.onLoading();
              },
              onRefresh: () {
                controller.onRefresh();
              },
              child: _buildBody(),
            ),
          );
        },
      ),
    );
  }

  _buildBody() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.builder(
      itemCount: controller.refreshList.length,
      itemBuilder: (context, index) {
        GroupModel01 model = controller.refreshList[index];
        return _buildItem(context, model);
      },
    );
  }

  _buildItem(BuildContext context, GroupModel01 model) {
    Widget trailing = Container();
    if (model.status == '1') {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _WidgetAction(
            agree: false,
            onTap: () {
              _reject(context, model.applyId);
            },
          ),
          const SizedBox(
            width: 5,
          ),
          _WidgetAction(
            onTap: () {
              _agree(context, model.applyId);
            },
          ),
        ],
      );
    } else {
      trailing = Text(
        model.status == '2' ? '已同意' : '已忽略',
        style: const TextStyle(fontSize: 14),
      );
    }
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25 * 1,
        children: [
          SlidableAction(
            onPressed: (context) {
              if (ToolsSubmit.call()) {
                // 提交
                controller.delete(model.applyId);
              }
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: '删除',
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            leading: WidgetCommon.showAvatar(model.portrait),
            title: Text(
              model.nickname,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '申请来源：${model.remark}',
                ),
                Text(
                  '加入群聊：${model.groupName}',
                ),
              ],
            ),
            trailing: trailing,
          ),
          WidgetCommon.divider(),
        ],
      ),
    );
  }

  void _agree(BuildContext context, String applyId) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认同意加群请求吗？',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('同意'),
              onPressed: () {
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.agree(applyId);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _reject(BuildContext context, String applyId) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认忽略加群请求吗？',
            style: TextStyle(fontSize: 16),
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
                  controller.reject(applyId);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class _WidgetAction extends StatelessWidget {
  final bool agree;
  final VoidCallback onTap;

  const _WidgetAction({
    required this.onTap,
    this.agree = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: agree ? AppTheme.color : Colors.grey[600],
        ),
        height: 30,
        width: 40,
        child: Text(
          agree ? '同意' : '忽略',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
