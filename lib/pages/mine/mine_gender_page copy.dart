import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_gender_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 设置性别
class MineGenderPage extends GetView<MineGenderController> {
  // 路由地址
  static const String routeName = '/mine_gender';
  const MineGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineGenderController());
    return Scaffold(
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
              '修改性别',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildGender(),
          // 将完成按钮移到这里
          const SizedBox(
            height: 20,
          ),
          WidgetAction(
            label1: '立即修改',
            onTap: () {
              if (ToolsSubmit.call()) {
                // 提交
                //controller.submit();
              }
            },
          ),
        ],
      ),
    );
  }

  _buildGender() {
    return SingleChildScrollView(
      child: GetBuilder<MineGenderController>(
        builder: (builder) {
          return Column(
            children: [
              _buildCustomRadioTile('男', '1'),
              _buildCustomRadioTile('女', '2'),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCustomRadioTile(String title, String value) {
    return GestureDetector(
      onTap: () {
        controller.editGender(value);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: controller.gender == value
                      ? Colors.blue
                      : Colors.grey.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: controller.gender == value
                  ? Container(
                      margin: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color:
                    controller.gender == value ? Colors.blue : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
