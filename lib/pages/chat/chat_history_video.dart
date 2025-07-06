import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_video.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

double maxHeight = 400;
double minHeight = 50;
double maxWidth = 180;

// 聊天记录-视频消息
class ChatHistoryVideo extends GetView<ChatHistoryVideoController> {
  // 路由地址
  static const String routeName = '/chat_history_video';
  const ChatHistoryVideo({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatHistoryVideoController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('聊天记录'),
        ),
        body: GetBuilder<ChatHistoryVideoController>(
          builder: (builder) {
            return SmartRefresher(
              enablePullDown: false,
              enablePullUp: true,
              controller: controller.refreshController,
              onLoading: () {
                controller.onLoading();
              },
              child: _buildList(),
            );
          },
        ),
      ),
    );
  }

  _buildList() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    Map<String, List<ChatHis>> groupedVideos = {};
    for (var chat in controller.refreshList) {
      String date = formatDate(chat.createTime, [yyyy, '-', mm, '-', dd]);
      if (!groupedVideos.containsKey(date)) {
        groupedVideos[date] = [];
      }
      groupedVideos[date]!.add(chat);
    }
    return ListView.builder(
      itemCount: groupedVideos.length,
      itemBuilder: (context, index) {
        String date = groupedVideos.keys.elementAt(index);
        List<ChatHis> videos = groupedVideos[date]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF666666),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: videos.length,
              itemBuilder: (context, videoIndex) {
                return _buildVideo(videos[videoIndex].content);
              },
            ),
          ],
        );
      },
    );
  }

  _buildVideo(Map<String, dynamic> content) {
    String data = _formatData(content);
    String thumbnail = _formatThumbnail(content);
    return GestureDetector(
      onTap: () {
        Get.to(
          const WidgetVideo(),
          arguments: data,
          transition: Transition.topLevel,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                minHeight: minHeight,
              ),
              width: maxWidth,
              child: WidgetImage(
                thumbnail,
                ToolsRegex.isUrl(thumbnail)
                    ? ImageType.network
                    : ImageType.file,
                fit: BoxFit.cover,
                width: double.infinity,
                height: _calculate(content),
              ),
            ),
          ),
          const Positioned(
            child: Icon(
              Icons.play_circle_outline,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _formatData(Map<String, dynamic> content) {
    String data = content['data'];
    if (content['localPath'] != null) {
      File file = File(content['localPath']);
      if (file.existsSync()) {
        data = content['localPath'];
      }
    }
    return data;
  }

  _formatThumbnail(Map<String, dynamic> content) {
    String thumbnail = content['thumbnail'];
    if (content['localThumbnail'] != null) {
      File file = File(content['localThumbnail']);
      if (file.existsSync()) {
        thumbnail = content['localThumbnail'];
      }
    }
    return thumbnail;
  }

  // 计算
  _calculate(Map<String, dynamic> content) {
    if (content['width'] == null) {
      return null;
    }
    if (content['height'] == null) {
      return null;
    }
    int width = content['width'] ?? 100;
    int height = content['height'] ?? 100;
    double value = height / width * maxWidth;
    if (value > maxHeight) {
      return maxHeight;
    }
    if (value < minHeight) {
      return minHeight;
    }
    return value;
  }
}

class ChatHistoryVideoController extends BaseController {
  late String chatId;
  int limit = 20;

  // 初始刷新
  void onRefresh() {
    superRefresh(
      ToolsSqlite().his.getRecords(chatId, MsgType.video, 1, limit: limit),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      ToolsSqlite().his.getRecords(chatId, MsgType.video, refreshPageIndex + 1,
          limit: limit),
    );
  }

  @override
  void onInit() {
    super.onInit();
    chatId = Get.arguments;
    // 刷新
    onRefresh();
  }
}
