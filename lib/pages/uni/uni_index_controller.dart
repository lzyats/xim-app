import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_uni.dart';

class UniIndexController extends BaseController {
  // 获取列表
  void _getList() async {
    // 执行
    refreshList = await RequestUni.getList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    _getList();
  }
}
