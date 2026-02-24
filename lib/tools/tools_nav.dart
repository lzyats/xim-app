import 'package:flutter/services.dart';

enum NavigationMode {
  gesture,
  threeButton,
  twoButton,
  unknown,
}

class SystemNav {
  static const MethodChannel _ch = MethodChannel('lansoft.com/system');

  static NavigationMode _parse(String? s) {
    switch (s) {
      case 'gesture':
        return NavigationMode.gesture;
      case 'three_button':
        return NavigationMode.threeButton;
      case 'two_button':
        return NavigationMode.twoButton;
      default:
        return NavigationMode.unknown;
    }
  }

  /// 返回 gesture/three_button/two_button/unknown
  static Future<NavigationMode> getNavigationMode() async {
    final String? mode = await _ch.invokeMethod<String>('getNavigationMode');
    return _parse(mode);
  }

  /// 是否手势导航（true/false）
  static Future<bool> isGestureNavigation() async {
    final bool? v = await _ch.invokeMethod<bool>('isGestureNavigation');
    return v ?? false;
  }
}
