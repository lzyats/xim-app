import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_card.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 聊天=扩展=名片
class ChatExtraCard extends StatelessWidget {
  const ChatExtraCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '名片',
      icon: AppFonts.e62c,
      onTap: () {
        _event();
      },
    ).buildItem();
  }

  Future<void> _event() async {
    // 查询好友
    List<ChatFriend> friendList = await ToolsSqlite().friend.getList();
    Get.to(const ChatExtraCardItem(), arguments: friendList);
  }
}

class ChatExtraCardItem extends StatelessWidget {
  const ChatExtraCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChatFriend> friendList = Get.arguments;
    // 联系人列表
    List<ContactModel> dataList = [];
    // 转换数据
    for (var data in friendList) {
      dataList.add(
        ContactModel(
          userId: data.userId,
          nickname: data.nickname,
          portrait: data.portrait,
          remark: data.remark,
          extend: 'ID：${data.userNo}',
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('选择名片'),
      ),
      body: WidgetContact(
        dataList: dataList,
        onTap: (ContactModel value) {
          ChatFriend friend = friendList
              .firstWhere((element) => value.userId == element.userId);
          String title = friend.remark;
          if (title.isEmpty) {
            title = friend.nickname;
          }
          showCupertinoDialog(
            context: context,
            builder: (builder) {
              return CupertinoAlertDialog(
                content: WidgetCard(
                  nickname: title,
                  portrait: friend.portrait,
                  userNo: friend.userNo,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('取消'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('发送'),
                    onPressed: () {
                      Get.back();
                      // 消息类型
                      MsgType msgType = MsgType.card;
                      // 组装消息
                      Map<String, dynamic> content = {
                        'userId': friend.userId,
                        'nickname': friend.nickname,
                        'userNo': friend.userNo,
                        'portrait': friend.portrait,
                      };
                      // 组装对象
                      EventChatModel model = EventChatModel(
                        ToolsStorage().chat(),
                        msgType,
                        content,
                      );
                      // 发布消息
                      EventMessage().listenSend.add(model);
                      Get.back();
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
