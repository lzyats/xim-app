import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

class MineIndexController extends BaseController {
  Rx<LocalUser> localUser = ToolsStorage().local().obs;

  @override
  void onInit() {
    super.onInit();
    // 监听我的
    _listenMine();
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
}
