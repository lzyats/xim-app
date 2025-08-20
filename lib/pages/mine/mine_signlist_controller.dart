import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';

class MineSignlistController extends BaseController {
  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestMine.getSignList(refreshPageIndex),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestMine.getSignList(refreshPageIndex + 1),
    );
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }
}

class WalletTradeInfoController extends BaseController {
  late String tradeId;
  // 查看详情
  Future<void> getTradeInfo() async {
    //refreshData = await RequestMine.getTradeInfo(tradeId);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    tradeId = Get.arguments;
    getTradeInfo();
  }
}
