import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';

class MineInventoryController extends BaseController {
  LocalUser localUser = ToolsStorage().local();
  List<String> headerList = ['设备信息', '用户信息', '使用信息'];
  int index_ = -1;

  // 修改下标
  Future<void> changeIndex(int index) async {
    if (index_ == index) {
      index_ = -1;
    } else {
      index_ = index;
    }
    update();
  }
}
