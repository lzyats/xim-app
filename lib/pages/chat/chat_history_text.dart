import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_text.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 聊天记录-文字
class ChatHistoryText extends GetView<ChatHistoryTextController> {
  // 路由地址
  static const String routeName = '/chat_history_text';
  const ChatHistoryText({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ChatHistoryTextController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('搜索聊天'),
        ),
        body: GetBuilder<ChatHistoryTextController>(
          builder: (builder) {
            return Column(
              children: [
                _buildSearch(),
                WidgetCommon.divider(),
                Expanded(
                  child: SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: controller.refreshController,
                    onLoading: () {
                      controller.onLoading();
                    },
                    child: _buildList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildSearch() {
    return TDSearchBar(
      placeHolder: '搜索内容',
      action: '搜索',
      controller: controller.textController,
      onActionClick: (value) {
        if (ToolsSubmit.call(millisecond: 500)) {
          // 提交
          controller.onRefresh();
        }
      },
    );
  }

  _buildList() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.builder(
      itemCount: controller.refreshList.length,
      itemBuilder: (context, index) {
        ChatHis chatHis = controller.refreshList[index];
        return _buildItem(chatHis);
      },
    );
  }

  _buildItem(ChatHis chatHis) {
    return GestureDetector(
      onTap: () {
        Get.to(
          const WidgetText(),
          arguments: chatHis.content['data'],
          transition: Transition.topLevel,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.only(top: 8.0),
        color: Colors.white.withOpacity(0.5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetCommon.showAvatar(
                  chatHis.source['portrait'],
                  size: 40,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ToolsStorage().remark(
                            chatHis.source['userId'],
                            value: chatHis.source['nickname'],
                            read: true,
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          chatHis.content['data'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          formatDate(
                            chatHis.createTime,
                            [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss],
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF999999),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            WidgetCommon.divider(indent: 0),
          ],
        ),
      ),
    );
  }
}

class ChatHistoryTextController extends BaseController {
  late String chatId;
  final TextEditingController textController = TextEditingController();

  // 初始化刷新
  void onRefresh() {
    String content = textController.text;
    superRefresh(
      ToolsSqlite().his.getRecords(chatId, MsgType.text, 1, content: content),
    );
  }

  // 上滑加载
  void onLoading() {
    String content = textController.text;
    superLoading(
      ToolsSqlite().his.getRecords(chatId, MsgType.text, refreshPageIndex + 1,
          content: content),
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
