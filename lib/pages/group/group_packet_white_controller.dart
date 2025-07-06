import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupPacketWhiteController extends BaseController {
  late ChatGroup chatGroup;
  // 联系人列表
  List<ContactModel> dataList = [];
  // 选中列表
  List<String> selectList = [];

  // 成员列表
  void _memberList() async {
    String groupId = chatGroup.groupId;
    // 查询成员
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 查询白名单
    selectList = await RequestGroup.queryPacketWhite(groupId);
    for (var member in memberList) {
      if (MemberType.normal != member.memberType) {
        continue;
      }
      dataList.add(
        ContactModel(
          userId: member.userId,
          nickname: member.nickname,
          portrait: member.portrait,
          remark: ToolsStorage().remark(
            member.userId,
            value: member.nickname,
            read: true,
          ),
          extend: member.userNo,
          select: selectList.contains(member.userId),
        ),
      );
    }
    update();
  }

  // 修改红包白名单
  Future<void> editPacketWhite() async {
    String groupId = chatGroup.groupId;
    // 提交
    await RequestGroup.editPacketWhite(groupId, selectList);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    chatGroup = Get.arguments;
    _memberList();
  }
}
