import 'package:get/get.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/tools/tools_storage.dart';
// 导入 material.dart 库
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';
import 'package:alpaca/widgets/widget_image_picker.dart'; // 导入图片选择组件的控制器
import 'package:alpaca/request/request_moment.dart';

class MomentAddController extends GetxController {
  // 文本输入控制器
  final Rx<String> _text = ''.obs;
  String get text => _text.value;
  set text(String value) => _text.value = value;
  RxInt textLength = 0.obs;

  LocalUser localUser = ToolsStorage().local();

  // 获取 ImagePickerController 实例
  final ImagePickerController imageController =
      Get.find<ImagePickerController>();

  // 图片选择控制器
  // 图片选择控制器（改为 XFile 类型）
  final RxList<XFile> _selectedImages = <XFile>[].obs;
  List<XFile> get selectedImages => _selectedImages.value; // 返回 XFile 列表

  // 定位选择控制器
  final Rx<String> _currentLocation = ''.obs; // 位置信息
  final Rx<String> _currentLocationla = ''.obs; // 坐标
  String get currentLocation => _currentLocation.value;
  void updateLocation(String location) => _currentLocation.value = location;
  String get currentLocationla => _currentLocationla.value;
  void updateLocationla(String locationla) =>
      _currentLocationla.value = locationla;

  // 权限选择控制器
  // 关键：使用 Rx<String> 并通过 .obs 初始化
  final Rx<String> _currentPermission = '好友可见'.obs;

  //  getter 方法应返回 _currentPermission.value
  String get currentPermission => _currentPermission.value;

  String momId = generate20DigitRandomNumber();

  //  更新方法应修改 _currentPermission.value
  void updatePermission(String permission) {
    _currentPermission.value = permission;
  }

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
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );

    LocalUser localUser = ToolsStorage().local();
    print('发布到这里了');
    // 创建朋友圈模型
    try {
      // 创建朋友圈模型
      final moment = FriendMomentModel(
          content: text,
          userId: int.parse(localUser.userId),
          //images: selectedImages,
          location: currentLocation + '|' + currentLocationla,
          visibility: getPermissionValue(currentPermission),
          createTime: DateTime.now(),
          updateTime: DateTime.now(),
          isDeleted: 0);
      print('发布到这里了');

      print(moment.toJson());
      // 构建附件库模型
      //final List<FriendMediaResourceModel> media = [];
      // 从 ImagePickerController 中获取 selectedImages
      final selectedImages = imageController.getSelectedMediasInfo;
      final List<Media> getselectedImagesinfo =
          imageController.getSelectedMediasInfo;

      final moments = MomentModel(
          content: moment.content,
          userId: moment.userId,
          location: moment.location,
          visibility: moment.visibility,
          images: getselectedImagesinfo);

      // 调用发表服务
      bool post = await RequestMoment.postMoment(moments);
      if (post) {
        // 发表成功，返回上一页
        Get.offNamed('/moment_index');
        Get.showSnackbar(
          GetSnackBar(
            title: '成功',
            message: '你的朋友圈已发表',
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
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

  // 新增的判断方法
  int getPermissionValue(String permission) {
    switch (permission) {
      case '完全公开':
        return 0;
      case '好友可见':
        return 1;
      case '仅自己可见':
        return 2;
      default:
        return 3; // 隐私及保留
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}

// 生成20位随机数，且首位不为0
String generate20DigitRandomNumber() {
  Random random = Random();
  // 生成首位，范围是 1 到 9
  int firstDigit = random.nextInt(9) + 1;

  // 生成剩余的 19 位数字
  String remainingDigits = '';
  for (int i = 0; i < 18; i++) {
    // 生成 0 到 9 的随机数字
    int digit = random.nextInt(10);
    remainingDigits += digit.toString();
  }

  // 拼接首位和剩余的 19 位数字
  return firstDigit.toString() + remainingDigits;
}
