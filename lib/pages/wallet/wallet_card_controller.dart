import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/wallet/wallet_cash_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletCardController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  // 钱包列表
  void getBankList() async {
    refreshList = await RequestWallet.getBankList();
    update();
  }

  // 新增
  add() async {
    String name = nameController.text.trim();
    String wallet = walletController.text.trim();
    // 提交
    await RequestWallet.addBank(name, wallet);
    // 取消
    ToolsSubmit.cancel();
    // 查询
    getBankList();
    // 刷新
    _refreshBankList();
    // 返回
    Get.back();
  }

  // 删除
  delete(WalletModel01 model) async {
    // 提交
    await RequestWallet.deleteBank(model.bankId);
    // 取消
    ToolsSubmit.cancel();
    // 查询
    refreshList.remove(model);
    update();
    // 刷新
    _refreshBankList();
  }

  // 刷新页面
  _refreshBankList() {
    if (Get.isRegistered<WalletCashController>()) {
      WalletCashController cashController = Get.find<WalletCashController>();
      cashController.getBankList();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBankList();
  }

  @override
  void onClose() {
    nameController.dispose();
    walletController.dispose();
    super.onClose();
  }
}
