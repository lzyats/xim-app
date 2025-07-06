import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupManagerController extends BaseController {
  String userId = ToolsStorage().local().userId;
  String groupId = ToolsStorage().chat().chatId;
  // 成员列表
  List<ContactModel> dataList = [];
  // 选中列表
  List<String> selectList = [];

  // 成员列表
  void _memberList() async {
    // 查询
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      // 过滤群主
      if (MemberType.master == member.memberType) {
        continue;
      }
      if (MemberType.manager == member.memberType) {
        selectList.add(member.userId);
      }
      dataList.add(ContactModel(
        userId: member.userId,
        nickname: member.nickname,
        portrait: member.portrait,
        extend: member.userNo,
        remark: ToolsStorage().remark(
          member.userId,
          value: member.nickname,
          read: true,
        ),
        select: MemberType.manager == member.memberType,
      ));
    }
    update();
  }

  // 设置管理员
  Future<void> setManager() async {
    // 提交
    await RequestGroup.setManager(groupId, selectList);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    _memberList();
  }
}
