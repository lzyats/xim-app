import 'dart:io';

import 'package:alpaca/tools/tools_comment.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class WidgetMoment {
  /// 构建位置显示组件
  /// [strlen]：位置文本的最大长度限制，默认值为22
  static Widget buildLocationWidget(String? location, {int strlen = 20}) {
    // 新增strlen参数，默认值22
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
        print('经纬度解析失败: $e');
      }
    }

    // 使用strlen参数替代固定值22，同时增加边界判断（避免传入负数导致异常）
    if (strlen <= 0) strlen = strlen; // 若传入非正数，强制使用默认值22
    if (locationText.length > strlen) {
      locationText =
          '${locationText.substring(0, strlen - 2)}...'; // 预留2个字符给省略号
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
  static momentsItem({
    required MomentModel post,
    required Function(List<Media>, int) onImageTap,
    required Function(List<Media>, int) onVideoTap,
  }) {
    // 1. 先声明 _buildVideoPlayerPlaceholder
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

    // 统一的九宫格媒体布局方法
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
        return GestureDetector(
          onTap: () => onTap(mediaList, 0),
          child: Image.network(
            mediaList.first.url,
            width: mediaWidth,
            height: mediaHeight,
            fit: BoxFit.cover,
          ),
        );
      } else if (mediaCount == 2) {
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(mediaList, 0),
                child: Image.network(
                  mediaList[0].url,
                  height: mediaHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTap(mediaList, 1),
                child: Image.network(
                  mediaList[1].url,
                  height: mediaHeight,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        );
      } else if (mediaCount == 3) {
        return Row(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () => onTap(mediaList, 0),
                  child: Image.network(
                    mediaList[0].url,
                    width: mediaWidth / 2,
                    height: mediaHeight / 2,
                    fit: BoxFit.cover,
                  ),
                ),
                GestureDetector(
                  onTap: () => onTap(mediaList, 1),
                  child: Image.network(
                    mediaList[1].url,
                    width: mediaWidth / 2,
                    height: mediaHeight / 2,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => onTap(mediaList, 2),
              child: Image.network(
                mediaList[2].url,
                width: mediaWidth / 2,
                height: mediaHeight,
                fit: BoxFit.cover,
              ),
            ),
          ],
        );
      } else if (mediaCount == 4) {
        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: mediaList.asMap().entries.map((entry) {
            int index = entry.key;
            Media media = entry.value;
            return GestureDetector(
              onTap: () => onTap(mediaList, index),
              child: Image.network(
                media.url,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        );
      } else if (mediaCount == 5) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 0),
                    child: Image.network(
                      mediaList[0].url,
                      height: mediaHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 1),
                    child: Image.network(
                      mediaList[1].url,
                      height: mediaHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 2),
                    child: Image.network(
                      mediaList[2].url,
                      height: mediaHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 3),
                    child: Image.network(
                      mediaList[3].url,
                      height: mediaHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 4),
                    child: Image.network(
                      mediaList[4].url,
                      height: mediaHeight / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      } else if (mediaCount == 6) {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: mediaList.asMap().entries.map((entry) {
            int index = entry.key;
            Media media = entry.value;
            return GestureDetector(
              onTap: () => onTap(mediaList, index),
              child: Image.network(
                media.url,
                width: mediaWidth / 3,
                height: mediaHeight,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        );
      } else if (mediaCount == 7) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => onTap(mediaList, 0),
              child: Image.network(
                mediaList[0].url,
                width: mediaWidth,
                height: mediaHeight / 3,
                fit: BoxFit.cover,
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: mediaList.sublist(1).asMap().entries.map((entry) {
                int index = entry.key + 1;
                Media media = entry.value;
                return GestureDetector(
                  onTap: () => onTap(mediaList, index),
                  child: Image.network(
                    media.url,
                    width: mediaWidth / 3,
                    height: mediaHeight / 3,
                    fit: BoxFit.cover,
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
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 0),
                    child: Image.network(
                      mediaList[0].url,
                      height: mediaHeight / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onTap(mediaList, 1),
                    child: Image.network(
                      mediaList[1].url,
                      height: mediaHeight / 3,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: mediaList.sublist(2).asMap().entries.map((entry) {
                int index = entry.key + 2;
                Media media = entry.value;
                return GestureDetector(
                  onTap: () => onTap(mediaList, index),
                  child: Image.network(
                    media.url,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),
          ],
        );
      } else if (mediaCount >= 9) {
        return GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: mediaList.take(9).toList().asMap().entries.map((entry) {
            int index = entry.key;
            Media media = entry.value;
            return GestureDetector(
              onTap: () => onTap(mediaList, index),
              child: Image.network(
                media.url,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        );
      }
      return Container();
    }

    // 媒体区域构建函数
    Widget _buildMediaSection() {
      List<Media> mediaList = post.images ?? [];

      if (mediaList.isNotEmpty && mediaList.first.type == 1) {
        // 视频
        return GestureDetector(
          onTap: () => onVideoTap(mediaList, 0),
          child: _buildVideoPlayerPlaceholder(
            mediaList.first.url,
            mediaList.first.thumbnail ?? '',
            150,
            150,
          ),
        );
      } else {
        // 图片 - 调用统一的九宫格布局方法
        return buildMediaGrid(
          mediaList: mediaList,
          onTap: onImageTap,
          // 可自定义宽高，这里使用默认值150
          // mediaWidth: 200,
          // mediaHeight: 200,
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
                        ? _buildMediaSection()
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

  // 图片浏览及缩放（优化：支持媒体资源元数据）
  /// 显示图片预览
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
                    // 每次打开时创建新的 PhotoViewContainer 实例
                    PhotoViewContainer(
                      mediaList: imageList, // 使用过滤后的图片列表
                      initialIndex: adjustedInitialIndex, // 使用调整后的初始索引
                      currentIndex: currentIndex,
                    ),
                    // 关闭按钮（提升层级至顶部）
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
                    // 底部指示器（提升层级至顶部）
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
                    // 加载状态处理
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      );
                    }
                    // 错误状态处理
                    else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '视频加载失败: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    // 成功状态处理
                    else if (snapshot.hasData) {
                      return snapshot.data!;
                    }
                    // 默认 fallback
                    else {
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

  // 视频播放器核心组件（使用chewie包装video_player）
  static Future<Widget> buildVideoPlayer(Media media) async {
    String videoUrl = Uri.encodeFull(media.url);
    print(media.toJson());
    int width = media.width ?? 1;
    int height = media.height ?? 1;
    late VideoPlayerController videoPlayerController;

    if (Platform.isAndroid) {
      // 安卓平台：使用缓存文件播放
      File file = await DefaultCacheManager().getSingleFile(videoUrl);
      videoPlayerController = VideoPlayerController.file(file);
    } else if (Platform.isIOS) {
      // iOS平台：直接播放网络视频
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    } else {
      // 安卓平台：使用缓存文件播放
      File file = await DefaultCacheManager().getSingleFile(videoUrl);
      videoPlayerController = VideoPlayerController.file(file);
    }
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      autoPlay: true, // 自动播放
      showControlsOnInitialize: true,
      looping: false,
      allowFullScreen: false, // 此处已全屏，禁用内部全屏按钮
      fullScreenByDefault: false,
      aspectRatio: height / width, // 自适应比例
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            '播放失败: $errorMessage',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );

    // 页面销毁时释放资源
    // 使用 PopScope 替代 WillPopScope（Flutter 3.12+ 推荐）
    return PopScope(
      onPopInvoked: (didPop) {
        // 关键修复：移除 await，因为 dispose() 返回 void
        videoPlayerController.dispose();
        chewieController.dispose();
      },
      child: Chewie(controller: chewieController),
    );
  }
}

// 图片预览容器组件
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
