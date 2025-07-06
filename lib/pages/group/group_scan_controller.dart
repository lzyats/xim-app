import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupScanController extends BaseController {
  // 加入
  Future<void> join() async {
    String groupId = refreshData.groupId;
    String source = refreshData.source;
    String configAudit = refreshData.configAudit;
    await RequestGroup.join(groupId, source, configAudit);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData = Get.arguments;
  }
}
