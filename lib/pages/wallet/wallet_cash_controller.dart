import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/wallet/wallet_index_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletCashController extends BaseController {
  TextEditingController amountController = TextEditingController();
  // 认证
  AuthType auth = ToolsStorage().local().auth;
  // 余额
  String balance = '0.00';
  double amount = 0.00;
  double charge = 0.00;
  WalletModel01 select = WalletModel01.init();
  // 获取配置
  getConfig() async {
    refreshData = WalletModel02.init();
    refreshData = await RequestWallet.getCashConfig();
    update();
  }

  // 钱包详情
  getInfo() async {
    if (Get.isRegistered<WalletIndexController>()) {
      WalletIndexController controller = Get.find<WalletIndexController>();
      balance = await controller.getInfo();
      update();
    }
  }

  // 钱包列表
  void getBankList() async {
    refreshList = await RequestWallet.getBankList();
    if (refreshList.isNotEmpty) {
      select = refreshList.first;
    }
    update();
  }

  // 改变钱包
  void changeWallet(WalletModel01 model) {
    select = model;
    update();
  }

  // 改变金额
  void changeAmount(double value) {
    // 修正金额
    if (value > refreshData.max) {
      value = refreshData.max;
      amountController.text = value.toStringAsFixed(2);
    }
    amount = value;
    charge = amount * refreshData.rate * 0.01;
    update();
  }

  // 提现
  cash(String password) async {
    String name = select.name;
    String wallet = select.wallet;
    await RequestWallet.applyCash(
      amount,
      name,
      wallet,
      password,
    );
    // 更新钱包
    getInfo();
    // 取消
    ToolsSubmit.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    getConfig();
    getInfo();
    getBankList();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}
