import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_message_card.dart';
import 'package:alpaca/pages/chat/chat_message_file.dart';
import 'package:alpaca/pages/chat/chat_message_image.dart';
import 'package:alpaca/pages/chat/chat_message_location.dart';
import 'package:alpaca/pages/chat/chat_message_other.dart';
import 'package:alpaca/pages/chat/chat_message_reply.dart';
import 'package:alpaca/pages/chat/chat_message_text.dart';
import 'package:alpaca/pages/chat/chat_message_video.dart';
import 'package:alpaca/pages/mine/mine_collect_controller.dart';
import 'package:alpaca/request/request_collect.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 我的收藏
class MineCollectPage extends GetView<MineCollectController> {
  // 路由地址
  static const String routeName = '/mine_collect';
  const MineCollectPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineCollectController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: const MineCollectWidget(),
    );
  }
}

// 收藏组件
class MineCollectWidget extends GetView<MineCollectController> {
  final Function(CollectModel value)? onTap;
  const MineCollectWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineCollectController());
    return GetBuilder<MineCollectController>(builder: (builder) {
      return Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SlidableAutoCloseBehavior(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                controller: controller.refreshController,
                onRefresh: () {
                  controller.onRefresh();
                },
                onLoading: () {
                  controller.onLoading();
                },
                child: _buildList(),
              ),
            ),
          ),
        ],
      );
    });
  }

  _buildList() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.builder(
      itemCount: controller.refreshList.length,
      itemBuilder: (context, index) {
        CollectModel collectModel = controller.refreshList[index];
        if (onTap != null) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              onTap!(collectModel);
            },
            child: _buildItem(collectModel),
          );
        }
        return Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.remove(collectModel);
                  }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: '删除',
              ),
            ],
          ),
          child: _buildItem(collectModel),
        );
      },
    );
  }

  _buildHeader() {
    return TDTabBar(
      tabs: controller.tabs,
      controller: controller.tabController,
      backgroundColor: Colors.white,
      showIndicator: true,
      onTap: (value) {
        MsgType? msgType;
        switch (value) {
          case 1:
            msgType = MsgType.text;
            break;
          case 2:
            msgType = MsgType.image;
            break;
          case 3:
            msgType = MsgType.video;
            break;
          case 4:
            msgType = MsgType.card;
            break;
          case 5:
            msgType = MsgType.file;
            break;
        }
        controller.updateType(msgType);
      },
    );
  }

  _buildItem(CollectModel collectModel) {
    // 消息类型
    MsgType msgType = collectModel.msgType;
    // 消息内容
    Map<String, dynamic> content = collectModel.content;
    // 结果
    Widget child;
    switch (msgType) {
      // 文本消息
      case MsgType.text:
        child = ChatMessageText(
          content,
          text: content['data'],
        );
        break;
      // 图片消息
      case MsgType.image:
        child = ChatMessageImage(
          content,
          size: 80.0,
        );
        break;
      // 视频消息
      case MsgType.video:
        child = ChatMessageVideo(
          content,
          size: 80.0,
        );
        break;
      // 文件消息
      case MsgType.file:
        child = ChatMessageFile(
          content,
          width: 220,
        );
        break;
      // 名片消息
      case MsgType.card:
        child = ChatMessageCard(content);
        break;
      // 位置消息
      case MsgType.location:
        child = ChatMessageLocation(
          content,
          width: 220,
        );
        break;
      // 其他消息
      default:
        child = const ChatMessageOther();
        break;
    }
    return GestureDetector(
      onDoubleTap: () {
        if (MsgType.text == msgType) {
          Get.to(
            const WidgetText(),
            arguments: content['data'],
            transition: Transition.topLevel,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), // 设置圆角
          color: const Color.fromARGB(255, 243, 241, 241), // 设置背景颜色
        ),
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: child,
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  collectModel.msgType.label,
                ),
                WidgetCommon.tips(
                  collectModel.createTime,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
