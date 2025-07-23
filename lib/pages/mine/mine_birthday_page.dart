import 'package:flutter/material.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_birthday_controller.dart';

import 'package:flutter_pickers/pickers.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 设置生日
class MineBirthdayPage extends GetView<MineBirthdayController> {
  // 路由地址
  static const String routeName = '/mine_birthday';
  const MineBirthdayPage({super.key});

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
    Get.lazyPut(() => MineBirthdayController());
    return Scaffold(
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
                  title: const Text('修改生日'),
                  actions: [
                    WidgetAction(
                      onTap: () {
                        if (ToolsSubmit.call()) {
                          // 提交
                          controller.submit();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _checkLocation(context),
          ],
        ),
      ),
    );
  }

  _checkLocation(BuildContext context) {
    return GetBuilder<MineBirthdayController>(
      builder: (builder) {
        return InkWell(
          onTap: () {
            Pickers.showDatePicker(
              context,
              pickerStyle: NoTitleStyle(),
              selectDate: controller.birthday,
              minDate: controller.min,
              maxDate: controller.max,
              onChanged: (PDuration birthday) {
                controller.onChanged(birthday);
              },
            );
          },
          child: _buildBirthday(),
        );
      },
    );
  }

  // 生日 - 统一边框样式为圆角25、蓝色边框
  _buildBirthday() {
    return TextField(
      enabled: false,
      controller: controller.birthdayController,
      decoration: InputDecoration(
        // 基础边框（未聚焦时）
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
        // 启用状态边框（未聚焦时）
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
        // 聚焦状态边框
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 1,
          ),
        ),
        // 输入框内边距，调整内容与边框的距离
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        // 提示文本样式（当输入框为空时显示）
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintText: "请选择生日", // 添加提示文本，增强用户引导
      ),
    );
  }
}
