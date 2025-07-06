import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';

/// 防止重复提交
class ToolsSubmit {
  // 单例模式
  ToolsSubmit._() {
    ever(
      _counter,
      (_) async {
        // 状态变化
        _status.value = false;
      },
    );
  }
  static ToolsSubmit? _singleton;
  factory ToolsSubmit() => _singleton ??= ToolsSubmit._();
  // 计数变化
  final _counter = 0.obs;
  // 状态变化
  final _status = true.obs;

  // 状态
  static bool progress() {
    return ToolsSubmit()._status.isFalse;
  }

  // 显示遮罩
  static void show({
    int millisecond = 5000,
    bool dismissOnTap = false,
  }) {
    EasyLoading.show(
      indicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.color), // 设置颜色为蓝色
        backgroundColor: Colors.grey, // 设置背景颜色为灰色
      ),
      dismissOnTap: dismissOnTap,
    );
    // 定时任务
    Future.delayed(Duration(milliseconds: millisecond), () {
      ToolsSubmit.dismiss();
      // 状态变化
      ToolsSubmit()._status.value = true;
    });
  }

  // 关闭遮罩
  static void dismiss() {
    // 关闭弹窗
    EasyLoading.dismiss();
  }

  // 执行
  static bool call({
    int millisecond = 5000,
    bool dismissOnTap = false,
  }) {
    // 不能点击
    if (progress()) {
      return false;
    }
    // 打开遮罩
    show(
      millisecond: millisecond,
      dismissOnTap: dismissOnTap,
    );
    // 修改状态
    ToolsSubmit()._counter.value++;
    return true;
  }

  // 取消执行
  static void cancel() {
    // 关闭弹窗
    EasyLoading.dismiss();
    // 状态变化
    ToolsSubmit()._status.value = true;
  }
}
