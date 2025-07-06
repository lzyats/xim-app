import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupInviteController extends BaseController {
  String groupId = ToolsStorage().chat().chatId;
  // 联系人列表
  List<ContactModel> dataList = [];
  // 选中列表
  List<String> selectList = [];
  // 群组信息
  late ChatGroup chatGroup;
  // 初始化
  void _onRefresh() async {
    // 好友列表
    List<ChatFriend> friendList = await ToolsSqlite().friend.getList();
    // 群员列表
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 移除列表
    List<String> removeList = [];
    for (var member in memberList) {
      removeList.add(member.userId);
    }
    // 转换
    for (var friend in friendList) {
      if (removeList.contains(friend.userId)) {
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

  // 邀请
  Future<void> invite() async {
    // 提交
    await RequestGroup.invite(groupId, selectList);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    chatGroup = Get.arguments;
    _onRefresh();
  }
}
