import 'package:alpaca/request/request_wallet.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

class MineIndexController extends BaseController {
  Rx<LocalUser> localUser = ToolsStorage().local().obs;
  RxString balance = '0.00'.obs;
  var duration = const Duration(seconds: 10);

  @override
  void onInit() async {
    super.onInit();
    // 监听我的
    _listenMine();
    // 延迟2秒（ Duration(seconds: 2) ）
    Future.delayed(Duration(seconds: 3), () {
      getInfo(); // 延时后执行的方法
    });
  }

  // 监听我的
  _listenMine() {
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.mine != model.setting) {
        return;
      }
      localUser.value = ToolsStorage().local();
    });
  }

  // 查询钱包
  Future<String> getInfo() async {
    String value = await RequestWallet.getWalletInfo();
    balance.value = value;
    return value;
  }
}
