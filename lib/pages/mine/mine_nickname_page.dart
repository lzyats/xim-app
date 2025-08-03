import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_nickname_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';

// 设置昵称
class MineNicknamePage extends GetView<MineNicketnameController> {
  // 路由地址
  static const String routeName = '/mine_nickname';
  const MineNicknamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineNicketnameController());
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
              '修改昵称',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                onTap: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  // 校验
                  _checkNickname();
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.submit();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: _buildNickname(),
    );
  }

  // 昵称
  _buildNickname() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: TextField(
        maxLength: 15,
        controller: controller.nicknameController,
        decoration: InputDecoration(
          hintText: '请输入昵称',
          prefixIcon: Icon(Icons.person), // 昵称图标保留
          // 基础边框（未聚焦时）
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.blue, // 聚焦时边框颜色
              width: 1,
            ),
          ),
          // 启用状态边框（聚焦时）
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
          // 输入框内部边距（避免内容紧贴边框）
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          // 背景色（可选，增加视觉效果）
          filled: true,
          fillColor: Color(0xFFF5F7FA),
        ),
      ),
    );
  }

  // 校验
  _checkNickname() {
    var nickname = controller.nicknameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('请输入昵称');
    }
  }
}
