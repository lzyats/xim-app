import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/pages/login/login_banned_controller.dart';
import 'package:alpaca/request/request_banned.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_grid.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 封禁页面
class LoginBannedPage extends GetView<LoginBannedController> {
  // 路由地址
  static const String routeName = '/login_banned';
  // 路由编码
  static const int routeCode = 507;
  const LoginBannedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginBannedController());
    return KeyboardDismissOnTap(
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) {
            return;
          }
          _backApp(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('用户封禁'),
            actions: [
              WidgetAction(
                label: '刷新',
                onTap: () {
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.onRefresh();
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildTable(),
                WidgetButton(
                  label: '申请解封',
                  onTap: () {
                    Get.toNamed(LoginBannedApplyPage.routeName);
                  },
                ),
                WidgetButton(
                  label: '退出登录',
                  onTap: () {
                    _backApp(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildTable() {
    return GetBuilder<LoginBannedController>(
      builder: (builder) {
        BannedModel? model = controller.refreshData;
        if (model == null) {
          return WidgetCommon.none();
        }
        return Column(
          children: [
            WidgetLineTable('封禁状态', model.bannedLabel),
            WidgetLineTable('封禁原因', model.reason),
            Obx(
              () => WidgetLineTable('剩余时间', builder.remainStr.value),
            ),
            WidgetLineTable('封禁提醒', model.explain),
          ],
        );
      },
    );
  }

  // 退出app
  _backApp(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '是否退出当前登录？',
            style: TextStyle(
              fontSize: 16,
            ),
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
                controller.logout();
              },
            ),
          ],
        );
      },
    );
  }
}

// 申请解封
class LoginBannedApplyPage extends GetView<LoginBannedController> {
  // 路由地址
  static const String routeName = '/login_banned_apply';

  const LoginBannedApplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginBannedController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('申请解封'),
          actions: [
            WidgetAction(
              onTap: () {
                if (ToolsSubmit.progress()) {
                  return;
                }
                // 校验
                _checkContent();
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.submit();
                }
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContent(),
              Flexible(
                fit: FlexFit.tight,
                child: _buildImages(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildImages() {
    return WidgetGrid(
      length: 3,
      onChange: (dataList) {
        controller.pathList = dataList;
      },
    );
  }

  _buildContent() {
    return TextField(
      controller: controller.contentController,
      maxLines: 5,
      maxLength: 200,
      decoration: const InputDecoration(
        hintText: '请输入内容',
      ),
    );
  }

  // 校验
  _checkContent() {
    var images = controller.contentController.text.trim();
    if (images.isEmpty) {
      throw Exception('请输入内容');
    }
  }
}
