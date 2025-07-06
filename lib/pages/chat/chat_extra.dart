import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety_flutter3/flutter_swiper_null_safety_flutter3.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_extra_file.dart';
import 'package:alpaca/pages/chat/chat_extra_group_transfer.dart';
import 'package:alpaca/pages/chat/chat_extra_location.dart';
import 'package:alpaca/pages/chat/chat_extra_photo.dart';
import 'package:alpaca/pages/chat/chat_extra_camera.dart';
import 'package:alpaca/pages/chat/chat_extra_card.dart';
import 'package:alpaca/pages/chat/chat_extra_collect.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/chat/chat_extra_group_packet.dart';
import 'package:alpaca/pages/chat/chat_extra_packet.dart';
import 'package:alpaca/pages/chat/chat_extra_transfer.dart';
import 'package:alpaca/pages/chat/chat_extra_call.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 聊天=扩展
class ChatExtra extends StatefulWidget {
  final RxString configMedia;
  final RxString configPacket;
  const ChatExtra({
    super.key,
    required this.configMedia,
    required this.configPacket,
  });

  @override
  createState() => _ChatExtraState();
}

class _ChatExtraState extends State<ChatExtra> {
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    // 聊天对象
    LocalChat localChat = ToolsStorage().chat();
    String current = ToolsStorage().local().userId;
    // 机器人
    if (ChatTalk.robot == localChat.chatTalk) {
      items.add(const ChatExtraPhoto());
      items.add(const ChatExtraCamera());
      items.add(const ChatExtraCard());
      items.add(const ChatExtraFile());
    }
    // 自己
    else if (current == localChat.chatId) {
      items.add(const ChatExtraPhoto());
      items.add(const ChatExtraCamera());
      items.add(const ChatExtraLocation());
      items.add(const ChatExtraCard());
      items.add(const ChatExtraCollect());
      items.add(const ChatExtraFile());
    }
    // 好友
    else if (ChatTalk.friend == localChat.chatTalk) {
      items.add(const ChatExtraPhoto());
      items.add(const ChatExtraCamera());
      if (ToolsStorage().config().callKit.isNotEmpty) {
        items.add(const ChatExtraCall());
      }
      items.add(const ChatExtraLocation());
      items.add(const ChatExtraCard());
      items.add(const ChatExtraCollect());
      items.add(const ChatExtraTransfer());
      items.add(const ChatExtraPacket());
      items.add(const ChatExtraFile());
    }
    // 群聊
    else if (ChatTalk.group == localChat.chatTalk) {
      bool configMedia = 'Y' == widget.configMedia.value;
      if (configMedia) {
        items.add(const ChatExtraPhoto());
        items.add(const ChatExtraCamera());
      }
      items.add(const ChatExtraLocation());
      items.add(const ChatExtraCard());
      items.add(const ChatExtraCollect());
      items.add(const ChatExtraGroupTransfer());
      if ('Y' == widget.configPacket.value) {
        items.add(const ChatExtraGroupPacket());
      }
      if (configMedia) {
        items.add(const ChatExtraFile());
      }
    }
    return Container(
      color: Colors.white,
      child: ExtraContainer(
        items: items,
      ),
    );
  }
}

// 扩展容器
class ExtraContainer extends StatefulWidget {
  final List<Widget> items;

  const ExtraContainer({
    super.key,
    required this.items,
  });

  @override
  createState() => _ExtraContainerState();
}

// 扩展容器
class _ExtraContainerState extends State<ExtraContainer> {
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = _createPages();
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return pages[index];
      },
      loop: false,
      itemCount: pages.length,
      pagination: SwiperPagination(
        builder: DotSwiperPaginationBuilder(
          activeColor: pages.length > 1 ? AppTheme.color : null,
          color: pages.length > 1 ? Colors.grey : null,
        ),
      ),
    );
  }

  List<Widget> _createPages() {
    final items = widget.items;
    final hasLastPage = items.length % 8 == 0 ? 0 : 1;
    final totalPageCount = items.length ~/ 8 + hasLastPage;
    List<Widget> pages = [];
    for (var i = 0; i < totalPageCount; i++) {
      final page = _getPage(i);
      pages.add(page);
    }
    return pages;
  }

  Widget _getPage(int page) {
    List<Widget> extras = [];
    for (var i = 0; i < widget.items.length; i++) {
      if (i < page * 8) continue;
      if (i > (page + 1) * 8 - 1) continue;
      extras.add(widget.items[i]);
    }

    List<Widget> itemList1 = [];
    List<Widget> itemList2 = [];

    for (var i = 0; i < extras.length; i++) {
      if (i < 4) {
        itemList1.add(extras[i]);
      } else {
        itemList2.add(extras[i]);
      }
    }

    if (itemList1.length < 4) {
      final length = itemList1.length;
      for (var i = 0; i < 4 - length; i++) {
        itemList1.add(const ExtraItem());
      }
    }

    if (itemList2.length < 4) {
      final length = itemList2.length;
      for (var i = 0; i < 4 - length; i++) {
        itemList2.add(const ExtraItem());
      }
    }

    return Column(
      children: [
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              for (final item in itemList1)
                Expanded(
                  child: item,
                )
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              for (final item in itemList2)
                Expanded(
                  child: item,
                )
            ],
          ),
        ),
      ],
    );
  }
}

// 扩展详情
class ExtraItem extends InkWell {
  final String label;
  final IconData icon;

  const ExtraItem({
    this.label = '',
    this.icon = Icons.add,
    super.key,
    super.onTap,
  });

  Widget buildItem() {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 248, 246, 246),
              borderRadius: BorderRadius.circular(7.0),
            ),
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              icon,
              size: 40,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(label),
        ],
      ),
    );
  }
}
