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

  // 定义顶部导航栏的渐变颜色
  final Gradient _appBarGradient = const LinearGradient(
    colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)], // 调整颜色顺序增强垂直感
    begin: Alignment.topCenter, // 从上到下
    end: Alignment.bottomCenter,
    stops: [0.0, 1.0], // 颜色分布点
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendDetailsController());
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                    title: const Text('好友备注'),
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
