import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
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
              '我的钱包',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(16), // 可以根据需要调整外边距
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // 可以根据需要调整圆角半径
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  // 钱包信息卡片（代码省略，与原内容一致）
                  Container(
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0551E1), Colors.lightBlueAccent],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // 阴影颜色
                          spreadRadius: 5, // 阴影扩散程度
                          blurRadius: 5, // 阴影模糊程度
                          offset: Offset(5, 5), // 修改偏移量，实现向右下的投影
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '我的钱包',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Obx(
                          () => Text(
                            '\$ ${controller.balance}',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlineGradientButton(
                              gradient: const LinearGradient(colors: [
                                Colors.white,
                                Colors.white,
                              ]),
                              strokeWidth: 2,
                              radius: const Radius.circular(18),
                              child: const Text(
                                '     提现     ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(WalletCashPage.routeName);
                              },
                            ),
                            ElevatedButton(
                              //onPressed: () {
                              //  Get.toNamed(WalletRechargePage.routeName);
                              // },
                              onPressed: () async {
                                ChatRobot chatRobot = await ToolsSqlite()
                                    .robot
                                    .getById(AppConfig.robotId);
                                ToolsRoute().chatPage(
                                  chatId: chatRobot.robotId,
                                  nickname: chatRobot.nickname,
                                  portrait: chatRobot.portrait,
                                  chatTalk: ChatTalk.robot,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              child: const Text('充值'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  WidgetCommon.divider(),

                  // 账单明细（使用"清单"图标）
                  WidgetLineRow(
                    "账单明细",
                    leading: const Icon(Icons.receipt_long, color: Colors.grey),
                    onTap: () {
                      Get.toNamed(WalletTradePage.routeName,
                          arguments: TradeType.all);
                    },
                  ),

                  // 充值记录（使用"箭头向下"图标表示收入）
                  WidgetLineRow(
                    "充值记录",
                    leading:
                        const Icon(Icons.arrow_downward, color: Colors.green),
                    onTap: () {
                      Get.toNamed(WalletTradePage.routeName,
                          arguments: TradeType.recharge);
                    },
                  ),

                  // 红包记录（使用"红包"图标）
                  WidgetLineRow(
                    "红包记录",
                    leading: const Icon(Icons.card_giftcard, color: Colors.red),
                    onTap: () {
                      Get.toNamed(WalletTradePage.routeName,
                          arguments: TradeType.packet);
                    },
                  ),

                  // 提现记录（使用"箭头向上"图标表示支出）
                  WidgetLineRow(
                    "提现记录",
                    leading:
                        const Icon(Icons.arrow_upward, color: Colors.orange),
                    onTap: () {
                      Get.toNamed(WalletTradePage.routeName,
                          arguments: TradeType.cash);
                    },
                  ),

                  // 支付密码（使用"锁"图标）
                  WidgetLineRow(
                    "支付密码",
                    leading: const Icon(Icons.lock, color: Colors.blue),
                    onTap: () {
                      Get.toNamed(WalletPaymentPage.routeName);
                    },
                  ),

                  // 钱包管理（使用"信用卡"图标）
                  WidgetLineRow(
                    "钱包管理",
                    leading:
                        const Icon(Icons.credit_card, color: Colors.purple),
                    onTap: () {
                      Get.toNamed(WalletCardPage.routeName);
                    },
                    divider: false,
                  ),

                  // 实名认证（使用"身份证"图标）
                  Obx(
                    () => WidgetLineRow(
                      "实名认证",
                      leading:
                          const Icon(Icons.perm_identity, color: Colors.teal),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 认证弹窗（代码省略，与原内容一致）
  _auth(BuildContext context, MineModel01 model) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        TextStyle style = const TextStyle(fontSize: 16);
        return CupertinoAlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('认证状态：${model.authLabel}', style: style),
              model.auth != '0'
                  ? Text('认证姓名：${model.name}', style: style)
                  : Container(),
              model.auth != '0'
                  ? Text('身份证号：${model.idCard}', style: style)
                  : Container(),
              model.auth == '3'
                  ? Text('认证备注：${model.authReason}', style: style)
                  : Container(),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () => Get.back(),
            ),
            CupertinoDialogAction(
              child:
                  Text(model.auth == '0' || model.auth == '3' ? '去认证' : '确认'),
              onPressed: () {
                Get.back();
                if (model.auth == '0' || model.auth == '3') {
                  Get.toNamed(WalletAuthPage.routeName);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
