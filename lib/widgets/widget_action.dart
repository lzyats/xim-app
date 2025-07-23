import 'package:flutter/material.dart';
import 'package:alpaca/config/app_theme.dart';

// 右边组件
class WidgetAction extends StatelessWidget {
  final Icon? icon;
  final bool enable;
  final String label;
  final String label1;
  final VoidCallback onTap;

  const WidgetAction({
    this.enable = true,
    super.key,
    this.icon,
    this.label = '完成',
    this.label1 = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
    //修改为蓝色圆角按钮形式
    if (label1 != '') {
      return InkWell(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0463F7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            minimumSize: const Size(0, 48),
            // 投影颜色（半透明黑色，增强层次感）
            shadowColor: Colors.black.withOpacity(0.8),
            // 投影强度（值越大投影越明显）
            elevation: 40,
            // 可选：增加圆角让按钮与投影更协调
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(label1),
          onPressed: onTap,
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: icon ??
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppTheme.color,
                ),
                height: 30,
                width: 50,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        ),
      );
    }
  }
}
