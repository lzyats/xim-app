import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_message.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_contact.dart';

// 消息转发
class MsgForwardPage extends GetView<MsgForwardController> {
  // 路由地址
  static const String routeName = '/msg_forward';
  const MsgForwardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MsgForwardController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('消息转发'),
      ),
      body: GetBuilder<MsgForwardController>(builder: (builder) {
        return _buildTabs(context);
      }),
    );
  }

  _buildTabs(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: AppTheme.color,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            labelColor: Colors.black,
            tabs: const [
              Tab(
                text: "好友",
              ),
              Tab(
                text: "群组",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WidgetContact(
              dataList: controller.friendList,
              onTap: (contact) {
                _forward(context, contact, ChatTalk.friend);
              },
            ),
            WidgetContact(
              dataList: controller.groupList,
              onTap: (contact) {
                _forward(context, contact, ChatTalk.group);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 转发
  _forward(BuildContext context, ContactModel contact, ChatTalk chatTalk) {
    showCupertinoDialog(
      context: context,
      builder: (builder) {
        return CupertinoAlertDialog(
          title: const Text('确认转发？'),
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
                // 关闭
                Get.back();
                // 提交
                LocalChat localChat = LocalChat(
                  chatId: contact.userId,
                  title: contact.nickname,
                  nickname: contact.nickname,
                  portrait: contact.portrait,
                  chatTalk: chatTalk,
                );
                // 合并转发
                if (controller.forward) {
                  _merge(localChat);
                }
                // 逐条转发
                else {
                  _once(localChat);
                }
                // 提醒
                EasyLoading.showToast('转发成功');
                // 返回
                Get.back(result: '@');
              },
            ),
          ],
        );
      },
    );
  }

  // 逐条转发
  _once(LocalChat localChat) {
    List<ForwardModel> dataList = controller.dataList;
    for (var data in dataList) {
      EventChatModel model = EventChatModel(
        localChat,
        data.msgType,
        ToolsMessage.convert(data.msgType, data.content),
        handle: false,
      );
      // 发布消息
      EventMessage().listenSend.add(model);
    }
  }

  // 合并转发
  _merge(LocalChat localChat) {
    List<ForwardModel> dataList = controller.dataList;
    EventChatModel model = EventChatModel(
      localChat,
      MsgType.forward,
      ToolsMessage.forward(dataList),
      handle: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}
