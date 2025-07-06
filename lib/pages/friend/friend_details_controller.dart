import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

class FriendDetailsController extends BaseController {
  TextEditingController remarkController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  late String userId;
  FriendSource? friendSource;

  // 获取本地详情
  Future<ChatFriend?> _onRefresh1() async {
    // 执行
    ChatFriend? friend = await ToolsSqlite().friend.getById(userId);
    // 格式化
    _format(friend);
    // 返回
    return friend;
  }

  // 获取详情
  void _onRefresh2() async {
    // 执行
    ChatFriend? friend = await RequestFriend.getInfo(userId);
    // 格式化
    _format(friend);
    // 写入数据库
    if (friend != null && FriendType.friend == friend.friendType) {
      await ToolsSqlite().friend.add(friend);
      // 写入事件
      EventSetting().event.add(
            SettingModel(
              SettingType.friend,
              primary: userId,
            ),
          );
    }
  }

  // 格式化
  _format(ChatFriend? friend) {
    if (friend == null) {
      return;
    }
    if (friendSource != null) {
      friend.friendSource = friendSource!;
    }
    // 默认值
    remarkController.text = friend.remark;
    nicknameController.text = friend.nickname;
    refreshData = friend;
    update();
  }

  // 提交
  setRemark() async {
    String remark = remarkController.text.trim();
    // 更新
    refreshData.remark = remark;
    update();
    // 执行
    await RequestFriend.setRemark(userId, remark);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    refreshData = ChatFriend.init();
    Map<String, dynamic> data = Get.arguments;
    userId = data['userId'];
    friendSource = data['source'];
    _onRefresh1();
    _onRefresh2();
    // 监听好友
    subscription1 = EventSetting().event.stream.listen((model) async {
      if (SettingType.friend != model.setting) {
        return;
      }
      ChatFriend? friend = await _onRefresh1();
      if (friend == null) {
        _onRefresh2();
      }
    });
  }

  @override
  void onClose() {
    remarkController.dispose();
    nicknameController.dispose();
    super.onClose();
  }
}
