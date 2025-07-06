import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/wallet/wallet_trade_page.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletTransferController extends BaseController {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  double amount = 0;
  double maxAmount = 999999;

  // 扫码转账
  Future<void> transfer(String password) async {
    String remark = remarkController.text.trim();
    if (remark.isEmpty) {
      remark = '';
    }
    String receiveId = refreshData.userId;
    String tradeId = await RequestWallet.transfer(
      receiveId,
      password,
      amount,
      remark,
    );
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('转账成功');
    // 返回
    Get.offNamed(WalletTradeInfoPage.routeName, arguments: tradeId);
  }

  @override
  void onInit() {
    super.onInit();
    refreshData = Get.arguments;
    amountController.addListener(() {
      String text = amountController.text.trim();
      if (text.isEmpty) {
        amount = 0;
      } else {
        amount = double.parse(text);
        if (amount > maxAmount) {
          amount = 0;
          amountController.clear();
        }
      }
      update();
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    remarkController.dispose();
    super.onClose();
  }
}
