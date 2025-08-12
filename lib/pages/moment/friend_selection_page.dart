import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/widgets/widget_contact.dart';
import 'package:alpaca/pages/moment/friend_selection_controller.dart';

// 好友选择页面
class FriendSelectionPage extends GetView<FriendSelectionController> {
  static const String routeName = '/friend_selection';
  final String type; // 'include' 部分可见, 'exclude' 不给谁看

  const FriendSelectionPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FriendSelectionController());
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
            title: Text(type == 'include' ? '部分可见' : '不给谁看'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(result: controller.selectList);
                },
                child: const Text('完成'),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<FriendSelectionController>(builder: (builder) {
        return WidgetContact(
          dataList: controller.dataList,
          onSelect: (selectList) {
            controller.selectList = selectList;
          },
        );
      }),
    );
  }
}
