import 'package:flutter/material.dart';

// 页面整体样式
class AppTheme {
  // 主题
  static final ThemeData theme = ThemeData(
    // 主题明暗风格
    brightness: Brightness.light,
    // 主要颜色
    primaryColor: Colors.white,
    // 次要颜色
    hintColor: AppTheme.color,
    // 背景色
    scaffoldBackgroundColor: Colors.white,
    // 卡片主题
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateColor.resolveWith((states) {
        // 开启状态
        if (states.contains(WidgetState.selected)) {
          return AppTheme.color;
        }
        // 关闭状态
        return Colors.white;
      }),
    ),
    switchTheme: SwitchThemeData(
      // 填充颜色
      trackColor: WidgetStateColor.resolveWith((states) {
        // 开启状态
        if (states.contains(WidgetState.selected)) {
          return AppTheme.color;
        }
        // 关闭状态
        return Colors.grey[400] ?? Colors.grey;
      }),
      // 边框颜色
      trackOutlineColor: WidgetStateColor.resolveWith((states) {
        return Colors.transparent;
      }),
      // 中心颜色
      thumbColor: WidgetStateColor.resolveWith((states) {
        return Colors.white;
      }),
    ),
    // 按钮主题
    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      height: 50.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      textTheme: ButtonTextTheme.primary,
    ),
    // 输入框
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[200],
      labelStyle: const TextStyle(color: Colors.black),
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: Colors.grey),
      focusColor: Colors.grey,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.grey,
    ),
    // appBar
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      backgroundColor: Color.fromARGB(255, 241, 238, 238),
    ),
    // 图标样式
    iconTheme: const IconThemeData(
      size: 24.0,
      fill: 0.0,
      weight: 400.0,
      grade: 0.0,
      opticalSize: 48.0,
      color: Colors.black,
      opacity: 0.8,
    ),
    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppTheme.color,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
    ),
    // colorScheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppTheme.color,
      // 影响 card 的表色，因为 M3 下是  applySurfaceTint ，在 Material 里
      surfaceTint: Colors.transparent,
    ),
  );

  // 颜色
  static Color color = Colors.indigoAccent[400] ?? Colors.blue;
}
