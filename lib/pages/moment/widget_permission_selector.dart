import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/pages/moment/friend_selection_page.dart'; // 导入新页面

class PermissionSelectionPage extends StatefulWidget {
  final String currentPermission;
  final Function(String, List<String>?) onPermissionSelected; // 新增参数

  const PermissionSelectionPage({
    Key? key,
    required this.currentPermission,
    required this.onPermissionSelected,
  }) : super(key: key);

  @override
  _PermissionSelectionPageState createState() =>
      _PermissionSelectionPageState();
}

class _PermissionSelectionPageState extends State<PermissionSelectionPage> {
  late String _selectedPermission;
  List<String>? _selectedFriends; // 存储选择的好友ID
  LocalUser localUser = ToolsStorage().local();

  @override
  void initState() {
    super.initState();
    _selectedPermission = widget.currentPermission;
  }

  // 跳转到好友选择页面
  void _navigateToFriendSelection(String type) async {
    final result = await Get.to(
      () => FriendSelectionPage(type: type),
    );
    if (result != null && result is List<String>) {
      setState(() {
        _selectedPermission = type == 'include' ? '部分可见' : '不给谁看';
        _selectedFriends = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '可见范围',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              // 返回权限类型和选择的好友列表
              widget.onPermissionSelected(
                  _selectedPermission, _selectedFriends);
              Get.back();
            },
            child: const Text(
              '确定',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            if (localUser.isvip > 0)
              _buildPermissionItem('广场公开', Icons.public, isSpecial: false),
            _buildPermissionItem('好友可见', Icons.group, isSpecial: false),
            _buildPermissionItem('自己可见', Icons.lock, isSpecial: false),
            // 部分可见 - 点击时跳转到选择页面
            _buildPermissionItem('部分可见', Icons.people_alt,
                isSpecial: true, type: 'include'),
            // 不给谁看 - 点击时跳转到选择页面
            _buildPermissionItem('不给谁看', Icons.do_not_disturb_on,
                isSpecial: true, type: 'exclude'),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem(String title, IconData icon,
      {required bool isSpecial, String? type}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: _selectedPermission == title ? Colors.grey[200] : Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: _selectedPermission == title
            ? const Icon(
                Icons.check,
                color: Colors.blue,
              )
            : null,
        onTap: () {
          if (isSpecial && type != null) {
            // 跳转到好友选择页面
            _navigateToFriendSelection(type);
          } else {
            setState(() {
              _selectedPermission = title;
              _selectedFriends = null; // 重置选择的好友
            });
          }
        },
      ),
    );
  }
}
