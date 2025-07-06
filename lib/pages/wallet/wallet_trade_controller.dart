import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletTradeController extends BaseController {
  late TradeType tradeType;
  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestWallet.getTradeList(tradeType, 1),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestWallet.getTradeList(tradeType, refreshPageIndex + 1),
    );
  }

  // 账单删除
  Future<void> removeTrade(String tradeId) async {
    // 删除
    await RequestWallet.removeTrade(tradeId);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('删除成功');
    // 刷新
    onRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    tradeType = Get.arguments;
    onRefresh();
  }
}

class WalletTradeInfoController extends BaseController {
  late String tradeId;
  // 查看详情
  Future<void> getTradeInfo() async {
    refreshData = await RequestWallet.getTradeInfo(tradeId);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tradeId = Get.arguments;
    getTradeInfo();
  }
}
