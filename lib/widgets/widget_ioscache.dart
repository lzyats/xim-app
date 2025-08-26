import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

/// iOS 专用缓存管理器（适配 flutter_cache_manager 3.3.2）
class WidgetIoscache extends CacheManager with ImageCacheManager {
  // 单例实例
  static const String _iosCacheKey = 'ios_custom_cache';
  static WidgetIoscache? _instance;

  factory WidgetIoscache() {
    _instance ??= WidgetIoscache._internal();
    return _instance!;
  }

  // 私有构造函数：通过 Config 初始化
  WidgetIoscache._internal()
      : super(
          Config(
            _iosCacheKey,
            maxNrOfCacheObjects: 1000,
            stalePeriod: const Duration(days: 15),
          ),
        );

  // 使用 3.3.2 版本暴露的 HttpFileService 作为文件服务
  @override
  Future<FileService> getFileService() async {
    return HttpFileService();
  }

  // 关键修复：重写缓存路径逻辑，移除对 super.getFilePath() 的调用
  @override
  Future<String> getFilePath() async {
    if (Platform.isIOS) {
      // iOS 平台使用 Library/Caches 目录
      final directory = await getLibraryDirectory();
      return p.join(directory.path, _iosCacheKey);
    }
    // 非 iOS 平台使用默认缓存目录（通过缓存管理器的默认逻辑获取）
    final defaultDir = await getTemporaryDirectory();
    return p.join(defaultDir.path, _iosCacheKey);
  }
}
