import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_password_page.dart';
import 'package:alpaca/pages/mine/mine_safety_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 账号安全
class MineSafetyPage extends GetView<MineSafetyController> {
  // 路由地址
  static const String routeName = '/mine_safety';
  const MineSafetyPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineSafetyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('账号安全'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            WidgetLineRow(
              '手机号码',
              value: controller.localUser.phone,
              arrow: false,
            ),
            WidgetLineRow(
              "修改密码",
              enable: AppConfig.loginPwd,
              onTap: () {
                Get.toNamed(
                  MinePasswordPage.routeName,
                );
              },
            ),
            WidgetLineRow(
              "注销账号",
              color: Colors.red,
              divider: false,
              onTap: () {
                Get.toNamed(
                  MineDeletedPage.routeName,
                );
              },
            ),
            WidgetCommon.border(),
            WidgetLineCenter(
              "清空聊天",
              color: Colors.red,
              onTap: () {
                _clear(context);
              },
              divider: false,
            ),
            WidgetCommon.border(),
            WidgetLineCenter(
              '退出登录',
              divider: false,
              color: Colors.red,
              onTap: () {
                _logout(context);
              },
            ),
            WidgetCommon.border(),
          ],
        ),
      ),
    );
  }

  // 清空聊天
  _clear(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text(
            '警告：清空后无法恢复！',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          content: const Text(
            '确定清空聊天信息？',
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
              child: const Text('清空'),
              onPressed: () {
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.deleteMsg();
                }
              },
            ),
          ],
        );
      },
    );
  }

  // 用户退出
  _logout(BuildContext context) {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '确定退出当前登录吗？',
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
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.logout();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

// 注销账号
class MineDeletedPage extends GetView<MineSafetyController> {
  final String tips = '我本人同意注销账号';
  // 路由地址
  static const String routeName = '/mine_deleted';
  const MineDeletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineSafetyController());
    controller.textEditingController.text = '';
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('注销账号'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  '注销账号请输入 ($tips)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: controller.textEditingController,
                  decoration: const InputDecoration(
                    hintText: '请输入注销内容',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TDLink(
                    label: '一键输入',
                    style: TDLinkStyle.primary,
                    uri: Uri(),
                    linkClick: (uri) {
                      controller.textEditingController.text = tips;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '注销账号注意事宜',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(255, 234, 234, 232),
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '1、确认注销代表您本人同意注销账号\n',
                        ),
                        TextSpan(
                          text: '2、注销前请确定您的账号财产已经进行结算或转移\n',
                        ),
                        TextSpan(
                          text: '3、注销后您的账号所有权限将会自行解除\n',
                        ),
                        TextSpan(
                          text: '4、注销后您的账号财产和记录将会全部删除\n',
                        ),
                        TextSpan(
                          text: '5、注销后您的账号发布的公开信息将会进行匿名化处理或转移\n',
                        ),
                        TextSpan(
                          text: '6、成功注销后如需重新注册，需要重新等待7天',
                        ),
                      ],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                WidgetButton(
                  label: '确认注销',
                  onTap: () {
                    _deleted();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 用户注销
  _deleted() {
    if (ToolsSubmit.progress()) {
      return;
    }
    String text = controller.textEditingController.value.text.trim();
    if (text != text) {
      EasyLoading.showToast('请正确输入注销内容');
      return;
    }
    showCupertinoDialog(
      context: AppConfig.navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('警告，正在进行注销账号！'),
          content: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              '是否同意此操作？',
              style: TextStyle(
                fontSize: 16,
              ),
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
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.deleted();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
