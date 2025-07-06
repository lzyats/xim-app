import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupApproveController extends BaseController {
  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestGroup.applyList(1),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestGroup.applyList(refreshPageIndex + 1),
    );
  }

  // 申请同意
  Future<void> agree(String applyId) async {
    await RequestGroup.applyAgree(applyId);
    // 刷新
    _update(applyId, '2');
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  void _update(String applyId, String status) {
    GroupModel01 model =
        refreshList.firstWhere((data) => data.applyId == applyId);
    model.status = status;
    update();
  }

  // 申请拒绝
  Future<void> reject(String applyId) async {
    await RequestGroup.applyReject(applyId);
    // 刷新
    _update(applyId, '3');
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 删除
  Future<void> delete(String applyId) async {
    // 请求
    await RequestGroup.applyDelete(applyId);
    // 删除
    GroupModel01 model =
        refreshList.firstWhere((data) => data.applyId == applyId);
    refreshList.remove(model);
    // 更新
    update();
    // 取消
    ToolsSubmit.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }
}
