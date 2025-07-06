import 'dart:async';

import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MinePrivacyController extends BaseController {
  LocalUser localUser = ToolsStorage().local();

  // 修改隐私
  Future<void> editPrivacyNo(String privacyNo) async {
    // 修改
    localUser.privacyNo = privacyNo;
    update();
    // 执行
    await RequestMine.editPrivacyNo(privacyNo);
    // 取消
    ToolsSubmit.cancel();
  }

  // 修改隐私
  Future<void> editPrivacyPhone(String privacyPhone) async {
    // 修改
    localUser.privacyPhone = privacyPhone;
    update();
    // 执行
    await RequestMine.editPrivacyPhone(privacyPhone);
    // 取消
    ToolsSubmit.cancel();
  }

  // 修改隐私
  Future<void> editPrivacyScan(String privacyScan) async {
    // 修改
    localUser.privacyScan = privacyScan;
    update();
    // 执行
    await RequestMine.editPrivacyScan(privacyScan);
    // 取消
    ToolsSubmit.cancel();
  }

  // 修改隐私
  Future<void> editPrivacyCard(String privacyCard) async {
    // 修改
    localUser.privacyCard = privacyCard;
    update();
    // 执行
    await RequestMine.editPrivacyCard(privacyCard);
    // 取消
    ToolsSubmit.cancel();
  }

  // 修改隐私
  Future<void> editPrivacyGroup(String privacyGroup) async {
    // 修改
    localUser.privacyGroup = privacyGroup;
    update();
    // 执行
    await RequestMine.editPrivacyGroup(privacyGroup);
    // 取消
    ToolsSubmit.cancel();
  }
}
