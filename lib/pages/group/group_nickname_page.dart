import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_nickname_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_contact.dart';

// 成员昵称
class GroupNicknamePage extends GetView<GroupNicknameController> {
  // 路由地址
  static const String routeName = '/group_nickname';
  const GroupNicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupNicknameController());
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
              '成员昵称',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<GroupNicknameController>(
        builder: (builder) {
          return WidgetContact(
            mark: '管理员',
            dataList: controller.managerList,
            onTap: (model) {
              _nickname(context, model);
            },
          );
        },
      ),
    );
  }

  // 修改昵称
  _nickname(BuildContext context, ContactModel model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            '修改成员昵称',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: _buildNickname(model.nickname),
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
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.setNickname(model.userId);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _buildNickname(String nickname) {
    controller.nicknameController.text = nickname;
    return TextField(
      maxLength: 15,
      maxLines: 2,
      controller: controller.nicknameController,
      decoration: const InputDecoration(
        hintText: '请输入昵称',
      ),
    );
  }
}
