import 'package:alpaca/request/request_mine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_storage.dart'; // 假设包含本地用户信息存储

class MineAvatarController extends GetxController {
  // 头像列表（响应式）
  final RxList<String> avatarList = <String>[].obs;
  // 加载状态（响应式：true=加载中，false=加载完成/失败）
  final RxBool isLoading = true.obs;
  // 选中索引
  final RxInt selectedIndex = (-1).obs;

  LocalUser localUser = ToolsStorage().local();

  @override
  void onInit() {
    super.onInit();
    // 初始化时请求数据
    fetchAvatarList();
  }

  // 网络请求头像列表
  Future<void> fetchAvatarList() async {
    isLoading.value = true; // 开始加载
    try {
      // 调用接口获取头像列表（假设使用之前的RequestMine.getAva()）
      final list = await RequestMine.getAva();
      avatarList.assignAll(list);
      // 如果有默认选中项，可在此处设置

      if (list.isNotEmpty) {
        // 遍历列表，找到与localUser.portrait匹配的头像索引
        final defaultIndex = list.indexOf(localUser.portrait);
        // 如果找到匹配项，设置为选中索引；否则默认选中第0项
        selectedIndex.value = defaultIndex != -1 ? defaultIndex : 0;
      }
    } catch (e) {
      debugPrint('获取头像列表失败：$e');
      // 可添加错误提示
      Get.showSnackbar(const GetSnackBar(
        title: '提示',
        message: '加载头像失败，请重试',
        duration: Duration(seconds: 2),
      ));
    } finally {
      isLoading.value = false; // 结束加载
    }
  }

  // 选择头像
  void selectAvatar(int index) {
    selectedIndex.value = index;
  }

  // 确认选择
  void confirmSelection() {
    if (selectedIndex.value == -1) {
      Get.showSnackbar(const GetSnackBar(
        message: '请选择一个头像',
        duration: Duration(seconds: 2),
      ));
      return;
    }
    // 这里添加确认逻辑（如返回上一页并传递选中的头像URL）
    Get.back(result: avatarList[selectedIndex.value]);
  }
}
