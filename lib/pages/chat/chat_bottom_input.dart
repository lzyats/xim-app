import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alpaca/config/app_theme.dart';

// 聊天=底部=文字
class ChatBottomInput extends StatelessWidget {
  final TextEditingController textController;
  final ScrollController scrollController;
  final FocusNode focusNode;
  const ChatBottomInput({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedTextField(
      controller: textController,
      scrollController: scrollController,
      focusNode: focusNode,
      minLines: 1,
      maxLines: 5,
      maxLength: 5000,
      specialTextSpanBuilder: _ChatBottomInputBuilder(),
      maxLengthEnforcement: MaxLengthEnforcement.none,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(10),
        counterText: '',
      ),
    );
  }
}

const String startFlag = '@';
const String middleFlag = '༺';
const String endFlag = '༻';

class _ChatBottomInputBuilder extends SpecialTextSpanBuilder {
  _ChatBottomInputBuilder();

  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    if (data == '') {
      return TextSpan(text: '', style: textStyle);
    }
    final List<InlineSpan> inlineList = <InlineSpan>[];
    // 空数据
    if (data.isEmpty) {
      inlineList.add(TextSpan(text: data, style: textStyle));
    }
    // 非空数据
    else {
      // 拼接字符
      String stackText = '';
      int index = 0;
      for (int i = 0; i < data.length; i++) {
        final String char = data[i];
        // 开始
        if (startFlag == char) {
          if (stackText.isNotEmpty) {
            inlineList.add(TextSpan(text: stackText, style: textStyle));
            stackText = '';
          }
          index++;
          stackText += char;
        }
        // 结束
        else if (endFlag == char) {
          index++;
          stackText += char;
          SpecialText? specialText = createSpecialText(
            stackText,
            textStyle: textStyle,
            onTap: onTap,
            index: index - stackText.length,
          );
          if (specialText != null) {
            inlineList.add(specialText.finishText());
            stackText = '';
          }
        }
        // 其他
        else {
          index++;
          stackText += char;
        }
      }
      if (stackText.isNotEmpty) {
        inlineList.add(TextSpan(text: stackText, style: textStyle));
      }
    }
    return TextSpan(children: inlineList, style: textStyle);
  }

  @override
  SpecialText? createSpecialText(
    String flag, {
    TextStyle? textStyle,
    SpecialTextGestureTapCallback? onTap,
    int? index,
  }) {
    if (!flag.startsWith(startFlag)) {
      return null;
    }
    if (!flag.endsWith(endFlag)) {
      return null;
    }
    if (!flag.contains(middleFlag)) {
      return null;
    }
    return _SpecialText(flag, index!);
  }
}

class _SpecialText extends SpecialText {
  _SpecialText(
    this.text,
    this.start,
  ) : super(startFlag, endFlag, null);
  final String text;
  final int start;

  @override
  InlineSpan finishText() {
    return SpecialTextSpan(
      text: '${text.substring(0, text.indexOf(middleFlag))} ',
      actualText: text,
      start: start,
      style: TextStyle(color: AppTheme.color),
    );
  }
}
