import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/wallet/wallet_payment_page.dart';
import 'package:alpaca/pages/wallet/wallet_recharge_page.dart';

// 安全键盘
class WidgetKeyboard extends StatefulWidget {
  final bool operate;
  final String title;
  final Function(String) onPressed;
  const WidgetKeyboard({
    super.key,
    required this.onPressed,
    this.title = '',
    this.operate = true,
  });

  @override
  createState() => _WidgetKeyboardState();
}

class _WidgetKeyboardState extends State<WidgetKeyboard> {
  String value = '';

  @override
  void initState() {
    super.initState();
    // 收起小桌板
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100 * 3 + 5 * 2,
      color: const Color.fromARGB(255, 231, 231, 230),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _buildTitle(),
          ),
          Expanded(
            child: _buildInput(),
          ),
          Expanded(
            flex: 2,
            child: _buildOperate(),
          ),
          Expanded(
            flex: 5,
            child: _buildKeyboard(),
          )
        ],
      ),
    );
  }

  _buildTitle() {
    String title = widget.title;
    if (title.isEmpty) {
      title = '请输入支付密码';
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      width: double.infinity,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  _buildInput() {
    double size = 50;
    int length = 6;
    return Center(
      child: SizedBox(
        width: size * length,
        height: size * length,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: length,
          itemBuilder: (context, index) {
            bool first = index == 0;
            BorderSide borderSide = const BorderSide(width: 0.5);
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                border: Border(
                  left: first ? borderSide : BorderSide.none,
                  top: borderSide,
                  right: borderSide,
                  bottom: borderSide,
                ),
                color: Colors.white,
              ),
              child: Center(
                child: index < value.length
                    ? const Icon(AppFonts.e600)
                    : Container(),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildOperate() {
    if (!widget.operate) {
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.offAndToNamed(WalletPaymentPage.routeName);
          },
          child: const Text(
            '忘记密码',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        InkWell(
          onTap: () {
            Get.offAndToNamed(WalletRechargePage.routeName);
          },
          child: const Text(
            '钱包充值',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  _buildKeyboard() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 2,
      mainAxisSpacing: 2,
      childAspectRatio: 100 / 40,
      children: [
        _buildButton("1"),
        _buildButton("2"),
        _buildButton("3"),
        _buildButton("4"),
        _buildButton("5"),
        _buildButton("6"),
        _buildButton("7"),
        _buildButton("8"),
        _buildButton("9"),
        _buildButton("取消", back: true),
        _buildButton("0"),
        _buildButton("确定", clear: true),
      ],
    );
  }

  _buildButton(
    String text, {
    bool clear = false,
    bool back = false,
  }) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(),
        side: const BorderSide(style: BorderStyle.none),
      ),
      onPressed: () {
        // 返回
        if (back) {
          Get.back();
          return;
        }
        // 清除
        if (clear) {
          if (value.isNotEmpty) {
            value = value.substring(0, value.length - 1);
            setState(() {});
          }
          return;
        }
        // 输入
        if (value.length < 6) {
          value += text;
          setState(() {});
        }
        // 判断
        if (value.length == 6) {
          // 返回
          widget.onPressed.call(value);
          // 返回
          Get.back();
        }
      },
      child: clear
          ? const Icon(
              AppFonts.e67a,
              color: Colors.black,
            )
          : Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
    );
  }
}
