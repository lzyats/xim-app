import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_collect.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class MineCollectController extends BaseController
    with GetTickerProviderStateMixin {
  // 类型
  List<TDTab> tabs = [
    const TDTab(
      text: '全部',
      size: TDTabSize.large,
    ),
    const TDTab(
      text: '文本',
      size: TDTabSize.large,
    ),
    const TDTab(
      text: '图片',
      size: TDTabSize.large,
    ),
    const TDTab(
      text: '视频',
      size: TDTabSize.large,
    ),
    const TDTab(
      text: '名片',
      size: TDTabSize.large,
    ),
    const TDTab(
      text: '文件',
      size: TDTabSize.large,
    ),
  ];
  // 选择
  MsgType? msgType;
  // 控制
  late TabController tabController;
  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestCollect.list(1, msgType),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestCollect.list(refreshPageIndex + 1, msgType),
    );
  }

  // 删除
  Future<void> remove(CollectModel collectModel) async {
    // 执行
    await RequestCollect.remove(collectModel.collectId);
    // 更新
    refreshList.remove(collectModel);
    update();
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('删除成功');
  }

  // 更新
  updateType(MsgType? type) async {
    // 更新
    msgType = type;
    // 刷新
    onRefresh();
  }

  @override
  void onInit() {
    super.onInit();
    // 控制
    tabController = TabController(length: tabs.length, vsync: this);
    // 刷新
    onRefresh();
  }
}
