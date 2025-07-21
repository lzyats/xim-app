import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/friend/friend_approve_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 好友审批
class FriendApprovePage extends GetView<FriendApproveController> {
  const FriendApprovePage({super.key});
  static const String routeName = '/friend_approve';
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
    Get.lazyPut(() => FriendApproveController());
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
                  title: Text('好友通知'),
                  centerTitle: true,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<FriendApproveController>(
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
        FriendModel02 model = controller.refreshList[index];
        return _buildItem(context, model);
      },
    );
  }

  _buildItem(BuildContext context, FriendModel02 model) {
    Widget trailing;
    if (model.status == '1') {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _WidgetAction(
            agree: false,
            onTap: () {
              _reject(context, model);
            },
          ),
          const SizedBox(
            width: 5,
          ),
          _WidgetAction(
            onTap: () {
              _agree(context, model);
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
                  '验证信息：${model.reason}',
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

  void _agree(BuildContext context, FriendModel02 model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          title: const Text('设置好友备注'),
          content: _buildContent(),
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
                  controller.agree(model.applyId);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _reject(BuildContext context, FriendModel02 model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认忽略好友请求吗？',
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
                  controller.reject(model.applyId);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _buildContent() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: TextField(
        controller: controller.remarkController,
        decoration: const InputDecoration(
          hintText: '请输入备注',
        ),
        maxLength: 15,
      ),
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
