import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 消息处理
class ToolsMessage {
  // 消息内容
  static Map<String, dynamic> convert(
    MsgType msgType,
    Map<String, dynamic> map,
  ) {
    Map<String, dynamic> content = map;
    switch (msgType) {
      case MsgType.text:
      case MsgType.reply:
        content = {
          'data': map['data'],
        };
        break;
      case MsgType.image:
        content = {
          'data': map['data'],
          'height': map['height'],
          'width': map['width'],
          'scan': map['scan'],
        };
        break;
      case MsgType.video:
        content = {
          'data': map['data'],
          'thumbnail': map['thumbnail'],
          'height': map['height'],
          'width': map['width'],
        };
        break;
      case MsgType.file:
        content = {
          'data': map['data'],
          'title': map['title'],
          'mimeType': map['mimeType'],
          'size': map['size'],
        };
        break;
      case MsgType.location:
        content = {
          'title': map['title'],
          'latitude': map['latitude'],
          'longitude': map['longitude'],
          'address': map['address'],
          'thumbnail': map['thumbnail'],
        };
        break;
      case MsgType.card:
        content = {
          'userId': map['userId'],
          'nickname': map['nickname'],
          'userNo': map['userNo'],
          'portrait': map['portrait'],
        };
        break;
      case MsgType.forward:
        content = {
          'title': map['title'],
          'content': map['content'],
        };
        break;
      default:
        break;
    }
    return content;
  }

  // 合并转发
  static Map<String, dynamic> forward(List<ForwardModel> dataList) {
    List<Map<String, dynamic>> contentList = [];
    String title = '${ToolsStorage().chat().nickname}的聊天记录';
    if (ChatTalk.group != ToolsStorage().chat().chatTalk) {
      title = '${ToolsStorage().local().nickname} 和 $title';
    }
    for (var data in dataList) {
      MsgType msgType = data.msgType;
      if (MsgType.reply == msgType) {
        msgType = MsgType.text;
      }
      Map<String, dynamic> content = {
        'source': {
          'portrait': data.source!['portrait'],
          'nickname': data.source!['nickname'],
        },
        'msgType': msgType.value,
        'content': convert(msgType, data.content),
        'createTime': data.createTime!.millisecondsSinceEpoch.toString(),
      };
      contentList.add(content);
    }
    return {
      'title': title,
      'content': contentList,
    };
  }
}
