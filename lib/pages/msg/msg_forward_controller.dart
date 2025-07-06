import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class MsgForwardController extends BaseController {
  // 用户
  String userId = ToolsStorage().local().userId;
  // 好友列表
  List<ContactModel> friendList = [];
  // 群组列表
  List<ContactModel> groupList = [];
  // 消息类型
  late List<ForwardModel> dataList;
  // 合并转发
  late bool forward;

  // 好友列表
  void _friendList() async {
    // 执行
    List<ChatFriend> memberList = await ToolsSqlite().friend.getList();
    // 转换
    for (var member in memberList) {
      // 过滤自己
      if (userId == member.userId) {
        continue;
      }
      friendList.add(
        ContactModel(
          userId: member.userId,
          nickname: member.nickname,
          portrait: member.portrait,
          remark: member.remark,
          extend: 'ID：${member.userNo}',
        ),
      );
    }
    update();
  }

  // 群组列表
  void _groupList() async {
    // 执行
    List<ChatGroup> memberList = await ToolsSqlite().group.getList();
    // 转换
    for (var member in memberList) {
      groupList.add(
        ContactModel(
          userId: member.groupId,
          nickname: member.groupName,
          portrait: member.portrait,
          extend: '群ID：${member.groupNo}',
        ),
      );
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // 消息类型
    dataList = Get.arguments;
    // 合并转发
    forward = dataList.first.forward;
    // 好友列表
    _friendList();
    // 群组列表
    _groupList();
  }
}

class ForwardModel {
  // 消息类型
  MsgType msgType;
  // 消息内容
  Map<String, dynamic> content;
  // 合并转发
  bool forward;
  // 创建时间
  DateTime? createTime;
  // 消息来源
  Map<String, dynamic>? source;

  ForwardModel(
    this.msgType,
    this.content, {
    this.forward = false,
    this.createTime,
    this.source,
  });
}
