import 'package:alpaca/pages/mine/mine_forgot_page.dart';
import 'package:alpaca/pages/mine/mine_pass_page.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_action.dart';
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
              '账号安全',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: GetBuilder<MineSafetyController>(builder: (context) {
        LocalUser localUser = controller.localUser;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              RoundedContainer(
                  child: Column(children: [
                WidgetLineRow(
                  '手机号码',
                  value: localUser.phone,
                  arrow: false,
                ),
                _buildPass(localUser),
                WidgetLineRow(
                  "注销账号",
                  //color: Colors.red,
                  divider: false,
                  onTap: () {
                    Get.toNamed(
                      MineDeletedPage.routeName,
                    );
                  },
                ),
              ])),
              RoundedContainer(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    WidgetLineCenter(
                      "清空朋友圈",
                      color: const Color(0xFFFF8600),
                      onTap: () {
                        _clearmoment();
                      },
                      divider: false,
                      fontSize: 18,
                    ),
                  ])),
              RoundedContainer(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(children: [
                    WidgetLineCenter(
                      "清空聊天记录",
                      color: const Color(0xFFFF8600),
                      onTap: () {
                        _clear();
                      },
                      divider: false,
                      fontSize: 18,
                    ),
                  ])),
              RoundedContainer(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(children: [
                    WidgetLineCenter(
                      '退出软件登录',
                      divider: false,
                      color: const Color(0xFFFF8600),
                      onTap: () {
                        _logout();
                      },
                      fontSize: 18,
                    ),
                  ])),
            ],
          ),
        );
      }),
    );
  }

  // 构建密码
  _buildPass(LocalUser localUser) {
    return Column(
      children: [
        WidgetLineRow(
          "设置密码",
          enable: 'N' == localUser.pass || 'NO' == localUser.pass,
          onTap: () {
            Get.toNamed(
              MinePassPage.routeName,
            );
          },
        ),
        WidgetLineRow(
          "修改密码",
          enable: 'Y' == localUser.pass || 'YES' == localUser.pass,
          onTap: () {
            Get.toNamed(
              MinePasswordPage.routeName,
            );
          },
        ),
        WidgetLineRow(
          "找回密码",
          enable: 'Y' == localUser.pass || 'YES' == localUser.pass,
          onTap: () {
            Get.toNamed(
              MineForgotPage.routeName,
            );
          },
        ),
      ],
    );
  }

  // 清空聊天
  _clear() {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
        context: AppConfig.navigatorKey.currentContext!,
        builder: (context) => eConfirmDialog(
              warningTitle: "警告：清空后无法恢复！",
              confirmDesc: "确定清空聊天信息？",
              //confirmText: "退出登录",
              onConfirm: () {
                // 执行清空朋友圈的逻辑
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.deleteMsg();
                }
              },
              onCancel: () {
                Get.back();
              },
            ));
  }

  _clearmoment() {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
        context: AppConfig.navigatorKey.currentContext!,
        builder: (context) => eConfirmDialog(
              onConfirm: () {
                // 执行清空朋友圈的逻辑
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.deleteMoMsg();
                }
              },
              onCancel: () {
                Get.back();
              },
            ));
  }

  // 用户退出
  _logout() {
    if (ToolsSubmit.progress()) {
      return;
    }
    showCupertinoDialog(
        context: AppConfig.navigatorKey.currentContext!,
        builder: (context) => eConfirmDialog(
              warningTitle: "确定退出当前登录吗？",
              confirmDesc: "退出登录后，将无法使用程序功能",
              confirmText: "退出登录",
              onConfirm: () {
                // 执行清空朋友圈的逻辑
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.logout();
                }
              },
              onCancel: () {
                Get.back();
              },
            ));
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
          backgroundColor: const Color(0xFFF5F5F5),
          elevation: 0,
          title: const Text(
            '注销账号',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "注销账号注意事宜:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDFDFDF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1、确认注销代表您本人同意注销账号\n'
                          '2、注销前请确定您的账号财产已经进行结算或转移\n'
                          '3、注销后您的账号所有权限将会自行解除\n'
                          '4、注销后您的账号财产和记录将会全部删除\n'
                          '5、注销后您账号发布的公开信息将会进行匿名化处理或转移\n'
                          '6、成功注销后如需重新注册，需要重新等待7天',
                          style: TextStyle(
                            height: 2.2,
                            fontSize: 14,
                            color: Color(0xFF6E6E6E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  EnhancedNicknameInputWidget(
                    hintText: '请输入注销内容',
                    controller: controller.textEditingController,
                    maxLength: 20,
                    borderRadius: 15,
                    showPrefixIcon: false,
                    showLengthHint: false,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TDLink(
                      label: '一键输入',
                      style: TDLinkStyle.primary,
                      color: const Color(0xFF00ABFF),
                      uri: Uri(),
                      linkClick: (uri) {
                        controller.textEditingController.text = tips;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  LoginButton(
                    text: '确认注销',
                    onPressed: () {
                      _deleted();
                    },
                    verticalPadding: 22,

                    // 可根据需要自定义其他参数
                    // width: 300,
                    // borderRadius: 40,
                    // backgroundColor: Colors.blue,
                  ),
                ],
              ),
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
          ],
        );
      },
    );
  }
}
