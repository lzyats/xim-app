import 'package:get/get.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/tools/tools_storage.dart';
// 导入 material.dart 库
import 'package:flutter/material.dart';

class MomentAddController extends GetxController {
  // 文本输入控制器
  final Rx<String> _text = ''.obs;
  String get text => _text.value;
  set text(String value) => _text.value = value;
  RxInt textLength = 0.obs;

  LocalUser localUser = ToolsStorage().local();

  // 图片选择控制器
  final RxList<String> _selectedImages = <String>[].obs;
  List<String> get selectedImages => _selectedImages.value;
  void addImage(String imagePath) => _selectedImages.add(imagePath);
  void removeImage(int index) => _selectedImages.removeAt(index);

  // 定位选择控制器
  final Rx<String> _currentLocation = ''.obs;
  String get currentLocation => _currentLocation.value;
  void updateLocation(String location) => _currentLocation.value = location;

  // 权限选择控制器
  final Rx<String> _currentPermission = '好友可见'.obs;
  String get currentPermission => _currentPermission.value;
  void updatePermission(String permission) =>
      _currentPermission.value = permission;

  // 更新文本内容并计算长度
  void updateText(String value) {
    text = value;
    textLength.value = value.length;
  }

  // 检查是否可以发表
  bool isPublishable() {
    return text.isNotEmpty || selectedImages.isNotEmpty;
  }

  // 发表朋友圈
  Future<void> publish() async {
    // 显示加载状态
    Get.showSnackbar(
      GetSnackBar(
        title: '发表中',
        message: '正在发布你的朋友圈...',
        duration: Duration(seconds: 5),
      ),
    );

    try {
      LocalUser localUser = ToolsStorage().local();
      // 创建朋友圈模型
      final moment = FriendMomentModel(
        content: text,
        userId: int.parse(localUser.userId),
        //images: selectedImages,
        location: currentLocation,
        visibility: int.parse(currentPermission),
        createTime: DateTime.now(),
      );

      // 调用发表服务
      //await MomentService.publishMoment(moment);

      // 发表成功，返回上一页
      Get.back(result: true);
      Get.showSnackbar(
        GetSnackBar(
          title: '成功',
          message: '你的朋友圈已发表',
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // 发表失败
      Get.showSnackbar(
        GetSnackBar(
          title: '错误',
          message: '发表失败，请重试',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      print('发表失败: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 初始化时获取当前定位（可选）
    //_getCurrentLocation();
  }

  /* // 获取当前定位
  Future<void> _getCurrentLocation() async {
    try {
      final location = await LocationService.getCurrentLocation();
      if (location.isNotEmpty) {
        updateLocation(location);
      }
    } catch (e) {
      print('获取定位失败: $e');
    }
  } */
}
