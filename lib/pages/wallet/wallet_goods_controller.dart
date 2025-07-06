import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_uni.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletGoodsController extends BaseController {
  String goodsName = '';
  String goodsPrice = '0';
  String appId = '';
  String orderNo = '';

  // 支付
  submit(String password) async {
    // 提交
    await RequestWallet.payment(
      appId,
      orderNo,
      goodsName,
      goodsPrice,
      password,
    );
    // 取消
    ToolsSubmit.cancel();
    // 关闭
    Get.back();
    // 打开
    await ToolsUni().openMp(appId: appId);
    // 传参
    await ToolsUni().callback(appId: appId, event: 'payment', data: {
      'orderNo': orderNo,
    });
  }

  @override
  void onInit() {
    super.onInit();
    Map<dynamic, dynamic> data = Get.arguments;
    appId = data['appId'];
    orderNo = data['orderNo'];
    goodsName = data['goodsName'];
    goodsPrice = data['goodsPrice'];
  }
}
