import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_auth_page.dart';
import 'package:alpaca/pages/wallet/wallet_card_page.dart';
import 'package:alpaca/pages/wallet/wallet_cash_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/widgets/widget_checkbox.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 钱包提现
class WalletCashPage extends GetView<WalletCashController> {
  // 路由地址
  static const String routeName = '/wallet_cash';
  const WalletCashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletCashController());
    return KeyboardDismissOnTap(
      child: GetBuilder<WalletCashController>(builder: (builder) {
        WalletModel02 model02 = controller.refreshData;
        return Scaffold(
          appBar: AppBar(
            title: const Text('提现'),
            actions: [
              WidgetAction(
                onTap: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  // 去提现
                  if (AuthType.pass == controller.auth || model02.auth == 'N') {
                    // 验证最小金额
                    double charge = controller.charge + model02.cost;
                    double min = charge;
                    if (min < model02.min) {
                      min = model02.min;
                    }
                    if (controller.amount < charge) {
                      throw Exception('提现金额不能小于 $min 元');
                    }
                    // 验证钱包
                    if (controller.select.name.isEmpty) {
                      throw Exception('提现钱包不能为空');
                    }
                    WidgetCommon.showKeyboard(
                      context,
                      onPressed: (p0) {
                        if (ToolsSubmit.call()) {
                          // 提交
                          controller.cash(p0);
                        }
                      },
                    );
                  }
                  // 去认证
                  else if (model02.auth == 'Y') {
                    _auth(context);
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  WidgetCommon.label('提现金额'),
                  _buildAmount(),
                  WidgetCommon.divider(indent: 0),
                  WidgetCommon.tips(
                    '当前余额 ¥ ${controller.balance} 元',
                    textAlign: TextAlign.left,
                  ),
                  WidgetCommon.tips(
                    '手续费 ¥ ${controller.charge.toStringAsFixed(2)} 元，服务费 ¥ ${model02.cost.toStringAsFixed(2)} 元',
                    textAlign: TextAlign.left,
                  ),
                  WidgetCommon.label('提现说明'),
                  WidgetCommon.tips(
                    '单次提现金额 ¥ ${model02.min.toStringAsFixed(2)} ～ ${model02.max.toStringAsFixed(2)} 元',
                    textAlign: TextAlign.left,
                  ),
                  WidgetCommon.tips(
                    '单日提现次数 ${model02.count} 次',
                    textAlign: TextAlign.left,
                  ),
                  WidgetCommon.tips(
                    model02.remark,
                    textAlign: TextAlign.left,
                  ),
                  WidgetCommon.label('提现钱包'),
                  _buildWallet(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  _buildWallet() {
    if (controller.refreshList.isEmpty) {
      return InkWell(
        onTap: () {
          Get.toNamed(WalletCardPage.routeName);
        },
        child: const Text(
          '去添加钱包',
          style: TextStyle(
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.refreshList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildWalletItem(controller.refreshList[index]);
      },
    );
  }

  _buildWalletItem(WalletModel01 model01) {
    return GestureDetector(
      onTap: () {
        controller.changeWallet(model01);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: Colors.grey[100],
        ),
        child: ListTile(
          title: Text(
            '姓名：${model01.name}',
          ),
          subtitle: Text(
            '账户：${model01.wallet}',
          ),
          trailing: WidgetCheckbox(
            value: controller.select == model01,
            onChanged: (bool value) {
              controller.changeWallet(model01);
            },
          ),
        ),
      ),
    );
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      controller: controller.amountController,
      inputFormatters: [
        AmountFormatter(),
      ],
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        filled: false,
        prefixIconConstraints: BoxConstraints(),
      ),
      onChanged: (value) {
        if (value.isEmpty) {
          value = '0.00';
        }
        controller.changeAmount(double.parse(value));
      },
    );
  }

  // 认证
  _auth(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '提现需要实名认证',
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
              child: const Text('去认证'),
              onPressed: () {
                Get.back();
                Get.offAndToNamed(WalletAuthPage.routeName);
              },
            ),
          ],
        );
      },
    );
  }
}
