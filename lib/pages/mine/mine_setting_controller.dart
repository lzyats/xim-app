import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineSettingController extends BaseController {
  LocalUser localUser = ToolsStorage().local();

  // 修改头像
  Future<void> editPortrait(String portrait) async {
    if (portrait.isNotEmpty) {
      localUser.portrait = portrait;
      update();
      // 执行
      await RequestMine.editPortrait(portrait);
    }
    // 取消
    ToolsSubmit.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    // 监听
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.mine != model.setting) {
        return;
      }
      localUser = ToolsStorage().local();
      update();
    });
  }
}
