import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

/// 浮窗权限工具类（仅支持 Android）
class ToolsOverlay {
  // 定义常量通道名（避免硬编码）
  static const MethodChannel _channel = MethodChannel('lansoft.com/overlay');

  /// 检查是否拥有浮窗权限
  static Future<bool> checkPermission() async {
    if (!Platform.isAndroid) {
      _log('iOS 不支持浮窗权限检查');
      return false;
    }

    try {
      final result =
          await _channel.invokeMethod<bool>('checkOverlayPermission');
      _log('浮窗权限检查结果: ${result ?? false}');
      return result ?? false;
    } on PlatformException catch (e) {
      _log('权限检查失败: ${e.code} - ${e.message}');
      return false;
    } catch (e) {
      _log('权限检查异常: $e');
      return false;
    }
  }

  /// 请求浮窗权限（返回用户是否最终授予权限）
  static Future<bool> requestPermission({
    required BuildContext context,
    String? rationaleMessage, // 权限申请理由提示
  }) async {
    if (!Platform.isAndroid) {
      _showAlert(context, '提示', 'iOS 系统不支持浮窗功能');
      return false;
    }

    // 先检查是否已授权
    final hasPermission = await checkPermission();
    if (hasPermission) {
      return true;
    }

    // 显示权限申请理由（可选）
    if (rationaleMessage != null) {
      final confirm = await _showRationaleDialog(context, rationaleMessage);
      if (!confirm) {
        return false; // 用户取消申请
      }
    }

    // 调用原生方法跳转设置页
    try {
      await _channel.invokeMethod('requestOverlayPermission');
      // 跳转设置页后，等待用户操作并重新检查权限
      return await _waitForPermissionChange();
    } on PlatformException catch (e) {
      _log('请求权限失败: ${e.code} - ${e.message}');
      _showAlert(context, '错误', '无法打开权限设置页面: ${e.message}');
      return false;
    } catch (e) {
      _log('请求权限异常: $e');
      _showAlert(context, '错误', '请求浮窗权限时发生异常');
      return false;
    }
  }

  /// 等待用户在设置页操作后检查权限变化（最多等待30秒）
  static Future<bool> _waitForPermissionChange() async {
    final completer = Completer<bool>();
    int checkCount = 0;

    // 每1秒检查一次权限，最多30次
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      checkCount++;
      checkPermission().then((hasPermission) {
        if (hasPermission || checkCount >= 30) {
          timer.cancel();
          completer.complete(hasPermission);
        }
      });
    });

    return completer.future;
  }

  /// 显示权限申请理由对话框
  static Future<bool> _showRationaleDialog(
    BuildContext context,
    String message,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('需要浮窗权限'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('去设置'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// 显示提示对话框
  static void _showAlert(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  /// 日志输出（仅在调试模式）
  static void _log(String message) {
    if (kDebugMode) {
      debugPrint('[OverlayPermission] $message');
    }
  }
}
