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
      appBar: AppBar(
        title: const Text('修改地区'),
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
    );
  }
}
