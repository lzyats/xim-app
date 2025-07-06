import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

class WalletIndexController extends BaseController {
  RxString balance = '0.00'.obs;
  Rx<AuthType> authType = ToolsStorage().local().auth.obs;

  // 查询钱包
  Future<String> getInfo() async {
    String value = await RequestWallet.getWalletInfo();
    balance.value = value;
    return value;
  }

  @override
  void onInit() {
    super.onInit();
    getInfo();
    // 监听我的
    _addListen();
  }

  // 监听
  _addListen() {
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.mine == model.setting) {
        if (model.label == 'auth') {
          authType.value = AuthType.init(model.value);
        }
      } else if (SettingType.sys == model.setting) {
        if (model.label == 'balance') {
          balance.value = model.value;
        }
      }
    });
  }
}
