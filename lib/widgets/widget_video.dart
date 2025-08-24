import 'dart:io';

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
  _initVideo(String path) async {
    ToolsSubmit.show(millisecond: 60000);

    // 根据平台和路径类型初始化播放器
    if (ToolsRegex.isUrl(path)) {
      // 网络路径：区分平台处理
      if (Platform.isIOS) {
        // iOS 不缓存，直接使用网络播放
        playerController = VideoPlayerController.networkUrl(Uri.parse(path));
      } else {
        // 安卓平台：使用缓存管理器
        File file = await DefaultCacheManager().getSingleFile(
          path,
          headers: {'User-Agent': 'Mozilla/5.0'},
        );
        playerController = VideoPlayerController.file(file);
      }
    } else {
      // 本地路径：统一使用文件播放（全平台通用）
      File file = File(path);
      playerController = VideoPlayerController.file(file);
    }

    // 初始化播放器并构建Chewie控制器
    await playerController?.initialize().then((_) {
      chewieController = ChewieController(
        videoPlayerController: playerController!,
        autoInitialize: true,
        autoPlay: true,
        showControlsOnInitialize: true,
        allowFullScreen: false,
        fullScreenByDefault: false,
      );
      ToolsSubmit.dismiss();
      setState(() {});
    }).catchError((error) {
      // 增加错误处理，避免加载失败时一直显示加载框
      ToolsSubmit.dismiss();
      debugPrint("视频初始化失败: $error");
      Get.snackbar('错误', '视频加载失败，请重试');
    });
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
