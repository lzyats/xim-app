import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupMemberController extends BaseController {
  // 管理员列表
  List<ContactModel> managerList = [];
  // 成员列表
  List<ContactModel> dataList = [];
  // 群聊
  late ChatGroup chatGroup;
  // 成员列表
  void _memberList() async {
    String groupId = chatGroup.groupId;
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      ContactModel data = ContactModel(
        userId: member.userId,
        nickname: member.nickname,
        portrait: member.portrait,
        remark: ToolsStorage().remark(
          member.userId,
          value: member.nickname,
          read: true,
        ),
      );
      if (MemberType.normal == member.memberType) {
        data.extend = 'ID：${ToolsRegex.encrypt(member.userNo)}';
        dataList.add(data);
      } else {
        data.select = MemberType.master == member.memberType;
        data.extend = 'ID：${member.userNo}';
        managerList.add(data);
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    chatGroup = Get.arguments;
    _memberList();
  }
}
