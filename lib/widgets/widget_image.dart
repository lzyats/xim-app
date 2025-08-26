import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:photo_view/photo_view_gallery.dart';

// 图片组件
class WidgetImage extends StatelessWidget {
  final String path;
  final ImageType imageType;
  final double width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final bool gallery;
  // 新增缓存相关参数（按需调整）
  final int? cacheWidth;
  final int? cacheHeight;

  const WidgetImage(
    this.path,
    this.imageType, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.color,
    this.fit,
    this.gallery = false,
    this.cacheWidth,
    this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (gallery) {
      return GestureDetector(
        child: _build(),
        onTap: () {
          Get.to(
            ShowImage(path, imageType: imageType),
            transition: Transition.topLevel,
          );
        },
      );
    }
    return _build();
  }

  _build() {
    if (ImageType.network == imageType) {
      // 使用CachedNetworkImage替代Image.network，支持缓存和错误处理
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        // 加载中占位符（可选）
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
        // 错误处理（替换原errorBuilder）
        errorWidget: (context, url, error) => _error(),
      );
    }
    if (ImageType.file == imageType) {
      return Image.file(
        File(path),
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _error(),
      );
    }
    if (ImageType.asset == imageType) {
      return Image.asset(
        path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _error(),
      );
    }
    return Container(width: 50);
  }

  _error() {
    return Image.asset(
      AppImage.error,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }

  // 优化图片提供者：使用CachedNetworkImage的缓存机制
  static ImageProvider provider(String path) {
    if (!AppConfig.network) {
      return AssetImage(AppImage.error);
    }
    // 使用CachedNetworkImage的缓存管理器获取图片提供者
    return CachedNetworkImageProvider(
      path,
      errorListener: (error) => debugPrint('图片加载错误: $error'),
    );
  }
}

// 图片类型
enum ImageType {
  network('network'),
  file('file'),
  asset('asset'),
  ;

  const ImageType(this.value);
  final String value;
}

// 图片预览组件（保持不变）
class ShowImage extends StatelessWidget {
  final String path;
  final ImageType imageType;
  const ShowImage(this.path, {super.key, this.imageType = ImageType.network});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => Get.back(),
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: _provider(),
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset(AppImage.error),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          pageController: PageController(),
        ),
      ),
    );
  }

  ImageProvider _provider() {
    switch (imageType) {
      case ImageType.network:
        return WidgetImage.provider(path); // 复用优化后的provider
      case ImageType.file:
        return FileImage(File(path));
      case ImageType.asset:
        return AssetImage(path);
    }
  }
}
