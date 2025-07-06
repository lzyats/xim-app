import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletAuthController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  // 人像面
  String identity1 = '';
  // 国徽面
  String identity2 = '';
  // 手持身份证
  String holdCard = '';
  // 上传
  void image(int index, String image) {
    if (index == 1) {
      identity1 = image;
    } else if (index == 2) {
      identity2 = image;
    } else {
      holdCard = image;
    }
    update();
  }

  Future<void> editAuth() async {
    String name = nameController.text.trim();
    String idCard = idCardController.text.trim();
    // 执行
    await RequestMine.editAuth(name, idCard, identity1, identity2, holdCard);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('提交成功，等待平台审核');
    // 返回
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    idCardController.dispose();
    super.onClose();
  }
}
