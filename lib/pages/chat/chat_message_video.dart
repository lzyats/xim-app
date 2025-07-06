import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_video.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

double maxHeight = 400;
double minHeight = 50;
double maxWidth = 180;

// 聊天=消息=视频
class ChatMessageVideo extends StatelessWidget {
  final Map<String, dynamic> content;
  final String status;
  final double? size;
  const ChatMessageVideo(
    this.content, {
    super.key,
    this.status = 'Y',
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (size != null) {
      return GestureDetector(
        onTap: () {
          Get.to(
            const WidgetVideo(),
            arguments: content['data'],
            transition: Transition.topLevel,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: WidgetImage(
                content['thumbnail'],
                ImageType.network,
                fit: BoxFit.cover,
                width: size!,
                height: size!,
              ),
            ),
            const Positioned(
              child: Icon(
                Icons.play_circle_outline,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    String data = _formatData(content);
    String thumbnail = _formatThumbnail(content);
    return GestureDetector(
      onTap: () {
        Get.to(
          const WidgetVideo(),
          arguments: data,
          transition: Transition.topLevel,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                minHeight: minHeight,
              ),
              width: maxWidth,
              child: WidgetImage(
                thumbnail,
                ToolsRegex.isUrl(thumbnail)
                    ? ImageType.network
                    : ImageType.file,
                fit: BoxFit.contain,
                width: double.infinity,
                height: _calculate(content),
              ),
            ),
          ),
          const Positioned(
            child: Icon(
              Icons.play_circle_outline,
              size: 50,
              color: Colors.white,
            ),
          ),
          if ('R' == status)
            const Positioned(
              child: TDLoading(
                size: TDLoadingSize.large,
                icon: TDLoadingIcon.circle,
              ),
            ),
        ],
      ),
    );
  }

  // 计算
  _calculate(Map<String, dynamic> content) {
    if (content['width'] == null) {
      return null;
    }
    if (content['height'] == null) {
      return null;
    }
    int width = content['width'] ?? 100;
    int height = content['height'] ?? 100;
    double value = height / width * maxWidth;
    if (value > maxHeight) {
      return maxHeight;
    }
    if (value < minHeight) {
      return minHeight;
    }
    return value;
  }

  _formatData(Map<String, dynamic> content) {
    String data = content['data'];
    if (content['localPath'] != null) {
      File file = File(content['localPath']);
      if (file.existsSync()) {
        data = content['localPath'];
      }
    }
    return data;
  }

  _formatThumbnail(Map<String, dynamic> content) {
    String thumbnail = content['thumbnail'];
    if (content['localThumbnail'] != null) {
      File file = File(content['localThumbnail']);
      if (file.existsSync()) {
        thumbnail = content['localThumbnail'];
      }
    }
    return thumbnail;
  }
}
