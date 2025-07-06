import 'dart:io';

import 'package:flutter/material.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:scan/scan.dart';
import 'package:video_compress/video_compress.dart';

import 'package:wechat_camera_picker/wechat_camera_picker.dart';

// 聊天=扩展=拍摄
class ChatExtraCamera extends StatelessWidget {
  const ChatExtraCamera({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '拍摄',
      icon: Icons.photo_camera,
      onTap: () async {
        // 权限
        bool result = await ToolsPerms.video();
        if (!result) {
          return;
        }
        _even();
      },
    ).buildItem();
  }

  Future<void> _even() async {
    AssetEntity? assetEntity = await CameraPicker.pickFromCamera(
      AppConfig.navigatorKey.currentState!.context,
      pickerConfig: const CameraPickerConfig(
        // enableRecording: false,
        // shouldAutoPreviewVideo: false,
        enableRecording: true,
        shouldAutoPreviewVideo: false,
        resolutionPreset: ResolutionPreset.high,
      ),
    );
    if (assetEntity == null) {
      return;
    }
    // 处理
    File? file = await assetEntity.file;
    AssetType assetType = assetEntity.type;
    String path = file!.path;
    // 消息类型
    MsgType msgType = MsgType.image;
    // 组装消息
    Map<String, dynamic> content = {
      'data': path,
      'thumbnail': path,
    };
    // 视频
    if (AssetType.video == assetType) {
      msgType = MsgType.video;
      // 组装消息
      content['localPath'] = path;
      // 计算宽高
      content.addAll(await WidgetCommon.calculateVideo(path));
      // 计算缩略
      File file = await VideoCompress.getFileThumbnail(path);
      content['localThumbnail'] = file.path;
    }
    // 图片
    else {
      // 计算宽高
      content.addAll(await WidgetCommon.calculateImage(path));
      // 识别二维码
      content['scan'] = await Scan.parse(path);
    }
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}
