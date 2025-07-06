import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_trade_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 群组红包
class GroupTradePage extends GetView<GroupTradeController> {
  // 路由地址
  static const String routeName = '/group_trade';
  const GroupTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupTradeController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('未领红包'),
      ),
      body: GetBuilder<GroupTradeController>(builder: (builder) {
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
          child: _buildBody(context),
        );
      }),
    );
  }

  _buildBody(
    BuildContext context,
  ) {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemCount: controller.refreshList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      itemBuilder: (ctx, index) {
        if (controller.refreshList.length == index) {
          return Container();
        }
        WalletModel07 model = controller.refreshList[index];
        String label = model.tradeType.label;
        return Column(
          children: [
            WidgetLineRow(
              label,
              subtitle: model.createTime,
              value: model.tradeAmount,
              onTap: () {
                _receive(context, model.tradeId);
              },
            ),
          ],
        );
      },
    );
  }

  // 接收
  _receive(BuildContext context, String tradeId) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确认要接收当前红包？',
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
              child: const Text('接收'),
              onPressed: () {
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.receive(tradeId);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
