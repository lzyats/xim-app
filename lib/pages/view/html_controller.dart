import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HtmlController extends GetxController {
  late String roulekey;
  late Rx<RichText> title = RichText(text: const TextSpan()).obs;
  late RxString htmlContent = '载入中........'.obs; // 用于存储HTML内容，支持响应式更新
  late RxInt jump = 0.obs;
  late RxString url = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // 获取页面传入的roulekey参数
    roulekey = Get.arguments ?? '';
    if (roulekey.isNotEmpty) {
      _fetchHtmlContent();
    } else {
      htmlContent.value = '参数错误：缺少roulekey';
    }
  }

  // 调用API获取HTML内容
  Future<void> _fetchHtmlContent() async {
    // 调用请求工具获取数据（假设返回格式为Map，包含html字段）
    final SysHtml result = await RequestCommon.getHtml(roulekey);
    htmlContent.value = result.html;
    title.value = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: result.remake!,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
    try {
      // 调用请求工具获取数据（假设返回格式为Map，包含html字段）
      final SysHtml result = await RequestCommon.getHtml(roulekey);
      htmlContent.value = result.html;
      if (result.url == null || result.url.isEmpty) {
        jump.value = 0;
      } else {
        jump.value = 1;
        url.value = result.url;
      }
      title.value = RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: result.remake!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      htmlContent.value = '加载失败：${e.toString()}';
      debugPrint(e.toString());
    }
  }
}
