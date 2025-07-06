import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupSpeakController extends BaseController {
  String speakType = '1';
  // 成员列表
  List<ContactModel> dataList = [];
  // 禁言列表
  List<ContactModel> speakList = [];
  late ChatGroup chatGroup;
  // 成员列表
  void _memberList() async {
    String groupId = chatGroup.groupId;
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      if (MemberType.normal != member.memberType) {
        continue;
      }
      ContactModel data = ContactModel(
        userId: member.userId,
        nickname: member.nickname,
        portrait: member.portrait,
        extend: member.userNo,
        remark: ToolsStorage().remark(
          member.userId,
          value: member.nickname,
          read: true,
        ),
      );
      // 成员
      dataList.add(data);
      // 禁言
      if (member.speakTime.isNotEmpty) {
        ContactModel data = ContactModel(
          userId: member.userId,
          nickname: member.nickname,
          portrait: member.portrait,
          remark: ToolsStorage().remark(
            member.userId,
            value: member.nickname,
            read: true,
          ),
          extend: '${member.userNo} 时间还剩：[${member.speakTime}]',
        );
        speakList.add(data);
      }
    }
    update();
  }

  // 禁言
  Future<void> speak(String userId, String speakType) async {
    String groupId = chatGroup.groupId;
    // 执行
    await RequestGroup.speak(groupId, userId, speakType);
    String msg = '禁言成功';
    if ('0' == speakType) {
      msg = '解除禁言成功';
    }
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast(msg);
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
