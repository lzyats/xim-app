import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/wallet/wallet_recharge_controller.dart';
import 'package:alpaca/widgets/widget_checkbox.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 钱包充值
class WalletRechargePage extends GetView<WalletRechargeController> {
  // 路由地址
  static const String routeName = '/wallet_recharge';
  const WalletRechargePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletRechargeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('账户充值'),
        actions: [
          WidgetAction(
            label: '确认',
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              // 校验
              if (controller.amount.isEmpty) {
                throw Exception('请选择充值金额');
              }
              if (controller.payType == PayType.none) {
                throw Exception('请选择支付方式');
              }
              if (ToolsSubmit.call()) {
                // 提交
                controller.submit();
              }
            },
          ),
        ],
      ),
      body: GetBuilder<WalletRechargeController>(
        builder: (builder) {
          double width = MediaQuery.of(context).size.width;
          return Column(
            children: [
              _buildLabel('充值金额(元)'),
              _buildAmount(width),
              _buildLabel('支付方式'),
              Expanded(
                child: _buildType(),
              ),
              WidgetCommon.tips(
                '今日剩余充值次数：${controller.config.count} 次',
              ),
              const SizedBox(
                height: 20,
              ),
              WidgetCommon.tips(
                controller.config.remark,
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

  _buildLabel(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  _buildAmount(double width) {
    List<Widget> children = [];
    for (var amount in controller.rechargeAmount) {
      children.add(_buildAmountItem(width, amount));
    }
    return Wrap(
      spacing: 8.0, // 主轴方向上的间距
      runSpacing: 8.0, // 跨越跨度方向上的间距
      children: children,
    );
  }

  _buildAmountItem(double width, String amount) {
    Color color = Colors.grey[100] ?? Colors.grey;
    TextStyle style = const TextStyle(
      fontSize: 16,
    );
    if (controller.amount == amount) {
      color = AppTheme.color;
      style = const TextStyle(
        fontSize: 16,
        color: Colors.white,
      );
    }
    return InkWell(
      onTap: () {
        controller.changeAmount(amount);
      },
      child: Container(
        width: width / 3 - 15,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: color,
        ),
        child: Text(
          amount,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildType() {
    return ListView.builder(
      itemCount: controller.rechargeType.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTypeItem(controller.rechargeType[index]);
      },
    );
  }

  _buildTypeItem(PayType payType) {
    return GestureDetector(
      onTap: () {
        controller.changeType(payType);
      },
      child: ListTile(
        leading: Icon(
          payType.icon,
          color: payType.color,
          size: 40,
        ),
        title: Text(
          payType.label,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: WidgetCheckbox(
          value: controller.payType == payType,
          onChanged: (bool value) {
            controller.changeType(payType);
          },
        ),
      ),
    );
  }
}
