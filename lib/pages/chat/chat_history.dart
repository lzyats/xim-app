import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/chat/chat_history_image.dart';
import 'package:alpaca/pages/chat/chat_history_text.dart';
import 'package:alpaca/pages/chat/chat_history_video.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 聊天记录
class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});
  static const String routeName = '/chat_history';
  @override
  createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  late String chatId;

  @override
  void initState() {
    chatId = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天记录'),
      ),
      body: Column(
        children: [
          _buildSearch(),
          _buildLabel(),
          _buildWrap(),
        ],
      ),
    );
  }

  _buildSearch() {
    return TDSearchBar(
      placeHolder: '搜索',
      alignment: TDSearchAlignment.center,
      readOnly: true,
      onInputClick: () {
        Get.toNamed(
          ChatHistoryText.routeName,
          arguments: chatId,
        );
      },
    );
  }

  _buildLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Align(
        child: Text(
          '搜索指定内容',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  _buildWrap() {
    List<MsgType> list = [
      MsgType.text,
      MsgType.image,
      MsgType.video,
    ];
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 40,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return _buildItem(list[index]);
      },
    );
  }

  _buildItem(MsgType msgType) {
    String routeName;
    String title;
    switch (msgType) {
      case MsgType.image:
        routeName = ChatHistoryImage.routeName;
        title = '图片';
        break;
      case MsgType.video:
        routeName = ChatHistoryVideo.routeName;
        title = '视频';
        break;
      default:
        routeName = ChatHistoryText.routeName;
        title = '文本';
        break;
    }
    return Align(
      child: InkWell(
        // 去掉水波纹
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Get.toNamed(
            routeName,
            arguments: chatId,
          );
        },
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 140, 255),
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
