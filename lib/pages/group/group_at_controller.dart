import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class GroupAtController extends BaseController {
  LocalChat localChat = ToolsStorage().chat();
  String userId = ToolsStorage().local().userId;
  // 联系人列表
  List<ContactModel> dataList = [];
  List<String> selectList = [];
  final Map<String, String> _dataMap = {};

  // 成员列表
  void _memberList() async {
    // 查询
    String groupId = localChat.chatId;
    List<GroupModel02> memberList = await RequestGroup.getMemberList(groupId);
    // 转换
    for (var member in memberList) {
      // 过滤自己
      if (userId == member.userId) {
        if (MemberType.normal != member.memberType) {
          dataList.add(
            ContactModel(
              userId: '0',
              nickname: '@所有人',
              portrait: member.portrait,
            ),
          );
          // 组装
          _dataMap['0'] = '所有人';
        }
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
        ),
      );
      // 组装
      _dataMap[member.userId] = member.nickname;
    }
    update();
  }

  // 选中
  void submit() {
    List<String> dataList = [];
    if (selectList.isEmpty) {
      throw Exception('请至少选择一个成员哦');
    }
    for (var action in selectList) {
      dataList.add("${_dataMap[action]}༺$action༻");
    }
    Get.back(result: dataList.join('@'));
  }

  @override
  void onInit() {
    super.onInit();
    _memberList();
  }
}
