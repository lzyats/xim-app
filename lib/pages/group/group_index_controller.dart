import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupIndexController extends BaseController {
  // 联系人列表
  List<ContactModel> dataList = [];
  // 群组数量
  RxInt groupCount = 0.obs;
  // 刷新
  _onRefresh() async {
    // 执行
    List<ChatGroup> groupList = await ToolsSqlite().group.getList();
    dataList.clear();
    groupCount.value = groupList.length;
    // 转换
    if (groupList.isNotEmpty) {
      for (var group in groupList) {
        dataList.add(
          ContactModel(
            userId: group.groupId,
            nickname: group.groupName,
            portrait: group.portrait,
            extend: '群ID：${group.groupNo}',
          ),
        );
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // 刷新群聊
    _onRefresh();
    // 监听群聊
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.group != model.setting) {
        return;
      }
      // 刷新群聊
      _onRefresh();
    });
    // 群聊列表
    RequestGroup.getGroupList();
  }
}
