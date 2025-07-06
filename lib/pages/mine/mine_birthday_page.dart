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

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineBirthdayController());
    return Scaffold(
      appBar: AppBar(
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

  // 生日
  _buildBirthday() {
    return TextField(
      enabled: false,
      controller: controller.birthdayController,
    );
  }
}
