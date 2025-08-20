import 'dart:async';

import 'package:alpaca/config/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
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
      icon: Image.asset(
        AppImage.chatzz, // 直接使用图片路径
        width: 24, // 调整图标大小
        height: 24,
        fit: BoxFit.contain, // 保持图片比例
      ),
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '发送转账1',
              style: TextStyle(color: Colors.black),
            ),
          ),
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

// 美化后的金额输入框
  _buildAmount() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          AmountFormatter(),
        ],
        textAlign: TextAlign.right,
        controller: _amountController,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: '¥ 0.00',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 18,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '转账金额',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF4285F4),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          // 移除默认内边距
          isDense: true,
        ),
      ),
    );
  }

// 美化后的备注输入框
  _buildRemark() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.right,
        maxLines: null,
        controller: _remarkController,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: '请输入转账说明',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '转账说明',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF4285F4),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          counterText: '', // 隐藏字数计数器
        ),
        maxLength: 15,
      ),
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
