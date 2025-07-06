import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=扩展=红包
class ChatExtraPacket extends StatelessWidget {
  const ChatExtraPacket({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '红包',
      icon: AppFonts.e679,
      onTap: () {
        Get.to(const ChatExtraPacketItem());
      },
    ).buildItem();
  }
}

class ChatExtraPacketItem extends StatefulWidget {
  const ChatExtraPacketItem({super.key});

  @override
  createState() => _ChatExtraPacketItemState();
}

class _ChatExtraPacketItemState extends State<ChatExtraPacketItem> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  double amount = 0;
  double packet = ToolsStorage().config().packet;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      String text = _amountController.text.trim();
      if (text.isEmpty) {
        amount = 0;
      } else {
        amount = double.parse(text);
        if (amount > packet) {
          amount = 0;
          _amountController.clear();
        }
      }
      setState(() {});
    });
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      Get.back();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _amountController.dispose();
      _remarkController.dispose();
      _subscription?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '发送红包',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: KeyboardDismissOnTap(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetCommon.customRedClipper(),
              _buildArea(),
            ],
          ),
        ),
      ),
    );
  }

  _buildArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          WidgetCommon.tips(
            '红包最大金额¥ ${packet.toStringAsFixed(2)} 元',
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '¥ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
          _buildSubmit(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '红包超过24小时未领取将会自动退回',
          ),
        ],
      ),
    );
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        AmountFormatter(),
      ],
      textAlign: TextAlign.right,
      controller: _amountController,
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包金额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  // 备注
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: _remarkController,
      decoration: const InputDecoration(
        hintText: '恭喜发财，大吉大利',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包备注',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      maxLength: 15,
    );
  }

  _buildSubmit() {
    return WidgetButton(
      label: '塞进红包',
      color: Colors.red,
      onTap: () {
        if (ToolsSubmit.progress()) {
          return;
        }
        if (amount < 0.01) {
          throw Exception('红包金额不能为空');
        }
        WidgetCommon.showKeyboard(
          context,
          onPressed: (value) {
            if (ToolsSubmit.call(millisecond: 10000)) {
              _submit(amount, value);
            }
          },
        );
      },
    );
  }

  _submit(double amount, String password) {
    String remark = _remarkController.text.trim();
    if (remark.isEmpty) {
      remark = '恭喜发财，大吉大利';
    }
    // 消息类型
    MsgType msgType = MsgType.packet;
    // 组装消息
    Map<String, dynamic> content = {
      'data': amount,
      'remark': remark,
      'password': password,
    };
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
      handle: false,
      write: false,
      result: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}
