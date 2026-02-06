import 'dart:async';

import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_socket.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// websocket
class ToolsSocket {
  ToolsSocket._();
  static ToolsSocket? _singleton;
  factory ToolsSocket() => _singleton ??= ToolsSocket._();

  // 连接后的对象
  WebSocketChannel? _channel;
  StreamSubscription? _stream;

  // 计数器
  int _count = 99;

  // 连接
  Future<void> onConnect() async {
    String requestSocket = await getSocketHost();
    print("Socket请求地址：$requestSocket");

    // 判断
    if (MiddleStatus.normal != ToolsStorage().status()) {
      return;
    }
    // 关闭
    _error();
    // 获取token
    String token = ToolsStorage().token();
    // 准备
    Uri url = Uri.parse("$requestSocket/ws?Authorization=$token");
    // 连接
    try {
      _channel = WebSocketChannel.connect(url);
      await _channel?.ready;
    } catch (e) {
      _error();
      return;
    }
    try {
      // 监听
      _stream = _channel?.stream.listen(
        (message) {
          // 心跳
          if ('pong' == message) {
            // 重置计数
            _count = 0;
            // 在线标志
            AppConfig.setOnline(socket: true, network: true);
          }
          // 写入消息
          else if (MiddleStatus.normal == ToolsStorage().status()) {
            EventSocket().event.add(SocketMessage(true, message));
          }
        },
        // 异常
        onError: (error) {
          _error();
        },
        // 断开
        onDone: () {
          _error();
        },
      );
    } catch (e) {
      _error();
    }
    // 在线标志
    AppConfig.setOnline(socket: true, network: true);
    // 拉取离线
    RequestMessage.pullMsg();
  }

  // 从缓存获取WebSocket服务器配置（新增方法）
  static Future<String> getSocketHost() async {
    SysConfig sysConfig = ToolsStorage().sysConfig();
    // 优先使用缓存中的WebSocket地址
    if (sysConfig.requestSocket != null && sysConfig.requestSocket.isNotEmpty) {
      return sysConfig.requestSocket;
    }
    // 缓存为空时使用默认配置
    return AppConfig.requestSocket;
  }

  // 错误
  void _error() {
    // 在线标志
    AppConfig.setOnline(socket: false);
  }

  // 断开
  void close() {
    _stream?.cancel();
  }

  // 心跳
  Future<void> heartbeat() async {
    // 发送心跳
    try {
      _channel?.sink.add('ping');
    } catch (e) {
      // debugPrint('发送失败');
    }
    // 重连
    if ((++_count) > 3) {
      // 重置计数
      _count = 0;
      // 重新连接
      onConnect();
    }
  }
}
