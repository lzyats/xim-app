import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupRemarkController extends BaseController {
  TextEditingController remarkController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  late String groupId;

  // 更新
  _update() async {
    // 昵称
    nicknameController.text = ToolsStorage().local().nickname;
    // 获取详情
    ChatGroup? chatGroup = await ToolsSqlite().group.getById(groupId);
    if (chatGroup == null) {
      return;
    }
    // 备注
    remarkController.text = chatGroup.memberRemark;
  }

  // 备注
  Future<void> setRemark() async {
    String remark = remarkController.text.trim();
    // 执行
    await RequestGroup.setRemark(groupId, remark);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    groupId = Get.arguments;
    _update();
  }

  @override
  void onClose() {
    remarkController.dispose();
    super.onClose();
  }
}
