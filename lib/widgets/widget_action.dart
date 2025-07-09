import 'package:flutter/material.dart';
import 'package:alpaca/config/app_theme.dart';

// 右边组件
class WidgetAction extends StatelessWidget {
  final Icon? icon;
  final bool enable;
  final String label;
  final VoidCallback onTap;

  const WidgetAction({
    this.enable = true,
    super.key,
    this.icon,
    this.label = '完成',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
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
