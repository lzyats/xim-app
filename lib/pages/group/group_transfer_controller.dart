import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/msg/msg_chat_page.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupTransferController extends BaseController {
  String groupId = ToolsStorage().chat().chatId;
  // 管理员列表
  List<ContactModel> dataList = [];
  // 成员列表
  void _memberList() async {
    // 查询
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      // 移除自己
      if (MemberType.master == member.memberType) {
        continue;
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
  Future<void> transfer(String userId) async {
    // 提交
    await RequestGroup.transfer(groupId, userId);
    // 返回
    ToolsRoute().toPage(MsgChatPage.routeName);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('转让成功');
  }

  @override
  void onInit() {
    super.onInit();
    _memberList();
  }
}
