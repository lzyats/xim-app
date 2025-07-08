import 'package:flutter/material.dart';

enum Permission {
  everyone,
  friends,
  onlyMe,
}

class PermissionSelectorWidget extends StatefulWidget {
  final String currentPermission; // 接收 String 类型
  final Function(Permission) onPermissionChanged; // 回调返回 Permission

  const PermissionSelectorWidget({
    Key? key,
    required this.currentPermission,
    required this.onPermissionChanged,
  }) : super(key: key);

  @override
  _PermissionSelectorWidgetState createState() =>
      _PermissionSelectorWidgetState();
}

class _PermissionSelectorWidgetState extends State<PermissionSelectorWidget> {
  late Permission _selectedPermission;

  @override
  void initState() {
    super.initState();
    _selectedPermission = _stringToPermission(widget.currentPermission);
  }

  Permission _stringToPermission(String str) {
    switch (str) {
      case '0':
        return Permission.everyone;
      case '1':
        return Permission.friends;
      case '2':
        return Permission.onlyMe;
      default:
        return Permission.onlyMe;
    }
  }

  String _permissionToString(Permission permission) {
    return permission.index.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '可见范围',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        DropdownButton<Permission>(
          value: _selectedPermission,
          onChanged: (Permission? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedPermission = newValue;
              });
              // 将 Permission 转换为 String 后回调
              widget.onPermissionChanged(newValue);
            }
          },
          items: Permission.values.map((Permission permission) {
            return DropdownMenuItem<Permission>(
              value: permission,
              child: Text(
                _getPermissionText(permission),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getPermissionText(Permission permission) {
    switch (permission) {
      case Permission.everyone:
        return '所有人可见';
      case Permission.friends:
        return '仅好友可见';
      case Permission.onlyMe:
        return '仅自己可见';
      default:
        return '所有人可见';
    }
  }
}
