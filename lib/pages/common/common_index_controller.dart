import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:restart_app/restart_app.dart';

class CommonSoftwareController extends BaseController {
  // 分享地址
  String sharePath = ToolsStorage().config().sharePath;
  // 消息声音
  RxString audio = ToolsStorage().setting().audio.obs;
  // 消息通知
  RxString notice = ToolsStorage().setting().notice.obs;
  // 消息通知
  RxString nav = ToolsStorage().setting().nav.obs;
  // 消息声音
  editAudio(bool value) {
    // 刷新
    audio.value = value ? 'Y' : 'N';
    // 更新
    _setting('audio', audio.value);
  }

  // 消息通知
  editNotice(bool value) {
    // 刷新
    notice.value = value ? 'Y' : 'N';
    // 更新
    _setting('notice', notice.value);
  }

  // 传统导航
  editNav(bool value) {
    // 刷新
    nav.value = value ? 'Y' : 'N';
    // 更新
    _setting('nav', nav.value);
  }

  // 消息设置
  _setting(String label, String value) {
    // 更新
    ToolsStorage()
        .setting(value: ChatConfig(audio.value, notice.value, nav.value));
    // 更新
    ToolsSqlite().config.update(label, value);
  }

  /// 新增：处理服务线路配置存储逻辑
  /// [newConfig]：待存储的新服务配置（含HTTP/WS地址）
  /// [routeName]：选中线路的名称
  Future<void> saveRouteConfig(SysConfig newConfig, String routeName) async {
    try {
      // 1. 等待存储操作完全完成（关键！）
      await ToolsStorage().sysConfig(value: newConfig);
      print(newConfig.toJson().toString());

      // 2. 提示用户（延迟3秒，确保用户看到提示）
      EasyLoading.showSuccess('服务器配置成功，将在3秒后重启动生效');
      await Future.delayed(const Duration(seconds: 3));

      // 3. 执行请求重置（使新配置生效）
      //ToolsRequest.reset();
      Restart.restartApp(); // 如需重启App可取消注释（需导入对应包）
    } catch (e) {
      // 捕获存储异常，避免崩溃
      EasyLoading.showError('配置存储失败，请重试');
      debugPrint('存储配置错误：$e');
    }
  }
}
