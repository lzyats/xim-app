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
  const WidgetImage(
    this.path,
    this.imageType, {
    super.key,
    this.width = 100,
    this.height = 100,
    this.color,
    this.fit,
    this.gallery = false,
  });

  @override
  Widget build(BuildContext context) {
    if (gallery) {
      return GestureDetector(
        child: _build(),
        onTap: () {
          if (gallery) {
            Get.to(
              ShowImage(path, imageType: imageType),
              transition: Transition.topLevel,
            );
          }
        },
      );
    }
    return _build();
  }

  _build() {
    if (ImageType.network == imageType) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        cacheKey: path,
        errorListener: (value) {},
        errorWidget: (context, error, stackTrace) {
          return _error();
        },
      );
    }
    if (ImageType.file == imageType) {
      return Image.file(
        File(path),
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _error();
        },
      );
    }
    if (ImageType.asset == imageType) {
      return Image.asset(
        path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _error();
        },
      );
    }
    return Container(
      width: 50,
    );
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

  static ImageProvider provider(String path) {
    if (!AppConfig.network) {
      return Image.asset(AppImage.error).image;
    }
    Image image = Image.network(
      path,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(AppImage.error);
      },
    );
    return image.image;
  }
}

// 图片类型
enum ImageType {
  // 网络
  network('network'),
  // 文件
  file('file'),
  // 资源
  asset('asset'),
  ;

  const ImageType(this.value);
  final String value;
}

// 图片组件
class ShowImage extends StatelessWidget {
  final String path;
  final ImageType imageType;
  const ShowImage(this.path, {super.key, this.imageType = ImageType.network});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.back();
        },
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: _provider(),
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.white,
          ),
          pageController: PageController(),
        ),
      ),
    );
  }

  ImageProvider _provider() {
    switch (imageType) {
      case ImageType.network:
        return WidgetImage.provider(path);
      case ImageType.file:
        return FileImage(File(path));
      case ImageType.asset:
        return AssetImage(path);
    }
  }
}
