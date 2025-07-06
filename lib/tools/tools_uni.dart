import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

// 小程序组件
class ToolsUni {
  ToolsUni._();
  static ToolsUni? _singleton;
  factory ToolsUni() => _singleton ??= ToolsUni._();

  static const MethodChannel _channel = MethodChannel('flutter_uni_channel');
  static const EventChannel _stream = EventChannel('flutter_uni_stream');

  static StreamController? _controller;
  static Stream<dynamic>? _streamInstance;

  Stream<dynamic>? get stream {
    if (_streamInstance == null) {
      _controller = StreamController.broadcast();
      _streamInstance = _controller!.stream;
      _stream.receiveBroadcastStream().listen((event) {
        _controller!.add(event);
      }, onError: (err) {
        _controller!.addError(err);
      });
    }
    return _streamInstance;
  }

  /// 监听uniMPSDK
  Future<dynamic> listen({void Function(dynamic)? receive}) async {
    stream?.listen((event) async {
      if (receive != null) {
        receive(event);
      }
    }, onError: (err) {
      print('Error occurred: $err');
    });
  }

  /// 初始化uniMPSDK
  Future<dynamic> _init() async {
    final result = await _channel.invokeMethod('initMP');
    return result;
  }

  /// 获取UniMP版本
  Future<int> _version({required String appId}) async {
    final result = await _channel.invokeMethod('versionMP', {'appId': appId});
    print(result);
    return result['code'];
  }

  /// 下载UniMP新版
  Future<String> _download({
    required String appId,
    required String path,
  }) async {
    String wgtPath;
    try {
      // 获取缓存目录
      final directory = await getTemporaryDirectory();
      wgtPath = '${directory.path}/${const Uuid().v8()}.wgt';
      await Dio().download(path, wgtPath);
    } catch (e) {
      throw Exception('获取新包失败，请稍后重试');
    }
    return wgtPath;
  }

  /// 安装 UniMP 小程序
  Future<dynamic> _install({
    required String appId,
    required String wgtPath,
  }) async {
    final result = await _channel
        .invokeMethod('installMP', {'appId': appId, "wgtPath": wgtPath});
    return result;
  }

  /// 打开指定的 UniMP 小程序
  Future<dynamic> openMp({
    required String appId,
    Map<String, dynamic>? data,
  }) async {
    final result = await _channel.invokeMethod('openMP', {
      'appId': appId,
      'config': data ?? {},
    });
    return result;
  }

  /// 关闭指定的 UniMP 小程序
  Future<dynamic> close({required String appId}) async {
    final result = await _channel.invokeMethod('closeMP', {'appId': appId});
    return result;
  }

  /// 隐藏指定的 UniMP 小程序
  Future<dynamic> hide({required String appId}) async {
    final result = await _channel.invokeMethod('hideMP', {'appId': appId});
    return result;
  }

  /// 发送数据到指定的UniMP小程序
  Future<dynamic> send({
    required String appId,
    required String event,
    Map<String, dynamic>? data,
  }) async {
    final result = await _channel.invokeMethod('sendMP', {
      'appId': appId,
      'event': event,
      'data': data ?? {},
    });
    return result;
  }

  /// 回调数据到到指定的UniMP小程序
  Future<dynamic> callback({
    required String appId,
    required String event,
    Map<String, dynamic>? data,
  }) async {
    final result = await _channel.invokeMethod('callbackMP', {
      'appId': appId,
      'event': event,
      'data': data ?? {},
    });
    return result;
  }

  /// 打开小程序
  Future<void> open({
    required String appId,
    required int version,
    required String path,
    Map<String, dynamic>? data,
  }) async {
    // 初始化
    await _init();
    // 获取版本
    int code = await _version(appId: appId);
    // 比较版本
    if (code != version) {
      // 下载新包
      String wgtPath = await _download(appId: appId, path: path);
      // 安装新包
      await _install(appId: appId, wgtPath: wgtPath);
      // 关闭
      await close(appId: appId);
    }
    // // 打开
    await openMp(appId: appId, data: data);
    // 取消
    ToolsSubmit.cancel();
  }
}
