import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_transfer_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_contact.dart';

// 群聊成员
class GroupTransferPage extends GetView<GroupTransferController> {
  // 路由地址
  static const String routeName = '/group_transfer';
  const GroupTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupTransferController());

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
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '转让群聊',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<GroupTransferController>(
        builder: (builder) {
          return WidgetContact(
            mark: '管理员',
            dataList: controller.dataList,
            onTap: (model) {
              _transfer(context, model);
            },
          );
        },
      ),
    );
  }

  // 转让
  _transfer(BuildContext context, ContactModel model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            '确认要转让当前群给【${model.nickname}】吗？',
            style: const TextStyle(
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
                  controller.transfer(model.userId);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
