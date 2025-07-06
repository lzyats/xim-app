import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/request/request_collect.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_message.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:open_file/open_file.dart';

// 聊天=消息=弹窗
class ChatMessageBubble extends StatelessWidget {
  final ChatHis chatHis;
  final double height;
  final RxString configManager;
  final RxBool configCheckBox;
  final RxMap<String, dynamic> configReply;

  const ChatMessageBubble({
    super.key,
    required this.chatHis,
    required this.height,
    required this.configManager,
    required this.configCheckBox,
    required this.configReply,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> dataList = _buildList(chatHis);
    double top = height - 25;
    var size = MediaQuery.of(context).size.height;
    if (height > size / 2) {
      top = height - (dataList.length < 5 ? 50 : 100);
    }
    return Stack(
      children: [
        Positioned(
          top: top,
          left: chatHis.self ? null : 70,
          right: chatHis.self ? 70 : null,
          child: _buildMenu(dataList),
        ),
      ],
    );
  }

  _buildList(ChatHis chatHis) {
    // 类型
    List<BubbleType> bubbleList = [];
    // 类型
    MsgType msgType = chatHis.msgType;
    // 复制
    switch (msgType) {
      case MsgType.text:
      case MsgType.reply:
        bubbleList.add(BubbleType.copy);
        break;
      default:
        break;
    }
    // 删除
    bubbleList.add(BubbleType.delete);
    // 多选
    bubbleList.add(BubbleType.checkbox);
    // 成功/失败
    if ('R' != chatHis.status) {
      // 收藏
      switch (msgType) {
        case MsgType.text:
        case MsgType.reply:
        case MsgType.image:
        case MsgType.video:
        case MsgType.file:
        case MsgType.card:
        case MsgType.location:
          bubbleList.add(BubbleType.collect);
          break;
        default:
          break;
      }
      // 撤回
      if (chatHis.self || 'Y' == configManager.value) {
        switch (msgType) {
          case MsgType.text:
          case MsgType.at:
          case MsgType.image:
          case MsgType.video:
          case MsgType.voice:
          case MsgType.file:
          case MsgType.card:
          case MsgType.location:
          case MsgType.forward:
          case MsgType.reply:
            bubbleList.add(BubbleType.recall);
            break;
          default:
            break;
        }
      }
      // 保存
      switch (msgType) {
        case MsgType.image:
        case MsgType.video:
          bubbleList.add(BubbleType.save);
          break;
        default:
          break;
      }
      // 保存/打开
      if (MsgType.file == msgType) {
        File file = File(chatHis.content['thumbnail'] ?? '');
        if (file.existsSync()) {
          bubbleList.add(BubbleType.open);
        } else {
          bubbleList.add(BubbleType.save);
        }
      }
      // 转发
      if (msgType.isForward) {
        bubbleList.add(BubbleType.forward);
      }
      // 识别
      if (MsgType.image == msgType) {
        String scan = chatHis.content['scan'] ?? '';
        if (scan.isNotEmpty) {
          bubbleList.add(BubbleType.scan);
        }
      }
      // 引用
      switch (msgType) {
        case MsgType.text:
        case MsgType.reply:
        case MsgType.image:
        case MsgType.video:
        case MsgType.file:
        case MsgType.card:
        case MsgType.location:
        case MsgType.forward:
          bubbleList.add(BubbleType.reply);
          break;
        default:
          break;
      }
    }
    // 升序
    bubbleList.sort((a, b) => a.sort.compareTo(b.sort));
    // 结果
    List<Widget> dataList = [];
    for (var bubbleType in bubbleList) {
      dataList.add(_ChatMessageBubbleMenu(
        bubbleType,
        chatHis,
        configCheckBox,
        configReply,
      ));
    }
    return dataList;
  }

  _buildMenu(List<Widget> dataList) {
    while (dataList.length > 4 && dataList.length % 8 != 0) {
      dataList.add(Container(width: 60, height: 70, color: Colors.white));
    }
    List<Widget> dataList1 = [];
    List<Widget> dataList2 = [];
    if (dataList.length < 5) {
      dataList1 = dataList;
    } else if (dataList.length == 8) {
      dataList1 = dataList.sublist(0, 4);
      dataList2 = dataList.sublist(4, 8);
    }
    return Container(
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色
            spreadRadius: 2, // 扩散半径
            blurRadius: 7, // 模糊半径
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: dataList1,
          ),
          Row(
            children: dataList2,
          ),
        ],
      ),
    );
  }
}

