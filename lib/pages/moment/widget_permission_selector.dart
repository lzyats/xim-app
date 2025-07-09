import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionSelectionPage extends StatefulWidget {
  final String currentPermission;
  final Function(String) onPermissionSelected;

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

  @override
  void initState() {
    super.initState();
    _selectedPermission = widget.currentPermission;
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
              widget.onPermissionSelected(_selectedPermission);
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
            _buildPermissionItem('公开', Icons.public),
            _buildPermissionItem('好友可见', Icons.group),
            _buildPermissionItem('仅自己可见', Icons.lock),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionItem(String title, IconData icon) {
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
          setState(() {
            _selectedPermission = title;
          });
        },
      ),
    );
  }
}
