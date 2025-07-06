import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupLevelController extends BaseController {
  int level = 0;
  late ChatGroup chatGroup;
  // 价格列表
  void _priceList() async {
    // 查询
    String groupId = chatGroup.groupId;
    refreshList = await RequestGroup.groupLevelPrice(groupId);
    if (refreshList.first != null) {
      changeLevel(refreshList.first.level);
    }
    update();
  }

  // 改变级别
  void changeLevel(int currentIndex) {
    level = currentIndex;
    update();
  }

  // 支付
  Future<void> groupLevelPay(String password) async {
    // 提交
    await RequestGroup.groupLevelPay(chatGroup.groupId, level, password);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    refreshPageIndex = 0;
    chatGroup = Get.arguments;
    _priceList();
  }
}
