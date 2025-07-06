import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_upgrade.dart';

// 公共接口
class RequestCommon {
  static String get _prefix => '/common';

  // 帮助中心
  static Future<List<CommonModel01>> getHelpList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getHelpList',
    );
    // 转换
    return ajaxData.getList((data) => CommonModel01.fromJson(data));
  }

  // 建议反馈
  static Future<void> feedback(List<String> images, String content) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/feedback',
      data: {
        'images': images,
        'content': content,
      },
    );
    // 提醒
    EasyLoading.showToast('提交成功');
  }

  // 通知公告
  static Future<List<CommonModel02>> getNoticeList(int pageNum) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/getNoticeList',
      pageNum,
    );
    // 转换
    return ajaxData.getList((data) => CommonModel02.fromJson(data));
  }

  // 获取上传凭证
  static Future<Map<String, dynamic>> getUploadToken() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getUploadToken',
    );
    // 转换
    return ajaxData.getJson();
  }

  // 文件上传
  static Future<String> upload(MultipartFile multipartFile) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().upload(
      '$_prefix/upload',
      multipartFile,
    );
    // 转换
    Map<String, dynamic> result = ajaxData.getJson();
    return result['filePath'];
  }

  // 检查更新
  static Future<void> upgrade({bool force = false}) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/upgrade',
      showError: false,
    );
    // 转换
    _CommonModel03 model =
        ajaxData.getData((data) => _CommonModel03.fromJson(data));
    // 取消
    ToolsSubmit.cancel();
    // 取消
    if (!force && 'N' == model.upgrade) {
      return;
    }
    // 弹出升级
    WidgetUpgrade(
      version: model.version,
      url: model.url,
      content: model.content,
      force: model.force,
    );
  }

  // 转换音频
  static Future<String> audio2Text(String msgId) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/audio2Text/$msgId',
    );
    // 转换
    return ajaxData.getData((data) => data);
  }

  // 获取配置
  static Future<void> getConfig() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getConfig',
      showError: false,
    );
    // 转换
    LocalConfig localConfig =
        ajaxData.getData((data) => LocalConfig.fromJson(data));
    // 存储
    ToolsStorage().config(value: localConfig);
    // 设置
    EventSetting().event.add(SettingModel(SettingType.sys));
  }
}

class CommonModel01 {
  String label;
  String value;

  CommonModel01(
    this.label,
    this.value,
  );

  factory CommonModel01.fromJson(Map<String, dynamic>? data) {
    return CommonModel01(
      data?['label'] ?? '',
      data?['value'] ?? '',
    );
  }
}

class CommonModel02 {
  String title;
  String content;
  String createTime;

  CommonModel02(
    this.title,
    this.content,
    this.createTime,
  );

  factory CommonModel02.fromJson(Map<String, dynamic>? data) {
    return CommonModel02(
      data?['title'] ?? '',
      data?['content'] ?? '',
      data?['createTime'] ?? '',
    );
  }
}

class _CommonModel03 {
  String upgrade;
  String version;
  String url;
  String content;
  String force;

  _CommonModel03(
    this.upgrade,
    this.version,
    this.url,
    this.content,
    this.force,
  );

  static _CommonModel03 fromJson(Map<String, dynamic>? data) {
    return _CommonModel03(
      data?['upgrade'],
      data?['version'],
      data?['url'],
      data?['content'],
      data?['force'],
    );
  }
}
