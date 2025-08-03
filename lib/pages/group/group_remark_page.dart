import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_remark_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 设置备注
class GroupRemarkPage extends GetView<GroupRemarkController> {
  // 路由地址
  static const String routeName = '/group_remark';
  const GroupRemarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupRemarkController());
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
                '群二维码',
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
                '我的昵称',
                textAlign: TextAlign.left,
              ),
              _buildNickname(),
              const SizedBox(
                height: 10,
              ),
              WidgetCommon.tips(
                '群内昵称',
                textAlign: TextAlign.left,
              ),
              _buildGroupRemark(),
            ],
          ),
        ),
      ),
    );
  }

  _buildNickname() {
    return TextField(
      controller: controller.nicknameController,
      decoration: InputDecoration(
        // 修改输入框样式
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
        // 聚焦状态边框
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
      ),
      readOnly: true,
    );
  }

  _buildGroupRemark() {
    return TextField(
      maxLength: 15,
      controller: controller.remarkController,
      decoration: InputDecoration(
        hintText: '请输入群内昵称',
        // 修改输入框样式
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
        // 聚焦状态边框
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue, // 聚焦时边框颜色
            width: 1,
          ),
        ),
      ),
    );
  }
}
