import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class FriendSelectionController extends BaseController {
  String userId = ToolsStorage().local().userId;
  // 联系人列表
  List<ContactModel> dataList = [];
  // 选择列表
  List<String> selectList = [];

  // 过滤后的列表
  List<ContactModel> filteredList = [];

  @override
  void onInit() {
    super.onInit();
    _loadFriends();
  }

  // 加载好友列表
  void _loadFriends() async {
    // 查询
    List<ChatFriend> friendList = await ToolsSqlite().friend.getList();
    // 转换
    for (var friend in friendList) {
      if (userId == friend.userId) {
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

  // 搜索好友
  void searchFriends(String keyword) {
    if (keyword.isEmpty) {
      filteredList = dataList;
    } else {
      filteredList = dataList.where((friend) {
        return friend.nickname.toLowerCase().contains(keyword.toLowerCase()) ||
            friend.extend?.toLowerCase().contains(keyword.toLowerCase()) ==
                true;
      }).toList();
    }
    update();
  }

  // 更新选择列表
  void updateSelectList(List<String> list) {
    selectList = list;
    update();
  }
}
