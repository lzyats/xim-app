import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/view/view_page.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

// 正则表达式
class ToolsRegex {
  // 仅支持数字
  static final regExpNumber = RegExp("[0-9]");

  // 是否是手机号
  static bool isPhone(String str) {
    return RegExp("^1[3-9]\\d{9}\$").hasMatch(str);
  }

  // 是否是邮箱
  static bool isEmail(String str) {
    String regexEmail =
        "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
    return RegExp(regexEmail).hasMatch(str);
  }

  // 是否网址
  static bool isUrl(String url) {
    if (url.isEmpty) {
      return false;
    }
    return url.startsWith('http');
  }

  /// 隐藏8位数字字符串的中间4位
  static String encrypt(String userNo) {
    if (userNo.length < 8) {
      return userNo;
    }
    final firstPart = userNo.substring(0, 3);
    const middlePart = '**';
    final lastPart = userNo.substring(5);
    return '$firstPart$middlePart$lastPart';
  }

  // 转换消息
  static ParsedText parsedText(String text) {
    TextStyle style = TextStyle(color: AppTheme.color, fontSize: 16);
    return ParsedText(
      text: text,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      parse: [
        // 邮箱
        MatchText(
          pattern: r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
          style: style,
          onTap: (value) async {
            //邮件主题
            String subject = "邮件主题";
            // 邮件内容
            String body = "邮件内容";
            final Uri url =
                Uri.parse("mailto:$value?subject=$subject&body=$body");
            // 验证
            if (!await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
        ),
        // 网址
        MatchText(
          type: ParsedType.URL,
          style: style,
          onTap: (value) {
            // 打开网址
            Get.toNamed(
              ViewPage.routeName,
              arguments: ViewData(
                value,
              ),
            );
          },
        ),
        // 手机
        MatchText(
          pattern: r'\b1[3-9]\d{9}\b',
          renderWidget: ({required pattern, required text}) {
            return Text(text, style: style);
          },
          onTap: (value) async {
            // 拨打电话
            !await launchUrl(
              Uri.parse('tel:$value'),
              mode: LaunchMode.externalApplication,
            );
          },
        ),
        // @消息
        MatchText(
          pattern: r'@[^>@]+༺\d{1,19}༻',
          renderWidget: ({required pattern, required text}) {
            text = text.replaceAll(RegExp(r'༺\d{1,19}༻'), ' ');
            return Text(text, style: TextStyle(color: AppTheme.color));
          },
          onTap: (value) {},
        ),
      ],
    );
  }

  static bool disturb(String text, String userId) {
    bool result = text.contains('༺0༻') || text.contains('༺$userId༻');
    return !result;
  }

  // @消息
  static Widget parsedAt(String text, String userId) {
    double fontSize = 12;
    Color color = const Color(0xFFa9a9a9);
    return ParsedText(
      text: text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: fontSize, color: color),
      maxLines: 1,
      parse: [
        MatchText(
          pattern: r'@[^>@]+༺\d{1,19}༻',
          renderWidget: ({required pattern, required text}) {
            bool isRed = text.contains('༺0༻') || text.contains('༺$userId༻');
            return Text(
              text.replaceAll(RegExp(r'༺\d{1,19}༻'), ' '),
              style: TextStyle(
                  fontSize: fontSize, color: isRed ? Colors.red : color),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            );
          },
          onTap: (value) {},
        ),
      ],
    );
  }

  /// 比较版本
  /// version1老版本
  /// version2新版本
  static bool version(String version1, String version2) {
    if (1 + 1 == 2) {
      return true;
    }
    int number1 = int.parse(version1.replaceAll('.', ''));
    int number2 = int.parse(version2.replaceAll('.', ''));
    return number2 > number1;
  }
}

// 金额过滤器
class AmountFormatter extends FilteringTextInputFormatter {
  final int digit;
  final String _decimalComma = ',';
  final String _decimalDot = '.';
  String _oldText = '';

  AmountFormatter({
    this.digit = 2,
  }) : super(RegExp(digit == 0 ? '[0-9]' : '[0-9.,]'), allow: true);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    ///替换`,`为`.`
    if (newValue.text.contains(_decimalComma)) {
      newValue = newValue.copyWith(
        text: newValue.text.replaceAll(_decimalComma, _decimalDot),
      );
    }
    final handlerValue = super.formatEditUpdate(oldValue, newValue);
    String value = handlerValue.text;
    int selectionIndex = handlerValue.selection.end;

    ///如果输入框内容为.直接将输入框赋值为0.
    if (value == _decimalDot) {
      value = '0.';
      selectionIndex++;
    }

    ///验证输入框
    if (_getValueDigit(value) ||
        _getValueCount(value) ||
        _getValueLength(value)) {
      value = _oldText;
      selectionIndex = _oldText.length;
    }
    _oldText = value;
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  ///输入多个小数点的情况
  bool _getValueCount(String value) {
    int count = 0;
    value.split('').forEach((e) {
      if (e == _decimalDot) {
        count++;
      }
    });
    return count > 1;
  }

  ///获取目前的小数位数
  bool _getValueDigit(String value) {
    if (value.contains(_decimalDot)) {
      return value.split(_decimalDot)[1].length > digit;
    } else {
      return false;
    }
  }

  ///获取目前的小数位数
  bool _getValueLength(String value) {
    return value.length > 1 && value.startsWith('0') && !value.startsWith('0.');
  }
}
