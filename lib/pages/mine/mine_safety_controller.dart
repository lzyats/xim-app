import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

class MineSafetyController extends BaseController {
  TextEditingController textEditingController = TextEditingController();
  LocalUser localUser = ToolsStorage().local();
  // 退出登录
  Future<void> logout() async {
    // 执行
    await RequestAuth.logout();
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 用户注销
  Future<void> deleted() async {
    // 执行
    await RequestMine.deleted();
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 清空聊天
  Future<void> deleteMsg() async {
    // 执行清空
    await RequestMessage.deleteMsg();
    // 清空消息
    await ToolsSqlite().extend.clearAll();
    // 清空角标
    ToolsBadger().clear();
    // 写入事件
    EventSetting().handle(SettingModel(SettingType.message));
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('清空成功');
    // 返回
    Get.back();
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
