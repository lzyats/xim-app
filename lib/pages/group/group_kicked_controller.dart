import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupKickedController extends BaseController {
  // 成员列表
  List<ContactModel> dataList = [];
  // 选中列表
  List<String> selectList = [];
  late ChatGroup chatGroup;
  // 成员列表
  void _memberList() async {
    // 查询
    String groupId = chatGroup.groupId;
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      // 组装
      ContactModel data = ContactModel(
        userId: member.userId,
        nickname: member.nickname,
        portrait: member.portrait,
        remark: ToolsStorage().remark(
          member.userId,
          value: member.nickname,
          read: true,
        ),
        extend: member.userNo,
      );
      // 群主
      if (MemberType.master == chatGroup.memberType) {
        if (MemberType.master == member.memberType) {
          continue;
        }
      }
      // 管理员
      else if (MemberType.normal != member.memberType) {
        continue;
      }
      dataList.add(data);
    }
    update();
  }

  // 踢人
  Future<void> kicked() async {
    // 提交
    await RequestGroup.kicked(chatGroup.groupId, selectList);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('移除成功');
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
