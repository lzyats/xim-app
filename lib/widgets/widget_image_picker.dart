import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  // 用于存储已选择的图片
  final selectedImages = <XFile>[].obs;

  // 添加图片到已选择列表
  void addImage(XFile image) {
    if (selectedImages.length < 9) {
      selectedImages.add(image);
    }
  }

  // 从已选择列表中移除图片
  void removeImage(XFile image) {
    selectedImages.remove(image);
  }
}

class ImagePickerWidget extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final ImagePicker _picker = ImagePicker();

  // 选择多张图片的方法
  // 选择多张图片的方法
  Future<void> _pickImages() async {
    try {
      // 调用 ImagePicker 的 pickMultiImage 方法选择多张图片
      final List<XFile> pickedImages = await _picker.pickMultiImage();

      // 计算还可以选择的图片数量
      int availableSlots = 9 - controller.selectedImages.length;

      if (pickedImages.isNotEmpty) {
        // 遍历选择的图片，将其添加到已选择列表中
        for (var image in pickedImages) {
          if (availableSlots > 0) {
            controller.addImage(image);
            availableSlots--;
          } else {
            // 当达到最大选择数量时，显示提示信息
            _showSnackBar('最多只能选择9张图片');
            break;
          }
        }
      }
    } catch (e) {
      // 处理图片选择出错的情况，显示错误信息
      _showSnackBar('图片选择出错: $e');
    }
  }

  // 显示 SnackBar 的方法
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // 构建已选择图片的 Widget
  Widget _buildSelectedImageWidget(XFile image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(image.path),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                controller.removeImage(image);
              },
            ),
          ),
        ),
      ],
    );
  }

  // 构建选择图片按钮的 Widget
  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _pickImages,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.grey[500]),
            Text('选择图片', style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<Widget> imageWidgets = [];

      // 添加已选择的图片
      for (var image in controller.selectedImages) {
        imageWidgets.add(_buildSelectedImageWidget(image));
      }

      // 添加选择图片按钮
      if (controller.selectedImages.length < 9) {
        imageWidgets.add(_buildAddImageButton());
      }

      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: imageWidgets,
      );
    });
  }
}
