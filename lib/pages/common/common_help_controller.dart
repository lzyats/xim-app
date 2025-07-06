import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_common.dart';

class CommonHelpController extends BaseController {
  List<CommonModel01> dataList = [];
  int index_ = -1;

  // 获取列表
  Future<void> getList() async {
    dataList = await RequestCommon.getHelpList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getList();
  }
}
