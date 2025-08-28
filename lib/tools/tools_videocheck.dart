import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 添加解码能力检测工具类
class ToolsVideocheck {
  static const MethodChannel _channel = MethodChannel('video_codec_checker');

  // 检查设备是否支持指定视频格式的硬件解码
  static Future<bool> isHardwareDecoderSupported(
      String mimeType, int width, int height) async {
    try {
      final result = await _channel.invokeMethod<bool>(
        'checkHardwareDecoder',
        {
          'mimeType': mimeType,
          'width': width,
          'height': height,
        },
      );
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint('检查硬件解码支持失败: ${e.message}');
      return false;
    }
  }

  // 根据视频URL获取MIME类型（简化实现，实际可能需要更复杂的文件头解析）
  static String getMimeTypeFromUrl(String url) {
    if (url.toLowerCase().endsWith('.mp4') ||
        url.toLowerCase().endsWith('.mov')) {
      return 'video/avc'; // H.264
    } else if (url.toLowerCase().endsWith('.webm')) {
      return 'video/vp8';
    } else if (url.toLowerCase().endsWith('.mkv')) {
      return 'video/hevc'; // H.265
    }
    return 'video/unknown';
  }
}
