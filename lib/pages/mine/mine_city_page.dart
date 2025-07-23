import 'package:flutter/material.dart';
import 'package:flutter_pickers/style/default_style.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_city_controller.dart';

import 'package:flutter_pickers/pickers.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 设置地区
class MineCityPage extends GetView<MineCityController> {
  // 路由地址
  static const String routeName = '/mine_city';
  const MineCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineCityController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '修改地区',
              style: TextStyle(color: Colors.black),
            ),
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
    return GetBuilder<MineCityController>(builder: (builder) {
      return InkWell(
        onTap: () {
          Pickers.showAddressPicker(
            context,
            pickerStyle: NoTitleStyle(),
            initProvince: controller.province,
            initCity: controller.city,
            addAllItem: false,
            onChanged: (p, c, t) {
              controller.onChanged(p, c);
            },
          );
        },
        child: _buildCity(),
      );
    });
  }

  _buildCity() {
    return TextField(
      enabled: false,
      controller: controller.cityController,
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
