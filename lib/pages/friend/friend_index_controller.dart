import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class FriendIndexController extends BaseController {
  // 当前用户
  String userId = ToolsStorage().local().userId;
  // 联系人列表
  List<ContactModel> dataList = [];
  // 当前计数器
  final Map<String, int> _badgerMap = {};
  // 当前计数器
  RxBool badger1 = false.obs;
  RxBool badger2 = false.obs;
  // 刷新
  _onRefresh() async {
    // 执行
    List<ChatFriend> friendList = await ToolsSqlite().friend.getList();
    // 清空
    dataList.clear();
    // 转换
    for (var friend in friendList) {
      dataList.add(
        ContactModel(
          userId: friend.userId,
          nickname: friend.nickname,
          portrait: friend.portrait,
          remark: friend.remark,
          extend: 'ID：${friend.userNo}',
        ),
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // 刷新好友
    _onRefresh();
    // 监听好友
    subscription1 = EventSetting().event.stream.listen((model) {
      // 好友
      if (SettingType.friend == model.setting) {
        // 刷新好友
        _onRefresh();
      }
      // 角标
      else if (SettingType.badger == model.setting) {
        String label = model.label;
        int value = int.parse(model.value);
        switch (model.label) {
          case 'friend':
          case 'group':
            _badgerMap[label] = value;
            _updateFriend();
            break;
        }
      }
    });
  }

  // 更新好友
  _updateFriend() {
    int friend = _badgerMap['friend'] ?? 0;
    int group = _badgerMap['group'] ?? 0;
    badger1.value = friend > 0;
    badger2.value = group > 0;
  }
}
