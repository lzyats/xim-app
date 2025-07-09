import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_message_trade.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';

Color _color = Colors.orange.shade400;

// 聊天=消息=红包
class ChatMessagePacket extends StatelessWidget {
  final ChatHis chatHis;
  final RxString configAmount;
  final RxString configReceive;
  const ChatMessagePacket(
    this.chatHis,
    this.configAmount,
    this.configReceive, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // 显示类型
    String label = chatHis.msgType.label;
    String amount = chatHis.content['amount'] ?? '';
    if (amount.isNotEmpty) {
      if ('0.00' == amount) {
        label += '  [未抢到]';
      } else {
        label += '  [已领取]';
      }
    }
    // 消息内容
    Map<String, dynamic> content = chatHis.content;
    // 当前用户
    String userId = ToolsStorage().local().userId;
    // 红包颜色
    Color color = Colors.red;
    // 专属红包
    if (MsgType.groupAssign == chatHis.msgType) {
      color = const Color.fromARGB(255, 72, 60, 60);
    }
    return GestureDetector(
      onTap: () {
        // 不可以领取
        if ('N' == configReceive.value) {
          throw Exception('群聊开启了红包禁抢功能');
        }
        // 专属红包
        if (MsgType.groupAssign == chatHis.msgType) {
          String receiveId = content['receiveId'];
          // 他人
          if (!chatHis.self && userId != receiveId) {
            // 提醒
            EasyLoading.showToast('不能领取他人的专属红包');
            return;
          }
          // 自己
          if (chatHis.self) {
            Get.to(ChatMessageTrade(chatHis.msgId));
            return;
          }
        }
        // 个人红包
        else if (MsgType.packet == chatHis.msgType) {
          // 自己
          if (chatHis.self) {
            Get.to(ChatMessageTrade(chatHis.msgId));
            return;
          }
        }
        // 关闭小桌板
        EventSetting().handle(SettingModel(SettingType.close));
        // 弹窗
        Future.delayed(const Duration(milliseconds: 100), () {
          _showDialog(context);
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          width: 220,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                color: color,
                child: Row(
                  children: [
                    Icon(
                      AppFonts.e679,
                      color: _color,
                      size: 50,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content['remark'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Obx(() {
                            String label = '¥ *';
                            if ('Y' == configAmount.value) {
                              label =
                                  '¥ ${double.parse(content['data'].toString()).toStringAsFixed(2)}';
                            }
                            return Text(
                              label,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 143, 141, 141),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (builder) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: _PacketDetails(chatHis),
        );
      },
    );
  }
}

class _PacketDetails extends StatefulWidget {
  final ChatHis chatHis;
  const _PacketDetails(this.chatHis);

  @override
  createState() => _PacketDetailsState();
}

class _PacketDetailsState extends State<_PacketDetails> {
  late ChatHis chatHis;
  @override
  void initState() {
    super.initState();
    chatHis = widget.chatHis;
    initChatHis(chatHis.msgId);
  }

  Future<void> initChatHis(String msgId) async {
    ChatHis? message = await ToolsSqlite().his.getById(msgId);
    if (message == null) {
      return;
    }
    chatHis = message;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String tradeId = chatHis.msgId;
    String amount = chatHis.content['amount'] ?? '';
    String label = '';
    switch (chatHis.msgType) {
      // 个人红包
      case MsgType.packet:
      // 专属红包
      case MsgType.groupAssign:
        if (amount.isNotEmpty) {
          label = '查看领取详情';
        }
        break;
      // 手气红包
      case MsgType.groupLuck:
      // 普通红包
      case MsgType.groupPacket:
        if (amount.isNotEmpty) {
          label = '看看大家的手气';
        }
        break;
      // 其他红包
      default:
        label = '';
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(25),
      width: size.width,
      height: size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // 头像
              WidgetCommon.showAvatar(chatHis.portrait, size: 75),
              const SizedBox(
                height: 10,
              ),
              Text(
                chatHis.nickname,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _color,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                chatHis.content['remark'],
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: _color,
                ),
              ),
            ],
          ),
          if (amount.isEmpty)
            InkWell(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: const Text(
                  '開',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.red,
                  ),
                ),
              ),
              onTap: () {
                _submit(tradeId);
              },
            )
          else
            Text(
              '¥ $amount 元',
              style: TextStyle(
                fontSize: 32,
                color: _color,
              ),
            ),
          InkWell(
            onTap: () {
              Get.off(ChatMessageTrade(tradeId));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black.withOpacity(0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: _color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submit(String tradeId) async {
    // 请求
    if (ToolsSubmit.call()) {
      String amount = await RequestWallet.doReceive(tradeId);
      chatHis.content['amount'] = amount;
      await ToolsSqlite().his.add(chatHis);
      setState(() {});
      // 取消
      ToolsSubmit.cancel();
      // 广播消息
      EventMessage().listenHis.add(chatHis);
    }
  }
}
