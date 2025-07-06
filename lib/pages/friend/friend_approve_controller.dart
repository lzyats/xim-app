import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/tools/tools_submit.dart';

class FriendApproveController extends BaseController {
  TextEditingController remarkController = TextEditingController();

  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestFriend.applyList(1),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestFriend.applyList(refreshPageIndex + 1),
    );
  }

  // 申请同意
  Future<void> agree(String applyId) async {
    String remark = remarkController.text.trim();
    await RequestFriend.applyAgree(applyId, remark);
    // 刷新
    _update(applyId, '2');
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  void _update(String applyId, String status) {
    FriendModel02 model = refreshList.firstWhere(
      (data) => data.applyId == applyId,
    );
    model.status = status;
    update();
  }

  // 申请拒绝
  Future<void> reject(String applyId) async {
    await RequestFriend.applyReject(applyId);
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
    await RequestFriend.applyDelete(applyId);
    // 删除
    FriendModel02 model = refreshList.firstWhere(
      (data) => data.applyId == applyId,
    );
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

  @override
  void onClose() {
    remarkController.dispose();
    super.onClose();
  }
}
