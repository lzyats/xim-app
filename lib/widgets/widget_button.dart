import 'package:flutter/material.dart';
import 'package:alpaca/config/app_theme.dart';

// 按钮组件
class WidgetButton extends StatefulWidget {
  final bool search;
  final String? label;
  final Color? color;
  final VoidCallback onTap;

  const WidgetButton({
    super.key,
    this.label,
    required this.onTap,
    this.search = false,
    this.color,
  });

  @override
  createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.search) {
      return _buildSearch();
    }
    return _buildButton();
  }

  _buildSearch() {
    String label = widget.label ?? '搜索';
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.color,
          ),
          height: 40,
          width: 50,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _buildButton() {
    String label = widget.label ?? '提交';
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        disabledColor: Colors.grey,
        onPressed: widget.onTap,
        color: widget.color ?? AppTheme.color,
        textColor: Colors.white,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
