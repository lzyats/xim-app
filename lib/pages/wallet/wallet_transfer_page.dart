import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_transfer_controller.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 扫码转账
class WalletTransferPage extends GetView<WalletTransferController> {
  // 路由地址
  static const String routeName = '/wallet_transfer';
  const WalletTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletTransferController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('扫码转账'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: KeyboardDismissOnTap(
          child: SingleChildScrollView(
            child: _buildArea(context),
          ),
        ),
      ),
    );
  }

  _buildArea(
    BuildContext context,
  ) {
    return GetBuilder<WalletTransferController>(builder: (builder) {
      return Column(
        children: [
          WidgetCommon.showAvatar(
            controller.refreshData.portrait,
            size: 100,
          ),
          Text(
            'ID：${controller.refreshData.userNo}',
          ),
          Text(
            '昵称：${controller.refreshData.nickname}',
          ),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '转账前请确认对方信息真实性',
          ),
          const SizedBox(
            height: 10,
          ),
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '转账最大金额¥ ${controller.maxAmount.toStringAsFixed(2)}元',
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '¥ ${controller.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
          _buildSubmit(context),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '注意：转账金额会实时到达对方账户',
          ),
        ],
      );
    });
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        AmountFormatter(),
      ],
      textAlign: TextAlign.right,
      controller: controller.amountController,
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '转账金额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  // 说明
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: controller.remarkController,
      decoration: const InputDecoration(
        hintText: '请输入转账说明',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '转账说明',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      maxLength: 15,
    );
  }

  _buildSubmit(
    BuildContext context,
  ) {
    return WidgetButton(
      label: '转账',
      onTap: () {
        if (ToolsSubmit.progress()) {
          return;
        }
        // 校验
        double amount = controller.amount;
        if (amount < 0.01) {
          throw Exception('转账金额不能为空');
        }
        WidgetCommon.showKeyboard(
          context,
          onPressed: (value) {
            if (ToolsSubmit.call(millisecond: 10000)) {
              // 提交
              controller.transfer(value);
            }
          },
        );
      },
    );
  }
}
