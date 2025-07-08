import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_add_controller.dart';
import 'package:alpaca/widgets/widget_image_picker.dart';
import 'package:alpaca/widgets/widget_location_picker.dart';
import 'package:alpaca/widgets/widget_permission_selector.dart';

class MomnetAddPage extends GetView<MomentAddController> {
  static const routeName = "/moment_add";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发表朋友圈'),
        actions: [
          Obx(() {
            return TextButton(
              onPressed: controller.isPublishable() ? controller.publish : null,
              child: Text(
                '发表',
                style: TextStyle(
                  color:
                      controller.isPublishable() ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 文本输入框
            _buildTextInputField(),

            const SizedBox(height: 16.0),

            // 图片添加区域
            _buildImagePickerSection(),

            const SizedBox(height: 16.0),

            // 定位选择区域
            _buildLocationPickerSection(),

            const SizedBox(height: 16.0),

            // 权限设置区域
            _buildPermissionSelectorSection(),

            const SizedBox(height: 80.0), // 底部留白
          ],
        ),
      ),
    );
  }

  // 文本输入框组件
  Widget _buildTextInputField() {
    return TextField(
      maxLines: 8,
      maxLength: 300,
      decoration: InputDecoration(
        hintText: '说点什么...',
        counterText: '${controller.textLength.value}/300',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: controller.updateText,
    );
  }

  // 图片选择组件
  Widget _buildImagePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '图片(最多9张)',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        ImagePickerWidget(
          selectedImages: controller.selectedImages,
          onImageAdded: controller.addImage,
          onImageRemoved: controller.removeImage,
        ),
      ],
    );
  }

  // 定位选择组件
  Widget _buildLocationPickerSection() {
    return LocationPickerWidget(
      currentLocation: controller.currentLocation,
      onLocationSelected: controller.updateLocation,
    );
  }

  // 权限选择组件
  Widget _buildPermissionSelectorSection() {
    return PermissionSelectorWidget(
      currentPermission: controller.currentPermission,
      onPermissionChanged: (permission) {
        // 将 Permission 转换为 String 后更新控制器
        controller.updatePermission(permission.index.toString());
      },
    );
  }
}
