import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupCreateController extends BaseController {
  String userId = ToolsStorage().local().userId;
  // 联系人列表
  List<ContactModel> dataList = [];
  // 选择列表
  List<String> selectList = [];
  // 好友列表
  void _friendList() async {
    // 查询
    List<ChatFriend> friendList = await ToolsSqlite().friend.getList();
    // 转换
    for (var friend in friendList) {
      if (userId == friend.userId) {
        continue;
      }
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

  // 创建群聊
  Future<void> create() async {
    // 提交
    await RequestGroup.create(selectList);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    _friendList();
  }
}
