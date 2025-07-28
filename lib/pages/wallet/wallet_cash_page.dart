import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:alpaca/config/app_fonts.dart';
import 'package:get_storage/get_storage.dart';
// 导入EasyLoading
import 'package:flutter_easyloading/flutter_easyloading.dart';

class WalletCashPage extends GetView<WalletCashController> {
  // 路由地址
  static const String routeName = '/withdraw';
  // 【关键修改】将控制器初始化移到build外部，确保实例唯一
  static final TextEditingController _customAmountController =
      TextEditingController();
  // 添加一个标志位来判断是否是用户手动输入
  static bool _isUserInput = false;

  const WalletCashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 16 * 2 - 16 * 2) / 3;

    Get.lazyPut(() => WalletCashController());
    return KeyboardDismissOnTap(
      child: GetBuilder<WalletCashController>(builder: (controller) {
        WalletModel02 model02 = controller.refreshData;
        double accountBalance = double.parse(controller.balance);
        double selectedAmount = controller.amount;

        // 只有当不是用户手动输入时，才更新控制器的文本
        if (!_isUserInput) {
          _customAmountController.text =
              selectedAmount == 0 ? '0.00' : selectedAmount.toString();
        }

        // 封装的预设金额按钮
        Widget _buildAmountButton(
          double amount,
          double width,
          double currentSelected,
          VoidCallback onTap,
        ) {
          return InkWell(
            onTap: onTap,
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                color: currentSelected == amount
                    ? Colors.blue
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Text(
                    '${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: currentSelected == amount
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'USDT',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: currentSelected == amount
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
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
                  '提现',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 账户余额卡片
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0551E1), Colors.lightBlueAccent],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '账户余额',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${accountBalance}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            AppFonts.e7f8,
                            color: Colors.orange,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                // 提现U币数标题
                const Text(
                  '提现U币数',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6.0),
                // 预设金额选择（使用封装的按钮）
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAmountButton(
                          50.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(50.0);
                            _customAmountController.text = '50.00';
                          },
                        ),
                        _buildAmountButton(
                          80.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(80.0);
                            _customAmountController.text = '80.00';
                          },
                        ),
                        _buildAmountButton(
                          100.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(100.0);
                            _customAmountController.text = '100.00';
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAmountButton(
                          200.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(200.0);
                            _customAmountController.text = '200.00';
                          },
                        ),
                        _buildAmountButton(
                          300.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(300.0);
                            _customAmountController.text = '300.00';
                          },
                        ),
                        _buildAmountButton(
                          500.0,
                          buttonWidth,
                          selectedAmount,
                          () {
                            _isUserInput = false;
                            controller.changeAmount(500.0);
                            _customAmountController.text = '500.00';
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // 手动输入提现数
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        controller: _customAmountController,
                        inputFormatters: [
                          AmountFormatter(),
                        ],
                        decoration: InputDecoration(
                          hintText: '\$ 0.00',
                          filled: false,
                          prefixIconConstraints: BoxConstraints(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          _isUserInput = true;
                          try {
                            if (value.isEmpty) {
                              value = '0.00';
                            }
                            double inputAmount = double.parse(value);
                            double charge = controller.charge + model02.cost;
                            double min = charge;
                            if (min < model02.min) {
                              min = model02.min;
                            }
                            double max = accountBalance;

                            if (inputAmount < min) {
                              inputAmount = min;
                              _customAmountController.text =
                                  min.toStringAsFixed(2);
                              _customAmountController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        _customAmountController.text.length),
                              );
                            } else if (inputAmount > max) {
                              inputAmount = max;
                              _customAmountController.text =
                                  max.toStringAsFixed(2);
                              _customAmountController.selection =
                                  TextSelection.fromPosition(
                                TextPosition(
                                    offset:
                                        _customAmountController.text.length),
                              );
                            }

                            controller.changeAmount(inputAmount);
                          } catch (e) {
                            EasyLoading.showError('请输入有效的数字');
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _isUserInput = false;
                        _customAmountController.clear();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),

                _buildWallet(),
                const SizedBox(height: 12.0),
                // 提现按钮和钱包管理按钮
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: WidgetAction(
                        label1: '提交申请',
                        onTap: () {
                          if (selectedAmount <= 0) {
                            EasyLoading.showInfo('请输入有效的提现金额');
                            return;
                          }
                          if (selectedAmount > accountBalance) {
                            EasyLoading.showInfo('提现金额不能超过账户余额');
                            return;
                          }
                          double charge = controller.charge + model02.cost;
                          double min = charge;
                          if (min < model02.min) {
                            min = model02.min;
                          }
                          if (selectedAmount < charge) {
                            EasyLoading.showInfo('提现金额不能小于 $min 元');
                            return;
                          }
                          if (controller.select.name.isEmpty) {
                            EasyLoading.showInfo('提现钱包不能为空');
                            return;
                          }
                          if (ToolsSubmit.progress()) {
                            return;
                          }
                          if (AuthType.pass == controller.auth ||
                              model02.auth == 'N') {
                            WidgetCommon.showKeyboard(
                              context,
                              onPressed: (p0) {
                                if (ToolsSubmit.call()) {
                                  controller.cash(p0);
                                  EasyLoading.showSuccess(
                                      '提现 $selectedAmount U 成功');
                                }
                              },
                            );
                          } else if (model02.auth == 'Y') {
                            _auth(context);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(WalletCardPage.routeName);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                            border: Border.all(color: Colors.pink),
                          ),
                          child: Center(
                            child: Text(
                              '钱包管理',
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildWallet() {
    if (controller.refreshList.isEmpty) {
      return Container();
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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0551E1), Colors.lightBlueAccent],
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    '提现地址：${model01.wallet}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              WidgetCheckbox(
                value: controller.select == model01,
                onChanged: (bool value) {
                  controller.changeWallet(model01);
                },
              ),
            ],
          ),
        ));
  }

  void _auth(BuildContext context) {
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
