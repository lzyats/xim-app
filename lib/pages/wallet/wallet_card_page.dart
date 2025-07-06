import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_card_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 钱包卡包
class WalletCardPage extends GetView<WalletCardController> {
  // 路由地址
  static const String routeName = '/wallet_card';
  const WalletCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletCardController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('钱包管理'),
        actions: [
          WidgetAction(
            label: '添加',
            onTap: () {
              Get.to(const WalletCardItemPage());
            },
          ),
        ],
      ),
      body: GetBuilder<WalletCardController>(
        builder: (builder) {
          return Column(
            children: [
              Expanded(
                child: _buildWallet(context),
              ),
              WidgetCommon.tips(
                '钱包不能超过 5 张',
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }

  _buildWallet(
    BuildContext context,
  ) {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      itemCount: controller.refreshList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      itemBuilder: (ctx, index) {
        if (controller.refreshList.length == index) {
          return Container();
        }
        WalletModel01 model = controller.refreshList[index];
        return ListTile(
          leading: Icon(
            PayType.alipay.icon,
            size: 40,
            color: PayType.alipay.color,
          ),
          title: Text(
            '姓名：${model.name}',
          ),
          subtitle: Text(
            '账户：${model.wallet}',
          ),
          trailing: InkWell(
            child: const Icon(
              Icons.delete,
            ),
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              showCupertinoDialog(
                context: context,
                builder: (builder) {
                  return CupertinoAlertDialog(
                    content: const Text(
                      '确认删除此钱包吗？',
                      style: TextStyle(fontSize: 16),
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
                          // 返回
                          Get.back();
                          if (ToolsSubmit.call()) {
                            // 提交
                            controller.delete(model);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

// 新增钱包
class WalletCardItemPage extends GetView<WalletCardController> {
  const WalletCardItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletCardController());
    controller.nameController.clear();
    controller.walletController.clear();
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('新增钱包'),
          actions: [
            WidgetAction(
              onTap: () {
                if (ToolsSubmit.progress()) {
                  return;
                }
                // 验证
                String name = controller.nameController.text.trim();
                if (name.isEmpty) {
                  throw Exception('请输入支付宝姓名');
                }
                String wallet = controller.walletController.text.trim();
                if (wallet.isEmpty) {
                  throw Exception('请输入支付宝账户');
                }
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.add();
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildName(),
              const SizedBox(
                height: 10,
              ),
              _buildWallet(),
              WidgetCommon.tips(
                '说明：仅支持【支付宝】',
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildName() {
    return TextField(
      controller: controller.nameController,
      maxLength: 20,
      decoration: const InputDecoration(
        hintText: '请输入支付宝姓名',
        icon: Text(
          '姓名:',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  _buildWallet() {
    return TextField(
      controller: controller.walletController,
      maxLength: 30,
      decoration: const InputDecoration(
        hintText: '请输入支付宝账户',
        icon: Text(
          '账户:',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
