import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_amap.dart';

// 聊天=扩展=位置
class ChatExtraLocation extends StatelessWidget {
  const ChatExtraLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '位置',
      icon: AppFonts.e8ff,
      onTap: () async {
        // 权限
        bool result = await ToolsPerms.location();
        if (!result) {
          return;
        }
        Get.to(WidgetAmap(
          onTap: (pois, data) {
            Get.back();
            _event(pois, data);
          },
        ));
      },
    ).buildItem();
  }

  Future<void> _event(Poi? pois, Uint8List? data) async {
    if (pois == null) {
      return;
    }
    // 消息类型
    MsgType msgType = MsgType.location;
    // 组装消息
    Map<String, dynamic> content = {
      'title': pois.title,
      'latitude': pois.latLng?.latitude,
      'longitude': pois.latLng?.longitude,
      'address': pois.address,
      'thumbnail': AppConfig.thumbnail,
    };
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
      extend: data,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}
