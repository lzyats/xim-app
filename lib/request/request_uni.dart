import 'package:alpaca/tools/tools_request.dart';

// 小程序接口
class RequestUni {
  static String get _prefix => '/uni';

  // 获取列表
  static Future<List<MiniModel01>> getList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/list',
    );
    // 转换
    return ajaxData.getList((data) => MiniModel01.fromJson(data));
  }
}

class MiniModel01 {
  String appId;
  String name;
  String icon;
  int version;
  String path;
  String type;

  MiniModel01(
    this.appId,
    this.name,
    this.icon,
    this.version,
    this.path,
    this.type,
  );

  factory MiniModel01.fromJson(Map<String, dynamic>? data) {
    return MiniModel01(
      data?['appId'] ?? '',
      data?['name'] ?? '',
      data?['icon'] ?? '',
      int.parse(data?['version'] ?? 0),
      data?['path'] ?? '',
      data?['type'] ?? '',
    );
  }
}
