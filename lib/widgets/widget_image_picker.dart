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
import 'package:wechat_camera_picker/wechat_camera_picker.dart'; // 新增相机选择器依赖
import 'package:alpaca/tools/tools_comment.dart';

class ImagePickerController extends GetxController {
  // 用于存储已选择的图片/视频
  final selectedMedias = <XFile>[].obs;
  // 添加 getter 方法以便外部访问
  List<XFile> get getSelectedMedias => selectedMedias.value;

  // 用于存储已上传的媒体信息
  final selectedMediasInfo = <Media>[].obs;
  // 添加 getter 方法以便外部访问
  List<Media> get getSelectedMediasInfo => selectedMediasInfo.value;

  // 上传状态
  final isUploading = false.obs;

  // 添加媒体到已选择列表
  void addMedia(XFile media, Media mediaInfo) {
    if (selectedMedias.length < 9) {
      selectedMedias.add(media);
      selectedMediasInfo.add(mediaInfo);
    }
  }

  // 从已选择列表中移除媒体
  void removeMedia(XFile media, Media mediaInfo) {
    selectedMedias.remove(media);
    selectedMediasInfo.remove(mediaInfo);
  }
}

class ImagePickerWidget extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final ImagePickerController controller = Get.put(ImagePickerController());

  // 底部菜单选择回调
  void _onMediaSourceSelected(BuildContext context, int source) {
    Navigator.pop(context); // 关闭底部菜单
    switch (source) {
      case 0:
        _pickFromCamera(); // 相机
        break;
      case 1:
        _pickImages(); // 图片
        break;
      case 2:
        _pickVideos(); // 视频
        break;
    }
  }

  // 显示底部选择菜单
  void _showMediaSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => WidgetBottom(
        // 假设WidgetBottom是自定义底部菜单组件
        title: "选择媒体来源",
        items: const [
          {"icon": Icons.camera_alt, "title": "相机"},
          {"icon": Icons.image, "title": "图片"},
          {"icon": Icons.video_library, "title": "视频"},
        ],
        onItemTap: (index) => _onMediaSourceSelected(context, index),
      ),
    );
  }

  // 选择图片（保持原有逻辑）
  Future<void> _pickImages() async {
    // 权限校验
    bool photoResult = await ToolsPerms.photos();
    if (!photoResult) {
      _showSnackBar('未获取相册权限，无法选择图片');
      return;
    }

    try {
      // 动态计算剩余可选数量
      int remainingSlots = 9 - controller.selectedMedias.length;
      if (remainingSlots <= 0) {
        _showSnackBar('最多只能选择9个文件');
        return;
      }

      // 调用AssetPicker选择图片
      List<AssetEntity>? dataList = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: AssetPickerConfig(
          maxAssets: remainingSlots,
          requestType: RequestType.image, // 只选择图片
          pathNameBuilder: (AssetPathEntity path) {
            return WidgetCommon.pathName(path);
          },
        ),
      );

      if (dataList == null || dataList.isEmpty) return;

      // 处理选择的图片
      for (var element in dataList) {
        await _processMedia(element);
      }
    } catch (e) {
      _showSnackBar('图片选择失败，请重试\n错误详情: $e');
      debugPrint('Image Picker Error: $e');
    }
  }

  // 选择视频
  Future<void> _pickVideos() async {
    // 权限校验
    bool videoResult = await ToolsPerms.video();
    if (!videoResult) {
      _showSnackBar('未获取视频权限，无法选择视频');
      return;
    }

    try {
      // 动态计算剩余可选数量
      int remainingSlots = 9 - controller.selectedMedias.length;
      if (remainingSlots <= 0) {
        _showSnackBar('最多只能选择9个文件');
        return;
      }
      // 视频只能选择一个
      /* if (controller.selectedMedias.isNotEmpty) {
        _showSnackBar('视频只能选择一个');
        return;
      } */

      // 调用AssetPicker选择视频
      List<AssetEntity>? dataList = await AssetPicker.pickAssets(
        Get.context!,
        pickerConfig: AssetPickerConfig(
          maxAssets: remainingSlots, // 视频最多选1个
          requestType: RequestType.video, // 只选择视频
          pathNameBuilder: (AssetPathEntity path) {
            return WidgetCommon.pathName(path);
          },
        ),
      );

      if (dataList == null || dataList.isEmpty) return;

      // 处理选择的视频
      for (var element in dataList) {
        await _processMedia(element);
      }
    } catch (e) {
      _showSnackBar('视频选择失败，请重试\n错误详情: $e');
      debugPrint('Video Picker Error: $e');
    }
  }

  // 从相机拍摄
  Future<void> _pickFromCamera() async {
    // 权限校验
    bool cameraResult = await ToolsPerms.camera();
    if (!cameraResult) {
      _showSnackBar('未获取相机权限，无法拍摄');
      return;
    }

    try {
      // 调用相机选择器
      final AssetEntity? entity = await CameraPicker.pickFromCamera(
        Get.context!,
        pickerConfig: CameraPickerConfig(
          enableRecording: true, // 支持拍摄视频
          onlyEnableRecording: false, // 不限制只能拍摄视频
          maximumRecordingDuration: const Duration(minutes: 5), // 最长录制时间
        ),
      );

      if (entity == null) return;

      // 处理拍摄的媒体（图片或视频）
      await _processMedia(entity);
    } catch (e) {
      _showSnackBar('相机拍摄失败，请重试\n错误详情: $e');
      debugPrint('Camera Picker Error: $e');
    }
  }

  // 统一处理媒体文件（图片/视频）
  Future<void> _processMedia(AssetEntity entity) async {
    // 获取文件实体
    File? file = await entity.file;
    if (file == null) return;

    // 识别资源类型
    AssetType assetType = entity.type;
    String path = file.path;

    // 开始上传，显示 loading
    controller.isUploading.value = true;

    try {
      // 组装基础消息内容
      Map<String, dynamic> content = {
        'data': path,
        'thumbnail': path,
        'thumbnail1': path,
      };

      // 视频类型特殊处理
      if (assetType == AssetType.video) {
        // 检查是否已存在视频
        if (controller.selectedMedias.any((media) =>
            media.path.toLowerCase().endsWith('.mp4') ||
            media.path.toLowerCase().endsWith('.mov'))) {
          _showSnackBar('只能选择一个视频');
          return;
        }

        // 更新消息类型
        MsgType msgType = MsgType.video;
        content['localPath'] = path;

        // 获取视频元数据
        content.addAll(await WidgetCommon.calculateVideo(path));

        // 生成视频缩略图
        File thumbFile = await VideoCompress.getFileThumbnail(path);
        content['thumbnail1'] = thumbFile.path;
        content['type'] = 1;

        // 上传视频缩略图
        String thumbnailUrl = await ToolsUpload.uploadFile(thumbFile.path);
        content['thumbnail'] = thumbnailUrl;
      } else {
        // 图片类型处理
        Map<String, dynamic> imgInfo = await WidgetCommon.calculateImage(path);
        print('图片信息：' + imgInfo.toString());
        content.addAll(imgInfo);
        content['type'] = 0;

        // 二维码识别
        content['scan'] = await Scan.parse(path);
      }

      // 上传文件并获取URL
      content['url'] = await ToolsUpload.uploadFile(path);

      // 准备显示文件
      XFile displayFile;
      if (assetType == AssetType.video) {
        // 视频显示缩略图
        displayFile = XFile(content['thumbnail1'] as String);
      } else {
        // 图片显示原图路径
        displayFile = XFile(path);
      }

      // 组装媒体信息模型
      Media mediaInfo = Media(
        type: content['type'],
        url: content['url'],
        thumbnail: content['thumbnail'],
        width: content['width'] ?? 0,
        height: content['height'] ?? 0,
      );

      // 添加到选择列表
      controller.addMedia(displayFile, mediaInfo);

      // 发布事件（保持原有逻辑）
      EventChatModel model = EventChatModel(
        ToolsStorage().chat(),
        assetType == AssetType.video ? MsgType.video : MsgType.image,
        content,
      );
      // EventMessage().listenSend.add(model);
    } catch (e) {
      _showSnackBar('文件处理失败，请重试\n错误详情: $e');
      debugPrint('Media Process Error: $e');
    } finally {
      // 上传结束，隐藏 loading
      controller.isUploading.value = false;
    }
  }

  // 显示 SnackBar 的方法
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 构建已选择媒体的 Widget
  Widget _buildSelectedMediaWidget(XFile media, Media mediaInfo) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: mediaInfo.type == 1 // 1表示视频类型
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      File(media.path),
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                    const Icon(Icons.play_circle,
                        color: Colors.white, size: 32),
                  ],
                )
              : Image.file(
                  File(media.path),
                  width: 110,
                  height: 110,
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
              icon: const Icon(Icons.close, color: Colors.white, size: 18),
              onPressed: () {
                controller.removeMedia(media, mediaInfo);
              },
              padding: const EdgeInsets.all(4),
              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ],
    );
  }

  // 构建选择媒体按钮的 Widget
  Widget _buildAddMediaButton() {
    return GestureDetector(
      onTap: () => _showMediaSourceBottomSheet(Get.context!),
      child: Container(
        width: 110,
        height: 110,
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
      if (controller.isUploading.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('文件处理中，请稍候...'),
            ],
          ),
        );
      }

      List<Widget> mediaWidgets = [];

      // 添加已选择的媒体
      for (var entry in controller.selectedMedias.asMap().entries) {
        int index = entry.key;
        XFile media = entry.value;

        if (index < controller.selectedMediasInfo.length) {
          Media mediaInfo = controller.selectedMediasInfo[index];
          mediaWidgets.add(_buildSelectedMediaWidget(media, mediaInfo));
        }
      }

      // 添加选择媒体按钮
      if (controller.selectedMedias.length < 9) {
        mediaWidgets.add(_buildAddMediaButton());
      }

      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: mediaWidgets,
      );
    });
  }
}

// 底部菜单组件（假设的实现，根据实际项目调整）
class WidgetBottom extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Function(int) onItemTap;

  const WidgetBottom({
    super.key,
    required this.title,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            childAspectRatio: 1.2,
            crossAxisSpacing: 16,
            children: List.generate(items.length, (index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => onItemTap(index),
                child: Column(
                  children: [
                    Icon(item['icon'], size: 28, color: Colors.black87),
                    const SizedBox(height: 8),
                    Text(item['title']),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        ],
      ),
    );
  }
}
