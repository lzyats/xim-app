import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

class CommonSoftwareController extends BaseController {
  // 分享地址
  String sharePath = ToolsStorage().config().sharePath;
  // 消息声音
  RxString audio = ToolsStorage().setting().audio.obs;
  // 消息通知
  RxString notice = ToolsStorage().setting().notice.obs;
  // 消息声音
  editAudio(bool value) {
    // 刷新
    audio.value = value ? 'Y' : 'N';
    // 更新
    _setting('audio', audio.value);
  }

  // 消息通知
  editNotice(bool value) {
    // 刷新
    notice.value = value ? 'Y' : 'N';
    // 更新
    _setting('notice', notice.value);
  }

  // 消息设置
  _setting(String label, String value) {
    // 更新
    ToolsStorage().setting(value: ChatConfig(audio.value, notice.value));
    // 更新
    ToolsSqlite().config.update(label, value);
  }
}
