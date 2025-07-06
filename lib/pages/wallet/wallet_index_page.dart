import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_auth_page.dart';
import 'package:alpaca/pages/wallet/wallet_card_page.dart';
import 'package:alpaca/pages/wallet/wallet_cash_page.dart';
import 'package:alpaca/pages/wallet/wallet_index_controller.dart';
import 'package:alpaca/pages/wallet/wallet_payment_page.dart';
import 'package:alpaca/pages/wallet/wallet_recharge_page.dart';
import 'package:alpaca/pages/wallet/wallet_trade_page.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';

// 钱包页面
class WalletIndexPage extends GetView<WalletIndexController> {
  // 路由地址
  static const String routeName = '/wallet_index';
  const WalletIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletIndexController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的钱包'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 12, 11, 13),
                      Color.fromARGB(255, 130, 126, 127)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Column(
                  children: [
                    Obx(
                      () => Text(
                        '¥ ${controller.balance}',
                        style: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlineGradientButton(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            Colors.white,
                          ]),
                          strokeWidth: 2,
                          radius: const Radius.circular(8),
                          child: const Text(
                            '余额充值',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(
                              WalletRechargePage.routeName,
                            );
                          },
                        ),
                        OutlineGradientButton(
                          gradient: const LinearGradient(
                            colors: [Colors.white, Colors.white],
                          ),
                          strokeWidth: 2,
                          radius: const Radius.circular(8),
                          child: const Text(
                            '余额提现',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(
                              WalletCashPage.routeName,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              WidgetCommon.divider(),
              WidgetLineRow(
                "账单明细",
                onTap: () {
                  Get.toNamed(
                    WalletTradePage.routeName,
                    arguments: TradeType.all,
                  );
                },
              ),
              WidgetLineRow(
                "充值记录",
                onTap: () {
                  Get.toNamed(
                    WalletTradePage.routeName,
                    arguments: TradeType.recharge,
                  );
                },
              ),
              WidgetLineRow(
                "红包记录",
                onTap: () {
                  Get.toNamed(
                    WalletTradePage.routeName,
                    arguments: TradeType.packet,
                  );
                },
              ),
              WidgetLineRow(
                "提现记录",
                onTap: () {
                  Get.toNamed(
                    WalletTradePage.routeName,
                    arguments: TradeType.cash,
                  );
                },
              ),
              WidgetLineRow(
                "支付密码",
                onTap: () {
                  Get.toNamed(
                    WalletPaymentPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "钱包管理",
                onTap: () {
                  Get.toNamed(
                    WalletCardPage.routeName,
                  );
                },
                divider: false,
              ),
              WidgetCommon.border(),
              Obx(
                () => WidgetLineRow(
                  "实名认证",
                  onTap: () {
                    if (ToolsSubmit.call()) {
                      RequestMine.getAuth().then((value) {
                        _auth(context, value);
                        ToolsSubmit.cancel();
                      });
                    }
                  },
                  value: controller.authType.value.label,
                  divider: false,
                ),
              ),
              WidgetCommon.border(),
            ],
          ),
        ),
      ),
    );
  }

  // 认证
  _auth(BuildContext context, MineModel01 model) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle style = const TextStyle(
          fontSize: 16,
        );
        return CupertinoAlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '认证状态：${model.authLabel}',
                style: style,
              ),
              model.auth != '0'
                  ? Text(
                      '认证姓名：${model.name}',
                      style: style,
                    )
                  : Container(),
              model.auth != '0'
                  ? Text(
                      '身份证号：${model.idCard}',
                      style: style,
                    )
                  : Container(),
              model.auth == '3'
                  ? Text(
                      '认证备注：${model.authReason}',
                      style: style,
                    )
                  : Container(),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: Text(
                model.auth == '0' || model.auth == '3' ? '去认证' : '确认',
              ),
              onPressed: () {
                Get.back();
                if (model.auth == '0' || model.auth == '3') {
                  Get.toNamed(
                    WalletAuthPage.routeName,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
