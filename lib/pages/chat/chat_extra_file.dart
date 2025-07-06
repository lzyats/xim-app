import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:mime/mime.dart';
import 'package:scan/scan.dart';
import 'package:video_compress/video_compress.dart';

// 聊天=扩展=文件
class ChatExtraFile extends StatelessWidget {
  const ChatExtraFile({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '文件',
      icon: Icons.insert_drive_file,
      onTap: () async {
        // 权限
        bool result = await ToolsPerms.storage();
        if (!result) {
          return;
        }
        _even();
      },
    ).buildItem();
  }

  Future<void> _even() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    PlatformFile platformFile = result.files.single;
    String? path = platformFile.path;
    // 类型
    MsgType msgType = MsgType.file;
    // 组装消息
    Map<String, dynamic> content = {};
    // 类型
    String mimeType = lookupMimeType(path!) ?? '';
    // 图片
    if (mimeType.startsWith('image')) {
      // 类型
      msgType = MsgType.image;
      // 组装消息
      content = {
        'data': path,
        'thumbnail': path,
        'scan': await Scan.parse(path),
      };
      // 计算宽高
      content.addAll(await WidgetCommon.calculateImage(path));
    }
    // 视频
    else if (mimeType.startsWith('video')) {
      // 类型
      msgType = MsgType.video;
      // 组装消息
      content = {
        'data': path,
        'thumbnail': path,
      };
      // 组装消息
      content['localPath'] = path;
      // 计算宽高
      content.addAll(await WidgetCommon.calculateVideo(path));
      // 计算缩略
      File file = await VideoCompress.getFileThumbnail(path);
      content['localThumbnail'] = file.path;
    }
    // 文件
    else {
      content = {
        'thumbnail': path,
        'data': path,
        'mimeType': mimeType,
        'size': platformFile.size,
      };
    }
    // 文件名称
    content['title'] = platformFile.name;
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
