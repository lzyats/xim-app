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
    // 文件
    File file;
    // 网络路径
    if (ToolsRegex.isUrl(path)) {
      file = await DefaultCacheManager().getSingleFile(path);
    }
    // 本地路径
    else {
      file = File(path);
    }
    // 转换路径
    playerController = VideoPlayerController.file(file)
      ..initialize().then(
        (_) {
          // 构建
          chewieController = ChewieController(
            videoPlayerController: playerController!,
            // 初始化
            autoInitialize: true,
            // 默认播放
            autoPlay: true,
            // 显示控制
            showControlsOnInitialize: true,
            // 允许全屏
            allowFullScreen: false,
            // 默认全屏
            fullScreenByDefault: false,
          );
          ToolsSubmit.dismiss();
          setState(() {});
        },
      );
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
