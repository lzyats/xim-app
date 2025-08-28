import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/cache_store.dart';
import 'package:flutter_cache_manager/src/web/web_helper.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// iOS 专用缓存管理器（使用 WebHelper 实现，适配 flutter_cache_manager 3.3.2）
class WidgetIoscache extends CacheManager {
  static const String _iosCacheKey = 'ios_custom_cache';
  static WidgetIoscache? _instance;

  factory WidgetIoscache() {
    _instance ??= WidgetIoscache._internal();
    return _instance!;
  }

  WidgetIoscache._internal()
      : super(
          Config(
            _iosCacheKey,
            maxNrOfCacheObjects: 1000,
            stalePeriod: const Duration(days: 7),
            fileService: HttpFileService(),
          ),
        );

  /// 从URL提取完整文件名（含扩展名）
  String? _getExtensionFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final lastSegment =
          uri.pathSegments.isNotEmpty ? uri.pathSegments.last : '';
      if (lastSegment.isNotEmpty) {
        return lastSegment;
      }
    } catch (e) {
      debugPrint('解析URL扩展名失败: $e');
    }
    return null;
  }

  /// 重写父类的文件路径生成逻辑（核心自定义点）
  @override
  Future<String> getFilePath(String url, {String? key}) async {
    final tempDir = await getTemporaryDirectory();
    final cacheDir = Directory('${tempDir.path}/$_iosCacheKey');
    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }

    // 优先使用URL中的原始文件名（含扩展名）
    final fileNameWithExt = _getExtensionFromUrl(url);
    if (fileNameWithExt != null && fileNameWithExt.isNotEmpty) {
      return p.join(cacheDir.path, fileNameWithExt);
    }

    // 未提取到文件名时，使用MD5哈希（确保唯一性）
    final fileName = await _getFileName(url, key);
    return p.join(cacheDir.path, fileName);
  }

  /// 生成MD5哈希文件名（兼容父类逻辑）
  Future<String> _getFileName(String url, String? key) async {
    final keyToUse = key ?? url;
    final bytes = utf8.encode(keyToUse);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  /// 重写下载文件方法，使用WebHelper并应用自定义路径
  @override
  Future<FileInfo> downloadFile(
    String url, {
    String? key,
    Map<String, String>? authHeaders,
    bool force = false,
  }) async {
    key ??= url;
    // 获取自定义文件路径
    final filePath = await getFilePath(url, key: key);

    // 关键修正：通过 config.fileSystem 创建 file 包兼容的 File 实例
    final file = await config.fileSystem.createFile(filePath);
    await file.parent.create(recursive: true); // 确保目录存在

    // 使用WebHelper下载文件
    final downloadStream = webHelper.downloadFile(
      url,
      key: key,
      authHeaders: authHeaders,
      ignoreMemCache: force,
    );

    // 监听下载流，处理文件
    await for (final response in downloadStream) {
      if (response is FileInfo) {
        // 复制文件到自定义路径（使用 file 包的 File 方法）
        await response.file.copy(file.path);

        // 获取并更新缓存对象
        final originalCacheObject = await store.retrieveCacheData(key);
        if (originalCacheObject == null) {
          throw Exception('获取缓存元数据失败: $key');
        }
        final updatedCacheObject = originalCacheObject.copyWith(
          relativePath: filePath,
        );
        await store.putFile(updatedCacheObject);

        // 返回 file 包兼容的 FileInfo
        return FileInfo(
          file, // 现在是 file 包的 File 类型
          FileSource.Cache,
          updatedCacheObject.validTill,
          url,
          statusCode: 200,
        );
      }
    }

    throw Exception('下载文件失败: $url');
  }

  /// 自定义获取文件方法，优先使用缓存
  Future<File> getCustomSingleFile(
    String url, {
    String? key,
    Map<String, String>? headers,
  }) async {
    key ??= url;
    final cacheFile = await getFileFromCache(key);
    if (cacheFile != null && cacheFile.validTill.isAfter(DateTime.now())) {
      return cacheFile.file;
    }
    // 缓存不存在或过期时，使用重写的downloadFile方法
    return (await downloadFile(url, key: key, authHeaders: headers)).file;
  }
}
