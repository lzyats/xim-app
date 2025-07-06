import 'package:flutter/material.dart';

// 水印
class ToolsMark {
  ToolsMark._();
  static ToolsMark? _singleton;
  factory ToolsMark() => _singleton ??= ToolsMark._();

  // 遮罩层
  OverlayEntry? _overlayEntry;

  OverlayState? _overlayState;

  // 水印函数
  build(BuildContext context, String watermark) {
    _overlayState ??= Overlay.of(context);
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    if (watermark.isEmpty) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Container(
          // 旋转45度
          transform: Matrix4.rotationZ(45),
          child: CustomPaint(
            // 保障水印在前面且不影响点击等操作
            foregroundPainter: WaterMarkPainter(watermark),
          ),
        );
      },
    );
    _overlayState?.insert(_overlayEntry!);
  }
}

class WaterMarkPainter extends CustomPainter {
  final String watermark;
  const WaterMarkPainter(
    this.watermark,
  );
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < 10; i++) {
      for (var j = 0; j < 10; j++) {
        TextPainter(
            textDirection: TextDirection.ltr,
            text: TextSpan(children: [
              TextSpan(
                text: watermark,
                style: const TextStyle(
                  color: Colors.black12,
                  height: 20,
                ),
              ),
            ]))
          ..layout(maxWidth: 1875, minWidth: 1875)
          ..paint(canvas, Offset(700 - 201.0 * i, 500 - 100.0 * j));
      }
    }
  }

  @override
  bool shouldRepaint(WaterMarkPainter oldDelegate) {
    return false;
  }
}
