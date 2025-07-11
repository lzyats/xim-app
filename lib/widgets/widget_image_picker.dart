import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:scan/scan.dart';
import 'package:video_compress/video_compress.dart';
import 'package:alpaca/tools/tools_upload.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:alpaca/tools/tools_comment.dart';

class ImagePickerController extends GetxController {
  // 用于存储已选择的图片
  final selectedImages = <XFile>[].obs;
  // 添加 getter 方法以便外部访问
  List<XFile> get getSelectedImages => selectedImages.value;

  // 用于存储已上传的图片
  final selectedImagesinfo = <FriendMediaResourceModel>[].obs;
  // 添加 getter 方法以便外部访问
  List<FriendMediaResourceModel> get getselectedImagesinfo =>
      selectedImagesinfo.value;

  // 添加图片到已选择列表
  void addImage(XFile image, FriendMediaResourceModel imageinfo) {
    if (selectedImages.length < 9) {
      selectedImages.add(image);
      selectedImagesinfo.add(imageinfo);
    }
  }

  // 从已选择列表中移除图片
  void removeImage(XFile image, FriendMediaResourceModel imageinfo) {
    selectedImages.remove(image);
    selectedImagesinfo.remove(imageinfo);
  }
}

class ImagePickerWidget extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  // 关键修改：在Get.put中传递momId参数
  final ImagePickerController controller = Get.put(ImagePickerController());
  // 选择多张图片的方法
  Future<void> _pickImages() async {
    // 权限
    // 1. 权限校验
    bool result = await ToolsPerms.photos();
    if (!result) {
      _showSnackBar('未获取相册权限，无法选择图片');
      return;
    }

    try {
      // 动态计算剩余可选数量
      int remainingSlots = 9 - controller.selectedImages.length;

      // 调用AssetPicker选择资源（支持图片/视频）
      List<AssetEntity>? dataList = await AssetPicker.pickAssets(
        AppConfig.navigatorKey.currentState!.context,
        pickerConfig: AssetPickerConfig(
          // 根据选择类型调整最大选择数量
          maxAssets: remainingSlots,
          requestType: RequestType.common,
          pathNameBuilder: (AssetPathEntity path) {
            return WidgetCommon.pathName(path);
          },
        ),
      );

      // 处理选择的资源列表
      if (dataList == null || dataList.isEmpty) return; // 无选择时提前退出

      // 检查是否有视频文件，如果有则只处理第一个视频
      bool hasVideo = false;
      for (var element in dataList) {
        if (element.type == AssetType.video) {
          hasVideo = true;
          break;
        }
      }

      if (hasVideo) {
        // 如果有视频，只处理第一个视频
        AssetEntity firstVideo =
            dataList.firstWhere((element) => element.type == AssetType.video);
        dataList = [firstVideo];
      }

      for (var element in dataList) {
        // 3.1 获取文件实体
        File? file = await element.file;
        if (file == null) continue; // 文件不存在时跳过

        // 3.2 识别资源类型
        AssetType assetType = element.type;
        String path = file.path;

        // 3.3 组装基础消息内容
        Map<String, dynamic> content = {
          'data': path,
          'thumbnail': path,
          'thumbnail1': path,
        };

        // 3.4 视频类型特殊处理
        if (assetType == AssetType.video) {
          // 更新消息类型
          MsgType msgType = MsgType.video;
          content['localPath'] = path;

          // 异步获取视频元数据
          content.addAll(await WidgetCommon.calculateVideo(path));

          // 生成视频缩略图
          File thumbFile = await VideoCompress.getFileThumbnail(path);

          content['thumbnail1'] = thumbFile.path;
          content['type'] = 1;

          // 上传视频缩略图
          String thumbnailUrl = await ToolsUpload.uploadFile(thumbFile.path);

          // 更新content中的thumbnail为上传后的URL
          content['thumbnail'] = thumbnailUrl;
        } else {
          // 计算图片尺寸
          Map<String, dynamic> imginfo =
              await WidgetCommon.calculateImage(path);
          print('图片信息：' + imginfo.toString());
          content.addAll(imginfo);
          content['type'] = 0;

          // 二维码识别（异步处理）
          content['scan'] = await Scan.parse(path);
        }

        // 3.6 组装消息模型并发布
        EventChatModel model = EventChatModel(
          ToolsStorage().chat(),
          assetType == AssetType.video ? MsgType.video : MsgType.image,
          content,
        );
        //EventMessage().listenSend.add(model);
        content['url'] = await ToolsUpload.uploadFile(path);

        // 3.7 更新选中图片列表（仅图片类型）
        XFile displayFile;
        if (assetType == AssetType.video) {
          // 确保这里使用正确的缩略图 URL
          String thumbnailUrl = content['thumbnail1'] as String;
          displayFile = XFile(thumbnailUrl);
        } else {
          displayFile = XFile(path);
        }

        FriendMediaResourceModel mediaInfo = FriendMediaResourceModel(
          mediaId: 0,
          type: content['type'],
          url: content['url'],
          thumbnail: content['thumbnail'], // 存储上传后的缩略图URL
          width: content['width'] ?? 0,
          height: content['height'] ?? 0,
        );

        // 调用addImage时传递displayFile和mediaInfo
        controller.addImage(displayFile, mediaInfo);
      }
    }
    // 4. 统一异常处理
    catch (e) {
      _showSnackBar('资源选择失败，请重试\n错误详情: $e');
      debugPrint('AssetPicker Error: $e'); // 开发者调试日志
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
  Widget _buildSelectedImageWidget(
      XFile image, FriendMediaResourceModel imageinfo) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            File(image.path),
            width: 120,
            height: 120,
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
                controller.removeImage(image, imageinfo);
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
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.grey[500]),
            Text('选择文件', style: TextStyle(color: Colors.grey[500])),
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
      // 使用asMap获取索引和元素
      for (var entry in controller.selectedImages.asMap().entries) {
        int index = entry.key;
        XFile image = entry.value;

        // 通过索引获取对应的imageinfo
        if (index < controller.selectedImagesinfo.length) {
          FriendMediaResourceModel imageinfo =
              controller.selectedImagesinfo[index];
          imageWidgets.add(_buildSelectedImageWidget(image, imageinfo));
        }
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
