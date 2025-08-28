import 'dart:io';

import 'package:alpaca/tools/tools_comment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:alpaca/widgets/widget_ioscache.dart';

import 'package:alpaca/tools/tools_videocheck.dart';

class WidgetMoment {
  /// 构建位置显示组件
  /// [strlen]：位置文本的最大长度限制，默认值为22
  static Widget buildLocationWidget(String? location, {int strlen = 20}) {
    if (location == null || location.isEmpty) {
      return const SizedBox.shrink();
    }

    final parts = location.split('|');
    String locationText = parts.isNotEmpty ? parts[0] : '';
    double? longitude;
    double? latitude;

    if (parts.length >= 3) {
      try {
        longitude = double.parse(parts[1]);
        latitude = double.parse(parts[2]);
      } catch (e) {
        debugPrint('经纬度解析失败: $e');
      }
    }

    if (strlen <= 0) strlen = 22;
    if (locationText.length > strlen) {
      locationText = '${locationText.substring(0, strlen - 2)}...';
    }

    return GestureDetector(
      onTap: () => openMap(longitude, latitude, locationText),
      child: Text(
        locationText,
        style: const TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 92, 104, 141),
        ),
      ),
    );
  }

  /// 打开地图
  static void openMap(
      double? longitude, double? latitude, String locationName) async {
    if (longitude == null || latitude == null) {
      Get.snackbar(
        '位置导航',
        '未获取到有效经纬度，无法打开地图',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    bool hasPermission = await ToolsPerms.location();
    if (!hasPermission) {
      return;
    }

    final content = {
      'title': locationName,
      'address': locationName,
      'longitude': longitude,
      'latitude': latitude
    };

    await Get.toNamed('/momnet_location', arguments: content);
  }

  // 格式化日期
  static formatDate(DateTime date) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return const Text(
        '今天',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else if (date == yesterday) {
      return const Text(
        '昨天',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    }

    String day = date.day.toString();
    String month = date.month.toString();

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: day,
            style: const TextStyle(fontSize: 18),
          ),
          TextSpan(
            text: month,
            style: const TextStyle(fontSize: 12),
          ),
          TextSpan(
            text: '月',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // 帖子项组件
  static momentsItem(
    BuildContext context, {
    required MomentModel post,
    required Function(List<Media>, int) onImageTap,
    required Function(List<Media>, int) onVideoTap,
  }) {
    // 获取显示用的图片URL（优先使用包含http的thumbnail）
    String _getDisplayImageUrl(Media media) {
      if (media.thumbnail != null && media.thumbnail!.contains('http')) {
        return media.thumbnail!;
      }
      return media.url;
    }

    Widget _buildVideoPlayerPlaceholder(
        String videoUrl, String thumbnailUrl, double width, double height) {
      return Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: thumbnailUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.video_library, color: Colors.grey),
              ),
            ),
            const Icon(Icons.play_circle_outline,
                color: Colors.white, size: 50),
          ],
        ),
      );
    }

    /// 统一的图片加载组件（带缓存）
    Widget _buildCachedImage({
      required String displayUrl, // 显示用URL（可能是thumbnail）
      required String originalUrl, // 原始URL（用于点击查看）
      required String id, //用于标识唯一图片
      double? width,
      double? height,
      BoxFit fit = BoxFit.cover,
    }) {
      return VisibilityDetector(
        key: Key('lazy_image_$id'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction > 0.5) {
            // 预加载显示用的图片到缓存
            DefaultCacheManager().getSingleFile(displayUrl);
          }
        },
        child: CachedNetworkImage(
          imageUrl: displayUrl, // 排版时使用displayUrl
          width: width,
          height: height,
          fit: fit,
          placeholder: (context, url) => Container(
            color: Colors.grey[100],
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[100],
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
          memCacheWidth: width?.toInt(),
          memCacheHeight: height?.toInt(),
        ),
      );
    }

    /// 统一的九宫格媒体布局方法
    Widget buildMediaGrid({
      required List<Media> mediaList,
      required Function(List<Media>, int) onTap,
      double mediaWidth = 150,
      double mediaHeight = 150,
    }) {
      int mediaCount = mediaList.length;

      if (mediaCount == 0) {
        return Container(
          width: mediaWidth,
          height: mediaHeight,
          color: Colors.grey.shade100,
        );
      } else if (mediaCount == 1) {
        final media = mediaList.first;
        return GestureDetector(
            onTap: () => onTap(mediaList, 0),
            child: _buildCachedImage(
              displayUrl: _getDisplayImageUrl(media),
              originalUrl: media.url,
              id: media.mediaId ?? media.url,
              width: mediaWidth,
              height: mediaHeight,
              fit: BoxFit.fill,
            ));
      } else if (mediaCount == 2) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0.5),
                child: GestureDetector(
                    onTap: () => onTap(mediaList, 0),
                    child: _buildCachedImage(
                      displayUrl: _getDisplayImageUrl(mediaList[0]),
                      originalUrl: mediaList[0].url,
                      id: mediaList[0].mediaId ?? mediaList[0].url,
                      height: mediaHeight,
                      width: mediaWidth / 2,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 0.5),
                child: GestureDetector(
                    onTap: () => onTap(mediaList, 1),
                    child: _buildCachedImage(
                      displayUrl: _getDisplayImageUrl(mediaList[1]),
                      originalUrl: mediaList[1].url,
                      id: mediaList[1].mediaId ?? mediaList[1].url,
                      height: mediaHeight,
                      width: mediaWidth / 2,
                    )),
              ),
            ),
          ],
        );
      } else if (mediaCount == 3) {
        return Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 0.5, bottom: 0.5),
                  child: GestureDetector(
                      onTap: () => onTap(mediaList, 0),
                      child: _buildCachedImage(
                        displayUrl: _getDisplayImageUrl(mediaList[0]),
                        originalUrl: mediaList[0].url,
                        id: mediaList[0].mediaId ?? mediaList[0].url,
                        width: mediaWidth / 2 - 1.8,
                        height: mediaHeight / 2 - 0.5,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0.5, top: 0.5),
                  child: GestureDetector(
                      onTap: () => onTap(mediaList, 1),
                      child: _buildCachedImage(
                        displayUrl: _getDisplayImageUrl(mediaList[1]),
                        originalUrl: mediaList[1].url,
                        id: mediaList[1].mediaId ?? mediaList[1].url,
                        width: mediaWidth / 2 - 1.8,
                        height: mediaHeight / 2 - 0.5,
                      )),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.5),
              child: GestureDetector(
                  onTap: () => onTap(mediaList, 2),
                  child: _buildCachedImage(
                    displayUrl: _getDisplayImageUrl(mediaList[2]),
                    originalUrl: mediaList[2].url,
                    id: mediaList[2].mediaId ?? mediaList[2].url,
                    width: mediaWidth / 2 - 2.5,
                    height: mediaHeight - 1,
                  )),
            ),
          ],
        );
      } else if (mediaCount == 4) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: 1,
          children: mediaList.asMap().entries.map((entry) {
            int index = entry.key;
            Media media = entry.value;
            return GestureDetector(
                onTap: () => onTap(mediaList, index),
                child: _buildCachedImage(
                  displayUrl: _getDisplayImageUrl(media),
                  originalUrl: media.url,
                  id: media.mediaId ?? media.url,
                  width: mediaWidth / 2,
                  height: mediaHeight / 2,
                ));
          }).toList(),
        );
      } else if (mediaCount == 5) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.5, bottom: 1),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 0),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[0]),
                          originalUrl: mediaList[0].url,
                          id: mediaList[0].mediaId ?? mediaList[0].url,
                          height: mediaHeight / 2 - 0.5,
                          width: mediaWidth / 2 - 0.5,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.5, bottom: 1),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 1),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[1]),
                          originalUrl: mediaList[1].url,
                          id: mediaList[1].mediaId ?? mediaList[1].url,
                          height: mediaHeight / 2 - 0.5,
                          width: mediaWidth / 2 - 0.5,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.5),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 2),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[2]),
                          originalUrl: mediaList[2].url,
                          id: mediaList[2].mediaId ?? mediaList[2].url,
                          height: mediaHeight / 2 - 0.5,
                          width: mediaWidth / 3 - 0.3,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 3),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[3]),
                          originalUrl: mediaList[3].url,
                          id: mediaList[3].mediaId ?? mediaList[3].url,
                          height: mediaHeight / 2 - 0.5,
                          width: mediaWidth / 3 - 0.3,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.5),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 4),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[4]),
                          originalUrl: mediaList[4].url,
                          id: mediaList[4].mediaId ?? mediaList[4].url,
                          height: mediaHeight / 2 - 0.5,
                          width: mediaWidth / 3 - 0.3,
                        )),
                  ),
                ),
              ],
            ),
          ],
        );
      } else if (mediaCount == 6) {
        return Container(
          height: mediaHeight,
          child: GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: mediaList.asMap().entries.map((entry) {
              int index = entry.key;
              Media media = entry.value;
              return GestureDetector(
                  onTap: () => onTap(mediaList, index),
                  child: _buildCachedImage(
                    displayUrl: _getDisplayImageUrl(media),
                    originalUrl: media.url,
                    id: media.mediaId ?? media.url,
                    height: mediaHeight / 2,
                    width: mediaWidth / 3 - 0.3,
                  ));
            }).toList(),
            childAspectRatio: (mediaWidth / 3) / (mediaHeight / 2),
          ),
        );
      } else if (mediaCount == 7) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: GestureDetector(
                  onTap: () => onTap(mediaList, 0),
                  child: _buildCachedImage(
                    displayUrl: _getDisplayImageUrl(mediaList[0]),
                    originalUrl: mediaList[0].url,
                    id: mediaList[0].mediaId ?? mediaList[0].url,
                    width: mediaWidth,
                    height: mediaHeight / 3 - 0.3,
                  )),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: mediaList.sublist(1).asMap().entries.map((entry) {
                int index = entry.key + 1;
                Media media = entry.value;
                return GestureDetector(
                  onTap: () => onTap(mediaList, index),
                  child: _buildCachedImage(
                    displayUrl: _getDisplayImageUrl(media),
                    originalUrl: media.url,
                    id: media.mediaId ?? media.url,
                    width: mediaWidth / 3 - 0.3,
                    height: mediaHeight / 3 - 0.3,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      } else if (mediaCount == 8) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.5, bottom: 1),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 0),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[0]),
                          originalUrl: mediaList[0].url,
                          id: mediaList[0].mediaId ?? mediaList[0].url,
                          height: mediaHeight / 3 - 0.3,
                          width: mediaWidth / 2 - 0.5,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.5, bottom: 1),
                    child: GestureDetector(
                        onTap: () => onTap(mediaList, 1),
                        child: _buildCachedImage(
                          displayUrl: _getDisplayImageUrl(mediaList[1]),
                          originalUrl: mediaList[1].url,
                          id: mediaList[1].mediaId ?? mediaList[1].url,
                          height: mediaHeight / 3 - 0.5,
                          width: mediaWidth / 2 - 0.5,
                        )),
                  ),
                ),
              ],
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: mediaList.sublist(2).asMap().entries.map((entry) {
                int index = entry.key + 2;
                Media media = entry.value;
                return GestureDetector(
                    onTap: () => onTap(mediaList, index),
                    child: _buildCachedImage(
                      displayUrl: _getDisplayImageUrl(media),
                      originalUrl: media.url,
                      id: media.mediaId ?? media.url,
                      width: mediaWidth / 3 - 0.3,
                      height: mediaHeight / 3 - 0.3,
                    ));
              }).toList(),
            ),
          ],
        );
      } else if (mediaCount >= 9) {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          children: mediaList.take(9).toList().asMap().entries.map((entry) {
            int index = entry.key;
            Media media = entry.value;
            return GestureDetector(
                onTap: () => onTap(mediaList, index),
                child: _buildCachedImage(
                  displayUrl: _getDisplayImageUrl(media),
                  originalUrl: media.url,
                  id: media.mediaId ?? media.url,
                  width: mediaWidth / 3 - 0.3,
                  height: mediaHeight / 3 - 0.3,
                ));
          }).toList(),
        );
      }
      return Container();
    }

    // 媒体区域构建函数
    Widget _buildMediaSection(context) {
      List<Media> mediaList = post.images ?? [];
      final screenWidth = MediaQuery.of(context).size.width;
      final mediaWidth = screenWidth * 0.38;
      if (mediaList.isNotEmpty && mediaList.first.type == 1) {
        // 视频处理保持不变
        return GestureDetector(
          onTap: () => onVideoTap(mediaList, 0),
          child: _buildVideoPlayerPlaceholder(
            mediaList.first.url,
            mediaList.first.thumbnail ?? '',
            mediaWidth,
            mediaWidth,
          ),
        );
      } else {
        // 图片 - 调用统一的九宫格布局方法
        return buildMediaGrid(
          mediaList: mediaList,
          onTap: onImageTap,
          mediaWidth: mediaWidth,
          mediaHeight: mediaWidth,
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: post.images?.isNotEmpty == true
                        ? _buildMediaSection(context)
                        : Container(
                            width: 150,
                            height: 150,
                            color: Colors.grey.shade100,
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 150,
                    alignment: Alignment.topLeft,
                    child: post.content?.isNotEmpty == true
                        ? Text(
                            post.content!,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          )
                        : Container(
                            color: Colors.grey.shade50,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 图片浏览及缩放（保持使用原始url）
  static void showImageViewer(
    BuildContext context,
    List<Media> picList,
    int initialIndex,
  ) {
    // 过滤掉视频资源，只保留图片资源
    final List<Media> imageList =
        picList.where((media) => media.type == 0).toList();

    // 调整初始索引
    int adjustedInitialIndex = 0;
    for (int i = 0; i < initialIndex; i++) {
      if (picList[i].type == 0) {
        adjustedInitialIndex++;
      }
    }

    final RxInt currentIndex = adjustedInitialIndex.obs;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    PhotoViewContainer(
                      mediaList: imageList,
                      initialIndex: adjustedInitialIndex,
                      currentIndex: currentIndex,
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 24,
                      left: 0,
                      right: 0,
                      child: Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imageList.asMap().entries.map((entry) {
                            int index = entry.key;
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex.value == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 全屏播放视频
  static void playVideoFullscreen(BuildContext context, Media media) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: FutureBuilder<Widget>(
                  future: buildVideoPlayer(media),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '视频加载失败: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return snapshot.data!;
                    } else {
                      return const Center(
                        child: Text(
                          '无法加载视频',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                behavior: HitTestBehavior.translucent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 视频播放器核心组件
  // 修改buildVideoPlayer方法中的iOS部分逻辑
  static Future<Widget> buildVideoPlayer(Media media) async {
    String videoUrl = Uri.encodeFull(media.url);
    debugPrint(media.toJson().toString());
    // 修复视频比例计算逻辑
    int width = media.width ?? 1;
    int height = media.height ?? 1;

    // 确保宽高都为正数
    width = width <= 0 ? 1 : width;
    height = height <= 0 ? 1 : height;

    double whb = width / height;

    // 确保比例为合理正值
    if (whb <= 0 || whb.isInfinite || whb.isNaN) {
      whb = 9 / 16; // 使用默认宽高比
    }
    late VideoPlayerController videoPlayerController;
    bool isInitialized = false; // 跟踪初始化状态

    try {
      // 获取缓存文件
      File file = await WidgetIoscache().getCustomSingleFile(videoUrl);
      debugPrint("缓存文件路径: ${file.path}");

      // 1. 判断文件是否存在
      bool fileExists = await file.exists();
      if (!fileExists) {
        debugPrint("缓存文件不存在，准备切换到网络播放");
      } else {
        debugPrint("缓存文件存在，准备判断文件是否具有可读权限");
      }

      // 使用重命名后的文件初始化播放器
      videoPlayerController = VideoPlayerController.file(file);
      await videoPlayerController.initialize();
      isInitialized = true;
      debugPrint("视频初始化成功，格式正确");
    } catch (e) {
      debugPrint("文件播放失败，准备切换到网络播放: $e");
    }

    // 如果缓存文件初始化失败，使用网络URL
    if (!isInitialized) {
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController.initialize();
    }
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: false, // 已手动初始化，这里设为false
      autoPlay: true,
      showControlsOnInitialize: true,
      looping: false,
      allowFullScreen: false,
      fullScreenByDefault: false,
      aspectRatio: whb,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            '播放失败: $errorMessage',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    return PopScope(
      onPopInvoked: (didPop) {
        videoPlayerController.dispose();
        chewieController.dispose();
      },
      child: Chewie(controller: chewieController),
    );
  }
}

// 图片预览容器组件（使用原始url）
class PhotoViewContainer extends StatelessWidget {
  final List<Media> mediaList;
  final int initialIndex;
  final RxInt currentIndex;

  const PhotoViewContainer({
    Key? key,
    required this.mediaList,
    required this.initialIndex,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Swiper(
        itemCount: mediaList.length,
        index: initialIndex,
        onIndexChanged: (index) {
          currentIndex.value = index;
        },
        itemBuilder: (context, index) {
          final media = mediaList[index];
          // 图片浏览器中始终使用原始url
          return PhotoView(
            imageProvider: CachedNetworkImageProvider(media.url),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
      ),
    );
  }
}