// 设置
enum BubbleType {
  // 复制
  copy('copy', '复制', Icon(AppFonts.e6dd), 1),
  // 转发
  forward('forward', '转发', Icon(AppFonts.e655), 2),
  // 收藏
  collect('collect', '收藏', Icon(AppFonts.e646), 3),
  // 识别
  scan('scan', '识别', Icon(AppFonts.e663), 4),
  // 保存
  save('save', '保存', Icon(AppFonts.e63c), 5),
  // 打开
  open('open', '打开', Icon(AppFonts.e63c), 6),
  // 删除
  delete('delete', '删除', Icon(AppFonts.e617), 7),
  // 多选
  checkbox('checkbox', '多选', Icon(AppFonts.e608), 8),
  // 撤回
  recall('recall', '撤回', Icon(AppFonts.e670), 9),
  // 引用
  reply('reply', '引用', Icon(AppFonts.e60a), 10),
  ;

  const BubbleType(this.value, this.name, this.icon, this.sort);
  final String value;
  final String name;
  final Icon icon;
  final int sort;
}

// 显示气泡菜单
class _ChatMessageBubbleMenu extends StatelessWidget {
  final BubbleType bubble;
  final ChatHis chatHis;
  final RxBool configCheckBox;
  final RxMap<String, dynamic> configReply;

  const _ChatMessageBubbleMenu(
    this.bubble,
    this.chatHis,
    this.configCheckBox,
    this.configReply,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 70,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bubble.icon,
            const SizedBox(
              height: 2.0,
            ),
            Text(
              bubble.name,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        // 关闭
        Get.back();
        // 复制
        if (BubbleType.copy == bubble) {
          String text = chatHis.content['data'];
          Clipboard.setData(ClipboardData(text: text));
          EasyLoading.showToast('复制成功');
          return;
        }
        // 收藏
        if (BubbleType.collect == bubble) {
          if (ToolsSubmit.call()) {
            // 类型
            MsgType msgType = chatHis.msgType;
            if (MsgType.reply == msgType) {
              msgType = MsgType.text;
            }
            // 内容
            Map<String, dynamic> content =
                ToolsMessage.convert(msgType, chatHis.content);
            RequestCollect.add(msgType, content);
          }
          return;
        }
        // 删除
        if (BubbleType.delete == bubble) {
          // 删除消息
          EventSetting().handle(
            SettingModel(
              SettingType.remove,
              primary: chatHis.chatId,
              label: 'remove',
              dataList: [chatHis.msgId, chatHis.syncId],
            ),
          );
          return;
        }
        // 撤回
        if (BubbleType.recall == bubble) {
          // 消息类型
          MsgType msgType = MsgType.recall;
          // 组装消息
          Map<String, dynamic> content = {
            'chatId': chatHis.chatId,
            'data': chatHis.msgId,
          };
          // 发布消息
          EventMessage().listenSend.add(
                EventChatModel(
                  ToolsStorage().chat(),
                  msgType,
                  content,
                  write: false,
                ),
              );
          return;
        }
        // 保存
        if (BubbleType.save == bubble) {
          // 权限
          bool result = await ToolsPerms.storage();
          if (!result) {
            return;
          }
          ToolsSubmit.show(millisecond: 60000);
          // 类型
          MsgType msgType = chatHis.msgType;
          // 路径
          String filePath = chatHis.content['data'];
          // 保存
          switch (msgType) {
            case MsgType.image:
              String savePath = await WidgetCommon.saveImage(filePath);
              chatHis.content['thumbnail'] = savePath;
              break;
            case MsgType.video:
              String savePath = await WidgetCommon.saveImage(
                filePath,
                suffix: 'mp4',
              );
              chatHis.content['localPath'] = savePath;
              break;
            case MsgType.file:
              String savePath = await WidgetCommon.saveFile(filePath);
              chatHis.content['thumbnail'] = savePath;
              break;
            default:
              break;
          }
          // 保存
          await ToolsSqlite().his.add(chatHis);
          // 提示
          EasyLoading.showToast('保存成功');
          return;
        }
        // 打开
        if (BubbleType.open == bubble) {
          String filePath = chatHis.content['thumbnail'];
          OpenFile.open(filePath);
          return;
        }
        // 转发
        if (BubbleType.forward == bubble) {
          // 转发
          MsgType msgType = chatHis.msgType;
          await Get.toNamed(
            MsgForwardPage.routeName,
            arguments: [
              ForwardModel(msgType, chatHis.content),
            ],
          );
          return;
        }
        // 识别
        if (BubbleType.scan == bubble) {
          // 扫码结果
          String scan = chatHis.content['scan'] ?? '';
          // 执行扫码
          ToolsScan.doScan(scan);
          return;
        }
        // 多选
        if (BubbleType.checkbox == bubble) {
          configCheckBox.value = true;
          return;
        }
        // 引用
        if (BubbleType.reply == bubble) {
          // 类型
          Map<String, dynamic> content = chatHis.content;
          MsgType msgType = chatHis.msgType;
          if (MsgType.reply == msgType) {
            msgType = MsgType.text;
          }
          configReply.value = {
            'msgType': msgType.value,
            'content': jsonEncode(ToolsMessage.convert(msgType, content)),
            'nickname': chatHis.source['nickname'],
          };
          return;
        }
      },
    );
  }
}
