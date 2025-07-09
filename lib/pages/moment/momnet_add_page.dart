import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_add_controller.dart';
import 'package:alpaca/widgets/widget_image_picker.dart';
import 'package:alpaca/widgets/widget_amap.dart';
import 'package:alpaca/pages/moment/widget_permission_selector.dart';
import 'package:alpaca/tools/tools_perms.dart';

// 修正类名拼写错误
class MomentAddPage extends GetView<MomentAddController> {
  static const routeName = "/moment_add";
  const MomentAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MomentAddController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('发表朋友圈'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Obx(() {
              return TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => states.contains(MaterialState.disabled)
                        ? Colors.grey
                        : Colors.green,
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                onPressed:
                    controller.isPublishable() ? controller.publish : null,
                child: const Text('发表'),
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextInputField(),
            const SizedBox(height: 16.0),
            _buildImagePickerSection(),
            const SizedBox(height: 16.0),
            _buildLocationPickerSection(),
            const SizedBox(height: 16.0),
            _buildPermissionSelectorSection(),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInputField() {
    return TextField(
      maxLines: 5,
      maxLength: 300,
      decoration: InputDecoration(
        hintText: '这一刻的想法......',
        counter: Obx(() => Text(
              '${controller.textLength.value}/300',
              style: TextStyle(color: Colors.grey),
            )),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (text) {
        controller.updateText(text);
        if (text.length > 300) {
          controller.updateText(text.substring(0, 300));
        }
        controller.textLength.value = text.length;
      },
    );
  }

  Widget _buildImagePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '图片(最多9张)',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        ImagePickerWidget(),
      ],
    );
  }

  Widget _buildLocationPickerSection() {
    return InkWell(
      onTap: () async {
        // 权限检查（假设ToolsPerms已正确定义）
        bool hasPermission = await ToolsPerms.location();
        if (!hasPermission) return;

        // 跳转到WidgetAmap页面
        final result = await Get.to(WidgetAmap(
          onTap: (pois, data) {
            if (pois != null) {
              // 使用空安全操作符确保title不为空
              String location = pois.title ?? '未知位置';
              double latitudes = pois.latLng?.latitude ?? 0;
              double longitudes = pois.latLng?.longitude ?? 0;
              controller.updateLocation(location);
              controller.updateLocationla(
                  latitudes.toString() + '|' + longitudes.toString());
            }
            Get.back();
          },
        ));
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // 位置图标（微信风格）
            const Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            const SizedBox(width: 8.0),

            // 位置文本（动态显示当前位置或提示文字）
            Obx(() => Text(
                  controller.currentLocation.isEmpty
                      ? '所在位置'
                      : controller.currentLocation,
                  style: TextStyle(
                    color: controller.currentLocation.isEmpty
                        ? Colors.grey
                        : Colors.black,
                  ),
                )),

            const Spacer(),

            // 箭头图标
            const Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionSelectorSection() {
    return InkWell(
      // 保留原有跳转逻辑
      onTap: () {
        Get.to(() => PermissionSelectionPage(
              currentPermission: controller.currentPermission,
              onPermissionSelected: (permission) {
                controller.updatePermission(permission);
              },
            ));
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // 蓝色小锁图标（微信风格）
            const Icon(
              Icons.lock,
              color: Colors.blue,
              size: 20,
            ),
            const SizedBox(width: 12),
            const Text(
              '谁可以看',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF333333),
              ),
            ),
            const Spacer(),
            Obx(() => Text(
                  controller.currentPermission,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF333333),
                  ),
                )),
            const SizedBox(width: 16),
            // 微信风格箭头
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF999999),
            ),
          ],
        ),
      ),
    );
  }
}
