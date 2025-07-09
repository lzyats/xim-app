import 'dart:async';

import 'package:alpaca/event/event_socket.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:getuiflut/getuiflut.dart';

// push个推
class ToolsPush {
  ToolsPush._();
  static ToolsPush? _singleton;
  factory ToolsPush() => _singleton ??= ToolsPush._();

  // 别名
  bool _alias = false;

  // 连接
  Future<void> onConnect() async {
    Getuiflut().addEventHandler(
      onReceiveClientId: (String message) async {},
      onRegisterDeviceToken: (String message) async {},
      // ios接收消息
      onReceivePayload: (Map<String, dynamic> message) async {
        if (MiddleStatus.normal == ToolsStorage().status()) {
          EventSocket().event.add(SocketMessage(false, message['payloadMsg']));
        }
      },
      onReceiveNotificationResponse: (Map<String, dynamic> message) async {},
      onAppLinkPayload: (String message) async {},
      onReceiveOnlineState: (bool online) async {},
      onPushModeResult: (Map<String, dynamic> message) async {},
      onSetTagResult: (Map<String, dynamic> message) async {},
      onAliasResult: (Map<String, dynamic> message) async {},
      onQueryTagResult: (Map<String, dynamic> message) async {},
      onWillPresentNotification: (Map<String, dynamic> message) async {},
      onOpenSettingsForNotification: (Map<String, dynamic> message) async {},
      onGrantAuthorization: (String granted) async {},
      // android接收消息
      onReceiveMessageData: (Map<String, dynamic> event) async {
        if (MiddleStatus.normal == ToolsStorage().status()) {
          EventSocket().event.add(SocketMessage(false, event['payload']));
        }
      },
      onNotificationMessageArrived: (Map<String, dynamic> event) async {},
      onNotificationMessageClicked: (Map<String, dynamic> event) async {},
      onTransmitUserMessageReceive: (Map<String, dynamic> event) async {},
      onLiveActivityResult: (Map<String, dynamic> event) async {},
      onRegisterPushToStartTokenResult: (Map<String, dynamic> event) async {},
    );
  }

  // 断开
  void close() {
    _alias = false;
  }

  // 心跳
  Future<void> heartbeat() async {
    if (_alias) {
      return;
    }
    // 绑定别名
    String? userId = ToolsStorage().local().userId;
    if (userId.isNotEmpty) {
      Getuiflut().bindAlias(userId, userId);
      _alias = true;
    }
  }
}
