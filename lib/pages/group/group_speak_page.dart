import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/group/group_speak_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_contact.dart';
import 'package:alpaca/widgets/widget_speak.dart';

// 群聊禁言
class GroupSpeakPage extends GetView<GroupSpeakController> {
  // 路由地址
  static const String routeName = '/group_speak';
  const GroupSpeakPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupSpeakController());
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
              '成员禁言',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<GroupSpeakController>(builder: (builder) {
        return _buildTabs(context);
      }),
    );
  }

  _buildTabs(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppTheme.color,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "成员列表",
              ),
              Tab(
                text: "禁言列表",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WidgetContact(
              dataList: controller.dataList,
              onTap: (model) {
                // 禁言
                _speak(context, model);
              },
            ),
            WidgetContact(
              dataList: controller.speakList,
              onTap: (model) {
                // 解除禁言
                _relieve(context, model);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 禁言
  _speak(BuildContext context, ContactModel model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: WidgetSpeak(
            speakType: controller.speakType,
            onChange: (String value) {
              controller.speakType = value;
            },
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.speak(model.userId, controller.speakType);
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 解除
  _relieve(BuildContext context, ContactModel model) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            '解除禁言',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                Get.back();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.speak(model.userId, '0');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
