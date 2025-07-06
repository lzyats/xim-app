import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupNicknameController extends BaseController {
  TextEditingController nicknameController = TextEditingController();
  String userId = ToolsStorage().local().userId;
  String groupId = ToolsStorage().chat().chatId;
  // 管理员列表
  List<ContactModel> managerList = [];
  // 成员列表
  void _memberList() async {
    // 查询
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    managerList.clear();
    // 转换
    for (var member in memberList) {
      // 移除自己
      if (userId == member.userId) {
        continue;
      }
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
        select: MemberType.manager == member.memberType,
      );
      managerList.add(data);
    }
    update();
  }

  // 设置管理员
  Future<void> setNickname(String userId) async {
    // 提交
    String nickname = nicknameController.text.trim();
    await RequestGroup.setNickname(groupId, userId, nickname);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('修改成功');
    // 重新加载
    _memberList();
  }

  @override
  void onInit() {
    super.onInit();
    _memberList();
  }

  @override
  void onClose() {
    nicknameController.dispose();
    super.onClose();
  }
}
