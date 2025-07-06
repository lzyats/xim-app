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

double maxAmount = 999999;

// 聊天=扩展=转账
class ChatExtraTransfer extends StatelessWidget {
  const ChatExtraTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '转账',
      icon: AppFonts.e686,
      onTap: () {
        Get.to(const ChatExtraTransferItem());
      },
    ).buildItem();
  }
}

class ChatExtraTransferItem extends StatefulWidget {
  const ChatExtraTransferItem({super.key});

  @override
  createState() => _ChatExtraTransferItemState();
}

class _ChatExtraTransferItemState extends State<ChatExtraTransferItem> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  double amount = 0;
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
        if (amount > maxAmount) {
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
          '发送转账',
        ),
      ),
      body: KeyboardDismissOnTap(
        child: SingleChildScrollView(
          child: _buildArea(),
        ),
      ),
    );
  }

  _buildArea() {
    LocalChat localChat = ToolsStorage().chat();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          WidgetCommon.showAvatar(
            localChat.portrait,
            size: 100,
          ),
          Text(localChat.title),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '转账前请确认对方信息真实性',
          ),
          const SizedBox(
            height: 10,
          ),
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '转账最大金额¥ ${maxAmount.toStringAsFixed(2)} 元',
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
            '注意：转账金额会实时到达对方账户',
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
            '转账金额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  // 说明
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: _remarkController,
      decoration: const InputDecoration(
        hintText: '请输入转账说明',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '转账说明',
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
      label: '转账',
      onTap: () {
        if (ToolsSubmit.progress()) {
          return;
        }
        if (amount < 0.01) {
          throw Exception('转账金额不能为空');
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
      remark = '';
    }
    // 消息类型
    MsgType msgType = MsgType.transfer;
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
