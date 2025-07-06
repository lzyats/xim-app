import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/msg/msg_chat_controller.dart';
import 'package:alpaca/pages/msg/msg_chat_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

// 路由跳转控制器
// 当存在历史页面，直接跳回历史页面，如：
// A=>B=>C=>D=>C,当又进入C页面，为了不无限套娃，直接跳回到B页面
// A=>B=>C
class ToolsRoute {
  // 跳转到聊天页面
  void chatPage({
    required String chatId,
    required String nickname,
    String remark = '',
    required String portrait,
    required ChatTalk chatTalk,
  }) {
    // 路由页面
    String routeName = MsgChatPage.routeName;
    // 构建对象
    LocalChat localChat = LocalChat(
      chatId: chatId,
      title: remark.isNotEmpty ? remark : nickname,
      nickname: nickname,
      portrait: portrait,
      chatTalk: chatTalk,
      //
    );
    // 保存对象
    ToolsStorage().chat(value: localChat);
    // 是否存在当前路由
    if (existRoute(routeName)) {
      // 刷新
      if (Get.isRegistered<MsgChatController>()) {
        MsgChatController controller = Get.find<MsgChatController>();
        controller.onInit();
      }
      // 跳转
      Get.until((route) => route.settings.name == routeName);
      return;
    }
    // 执行方法
    Get.toNamed(routeName);
  }

  // 是否存在当前路由
  bool existRoute(String routeName) {
    for (Route route in NavigationHistoryObserver().history) {
      if (routeName == route.settings.name) {
        return true;
      }
    }
    return false;
  }

  // 去页面
  void toPage(String routeName) {
    // 跳转
    Get.offUntil(GetPageRoute(routeName: routeName),
        (route) => routeName == route.settings.name);
    // 返回上一页
    Get.back();
  }
}
