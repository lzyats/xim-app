import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupDetailsController extends BaseController {
  ChatGroup chatGroup = ChatGroup.init();
  late String groupId;
  // 成员总数
  String memberSize = '0';
  // 获取详情
  _onRefresh1() async {
    chatGroup = await ToolsSqlite().group.getById(groupId);
    update();
  }

  // 获取详情
  _onRefresh2() async {
    chatGroup = await RequestGroup.getInfo(groupId);
    memberSize = chatGroup.memberSize;
    update();
  }

  // 置顶
  Future<void> setTop(String top) async {
    // 更新
    chatGroup.memberTop = top;
    update();
    // 执行
    await RequestGroup.setTop(groupId, top);
    // 取消
    ToolsSubmit.cancel();
  }

  // 静默
  Future<void> setDisturb(String disturb) async {
    // 更新
    chatGroup.memberDisturb = disturb;
    update();
    // 执行
    await RequestGroup.setDisturb(groupId, disturb);
    // 取消
    ToolsSubmit.cancel();
  }

  // 退出
  Future<void> logout() async {
    // 执行
    await RequestGroup.logout(groupId);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    ToolsRoute().toPage(MainPage.routeName);
  }

  @override
  void onInit() {
    super.onInit();
    groupId = Get.arguments;
    _onRefresh1();
    _onRefresh2();
    // 监听群聊
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.group != model.setting) {
        return;
      }
      _onRefresh1();
    });
  }
}
