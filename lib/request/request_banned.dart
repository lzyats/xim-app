import 'package:alpaca/tools/tools_request.dart';

// 封禁接口
class RequestBanned {
  static String get _prefix => '/banned';

  // 查询详情
  static Future<BannedModel> getInfo() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getInfo',
    );
    // 转换
    return ajaxData.getData((data) => BannedModel.fromJson(data));
  }

  // 申请解封
  static Future<void> appeal(List<String> images, String content) async {
    // 执行
    await ToolsRequest().post('$_prefix/appeal', data: {
      'images': images,
      'content': content,
    });
  }
}

class BannedModel {
  String banned;
  String bannedLabel;
  String reason;
  int remain;
  String explain;

  BannedModel(
    this.banned,
    this.bannedLabel,
    this.reason,
    this.remain,
    this.explain,
  );

  factory BannedModel.fromJson(Map<String, dynamic>? data) {
    return BannedModel(
      data?['banned'] ?? '',
      data?['bannedLabel'] ?? '',
      data?['reason'] ?? '',
      int.parse(data?['remain'] ?? '0'),
      data?['explain'] ?? '',
    );
  }
}
