import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';

// 本地角标
class ToolsBadger {
  ToolsBadger._();
  static ToolsBadger? _singleton;
  factory ToolsBadger() => _singleton ??= ToolsBadger._();
  // 存储对象
  final GetStorage _storage1 = GetStorage();
  final GetStorage _storage2 = GetStorage();
  final GetStorage _storage3 = GetStorage();
  final String _badger = 'badger';
  final String _total = 'total_badger';

  // 清空
  clear() {
    _storage1.remove(_badger);
    // 计算
    _storage2.write(_total, 0);
  }

  // 重置
  reset(String key) {
    // 读取
    Map<String, dynamic> dataList = _storage1.read(_badger) ?? {};
    // 重置
    dataList.remove(key);
    // 写入
    _storage1.write(_badger, dataList);
    // 计算
    calculate(reset: true);
  }

  // 设置
  set(String key, int value) {
    // 读取
    Map<String, dynamic> dataList = _storage1.read(_badger) ?? {};
    // 重置
    dataList.addAll({key: value});
    // 写入
    _storage1.write(_badger, dataList);
  }

  // 获取
  get(String key) {
    // 读取
    Map<String, dynamic> dataList = _storage1.read(_badger) ?? {};
    // 获取
    return dataList[key] ?? 0;
  }

  // 增加
  increment(String chatId) {
    // 获取
    int value = get(chatId) + 1;
    // 计算
    calculate(step: 1);
    // 设置
    return set(chatId, value);
  }

  // 减去
  subtraction(String chatId) {
    int value = get(chatId) - 1;
    if (value < 0) {
      value = 0;
    }
    // 计算
    calculate(step: value);
    // 设置
    return set(chatId, value < 0 ? 0 : value);
  }

  // 校验
  bool validaMsgId(String msgId) {
    // 读取
    Map<String, dynamic> dataList = _storage3.read('msgId') ?? {};
    if (dataList.containsKey(msgId)) {
      return false;
    }
    // 重置
    dataList.addAll({msgId: msgId});
    // 写入
    _storage3.write('msgId', dataList);
    return true;
  }

  // 计算
  calculate({bool reset = false, int step = 0}) {
    // 结果
    int total = 0;
    // 重新计算
    if (reset) {
      Map<String, dynamic> dataList = _storage1.read(_badger) ?? {};
      // 循环
      dataList.forEach((key, value) {
        int data = value;
        if (data > 0) {
          total += data;
        }
      });
    }
    //
    else {
      total = _storage2.read(_total) ?? 0;
      total += step;
    }
    // 存储
    _storage2.write(_total, total);
  }

  // 监听变化
  listen(ValueSetter callback) {
    _storage2.listenKey(_total, callback);
  }
}
