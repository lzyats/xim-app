import 'dart:io';

import 'package:alpaca/widgets/widget_ioscache.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:video_player/video_player.dart';

// 视频组件
class WidgetVideo extends StatefulWidget {
  const WidgetVideo({super.key});

  @override
  createState() => _WidgetVideoState();
}

class _WidgetVideoState extends State<WidgetVideo> {
  VideoPlayerController? playerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();
    _initVideo(Get.arguments);
  }

  /*
 * 初始化视频 
 */
  /*
 * 初始化视频 - 优化版
 * 核心逻辑：本地文件直接播放，网络文件调用自定义缓存，增强错误处理
 */
  _initVideo(String path) async {
    ToolsSubmit.show(millisecond: 60000);
    late VideoPlayerController videoPlayerController;
    bool isInitialized = false; // 跟踪初始化状态
    ChewieController? newChewieController;

    try {
      if (ToolsRegex.isUrl(path)) {
        // 网络路径：全平台优先使用自定义缓存（参考代码逻辑）
        debugPrint("检测到网络路径，尝试使用缓存播放: $path");

        // 1. 调用自定义缓存类获取文件（替代原DefaultCacheManager）
        File cachedFile = await WidgetIoscache().getCustomSingleFile(path);
        debugPrint("缓存文件路径: ${cachedFile.path}");

        // 2. 验证缓存文件状态
        bool fileExists = await cachedFile.exists();
        if (!fileExists) {
          debugPrint("缓存文件不存在，准备网络播放");
          throw Exception("Cached file not found");
        }

        // 3. 尝试用缓存文件初始化播放器
        videoPlayerController = VideoPlayerController.file(cachedFile);
        await videoPlayerController.initialize();
        isInitialized = true;
        debugPrint("缓存文件初始化成功");
      } else {
        // 本地路径：直接文件播放（全平台通用）
        debugPrint("检测到本地路径，直接播放: $path");
        File localFile = File(path);

        // 验证本地文件状态
        if (!await localFile.exists()) {
          debugPrint("本地文件不存在");
          throw Exception("Local file not found");
        }

        videoPlayerController = VideoPlayerController.file(localFile);
        await videoPlayerController.initialize();
        isInitialized = true;
        debugPrint("本地文件初始化成功");
      }
    } catch (e) {
      // 缓存/本地文件失败时，网络路径降级为直接网络播放
      debugPrint("初始化失败，执行降级方案: $e");
      if (ToolsRegex.isUrl(path)) {
        videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(path));
        await videoPlayerController.initialize();
        isInitialized = true;
        debugPrint("网络播放初始化成功");
      }
    }

    // 构建Chewie控制器（统一处理）
    if (isInitialized) {
      newChewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: false, // 已手动初始化，关闭自动初始化
        autoPlay: true,
        showControlsOnInitialize: true,
        allowFullScreen: false,
        fullScreenByDefault: false,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              '播放失败: $errorMessage',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      );
    }

    // 更新状态
    ToolsSubmit.dismiss();
    setState(() {
      playerController = videoPlayerController;
      chewieController = newChewieController;
    });

    // 最终校验，失败提示
    if (chewieController == null) {
      Get.snackbar('错误', '视频加载失败，请重试');
    }
  }

  @override
  void dispose() {
    ToolsSubmit.dismiss();
    playerController?.dispose();
    chewieController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            chewieController != null
                ? Chewie(
                    controller: chewieController!,
                  )
                : Container(),
            Positioned(
              top: 0,
              left: 10,
              child: IconButton(
                iconSize: 28,
                icon: const Icon(Icons.close),
                color: Colors.white,
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
