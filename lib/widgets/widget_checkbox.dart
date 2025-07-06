// 复选框
import 'package:flutter/material.dart';

class WidgetCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double size;

  const WidgetCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 26,
  });

  @override
  createState() => _CheckboxState();
}

class _CheckboxState extends State<WidgetCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.value ? Colors.white : Colors.grey,
          ),
          color: widget.value ? Colors.indigoAccent[400] : Colors.transparent,
        ),
        child: Center(
          child: widget.value
              ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: widget.size - 6,
                )
              : null,
        ),
      ),
    );
  }
}
