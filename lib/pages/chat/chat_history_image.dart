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
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 聊天记录-图片消息
class ChatHistoryImage extends GetView<ChatHistoryImageController> {
  // 路由地址
  static const String routeName = '/chat_history_image';
  const ChatHistoryImage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatHistoryImageController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('聊天记录'),
        ),
        body: GetBuilder<ChatHistoryImageController>(
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
    Map<String, List<ChatHis>> groupedImages = {};
    for (var chat in controller.refreshList) {
      String date = formatDate(chat.createTime, [yyyy, '-', mm, '-', dd]);
      if (!groupedImages.containsKey(date)) {
        groupedImages[date] = [];
      }
      groupedImages[date]!.add(chat);
    }
    return ListView.builder(
      itemCount: groupedImages.length,
      itemBuilder: (context, index) {
        String date = groupedImages.keys.elementAt(index);
        List<ChatHis> images = groupedImages[date]!;
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
              itemCount: images.length,
              itemBuilder: (context, imageIndex) {
                return _buildImage(images[imageIndex].content);
              },
            ),
          ],
        );
      },
    );
  }

  _buildImage(Map<String, dynamic> content) {
    String data = _formatData(content);
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: WidgetImage(
        data,
        ToolsRegex.isUrl(data) ? ImageType.network : ImageType.file,
        fit: BoxFit.cover,
        gallery: true,
      ),
    );
  }

  _formatData(Map<String, dynamic> content) {
    String data = content['data'];
    if (content['thumbnail'] != null) {
      File file = File(content['thumbnail']);
      if (file.existsSync()) {
        data = content['thumbnail'];
      }
    }
    return data;
  }
}

class ChatHistoryImageController extends BaseController {
  late String chatId;
  int limit = 20;

  // 初始刷新
  void onRefresh() {
    superRefresh(
      ToolsSqlite().his.getRecords(chatId, MsgType.image, 1, limit: limit),
    );
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      ToolsSqlite().his.getRecords(chatId, MsgType.image, refreshPageIndex + 1,
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
