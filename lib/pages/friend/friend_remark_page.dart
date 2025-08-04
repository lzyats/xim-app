import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_details_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 好友备注
class FriendRemarkPage extends GetView<FriendDetailsController> {
  // 路由地址
  static const String routeName = '/friend_remark';
  const FriendRemarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendDetailsController());
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                '好友备注',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                WidgetAction(
                  onTap: () {
                    if (ToolsSubmit.call()) {
                      // 提交
                      controller.setRemark();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              WidgetCommon.tips(
                '好友昵称',
                textAlign: TextAlign.left,
              ),
              _buildNickname(),
              const SizedBox(
                height: 10,
              ),
              WidgetCommon.tips(
                '好友备注',
                textAlign: TextAlign.left,
              ),
              _buildRemark(),
            ],
          ),
        ),
      ),
    );
  }

  _buildNickname() {
    return TextField(
      controller: controller.nicknameController,
      decoration: const InputDecoration(),
      readOnly: true,
    );
  }

  _buildRemark() {
    return TextField(
      autofocus: true,
      controller: controller.remarkController,
      decoration: const InputDecoration(
        hintText: '请输入备注',
      ),
      maxLength: 15,
    );
  }
}
