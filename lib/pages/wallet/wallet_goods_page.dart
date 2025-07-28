import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_goods_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 钱包商品
class WalletGoodsPage extends GetView<WalletGoodsController> {
  // 路由地址
  static const String routeName = '/wallet_goods';
  const WalletGoodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletGoodsController());
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
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '商品支付',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<WalletGoodsController>(
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                WidgetLineContent('商品名称', controller.goodsName),
                WidgetLineContent('商品金额', controller.goodsPrice),
                WidgetLineContent('订单编号', controller.orderNo),
                WidgetButton(
                  onTap: () {
                    if (ToolsSubmit.progress()) {
                      return;
                    }
                    // 校验
                    if (controller.goodsName.isEmpty) {
                      throw Exception('商品名称不能为空');
                    }
                    if (controller.goodsPrice.isEmpty) {
                      throw Exception('商品金额不能为空');
                    }
                    if (controller.orderNo.isEmpty) {
                      throw Exception('订单编号不能为空');
                    }
                    // 提交
                    WidgetCommon.showKeyboard(
                      context,
                      onPressed: (value) {
                        if (ToolsSubmit.call(millisecond: 10000)) {
                          controller.submit(value);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
