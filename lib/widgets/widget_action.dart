import 'package:flutter/material.dart';
import 'package:alpaca/config/app_theme.dart';

// 右边组件（保持不变）
class WidgetAction extends StatelessWidget {
  final Icon? icon;
  final bool enable;
  final String label;
  final String label1;
  final VoidCallback onTap;

  const WidgetAction({
    this.enable = true,
    super.key,
    this.icon,
    this.label = '完成',
    this.label1 = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
    if (label1 != '') {
      return InkWell(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0463F7),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            minimumSize: const Size(0, 48),
            shadowColor: Colors.black.withOpacity(0.8),
            elevation: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Text(label1),
          onPressed: onTap,
        ),
      );
    } else {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: icon ??
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF00ABFF),
                ),
                height: 38,
                width: 75,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        ),
      );
    }
  }
}

// 自定义昵称输入框控件（增加圆角和最大长度参数）
class NicknameInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onTextChanged;
  final int maxLength;
  final String hintText;
  // 新增：圆角大小参数
  final double borderRadius;

  // 构造函数添加参数，设置默认值保持兼容性
  const NicknameInputWidget({
    super.key,
    required this.controller,
    this.onTextChanged,
    this.maxLength = 15,
    this.hintText = '请输入昵称',
    this.borderRadius = 5, // 默认保持原5px圆角
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // 使用传递的圆角参数
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                color: Colors.white,
                child: TextField(
                  // 使用传递的最大长度参数
                  maxLength: maxLength,
                  controller: controller,
                  onChanged: onTextChanged,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: hintText,
                    prefixIcon: const Icon(Icons.person),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    counterText: '',
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.black),
                            onPressed: () => controller.clear(),
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                final currentLength = controller.text.length;
                return Text(
                  '$currentLength/$maxLength',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class EnhancedNicknameInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final int maxLength;
  final String hintText;
  final bool showLengthHint;
  final bool isSingleLine;
  final double horizontalPadding;
  final double verticalPadding;
  final bool showPrefixIcon;
  final Widget? prefixIcon;
  final double borderRadius;
  final String overLengthHint;

  const EnhancedNicknameInputWidget({
    super.key,
    required this.controller,
    this.onChanged,
    this.maxLength = 15,
    this.hintText = '请输入昵称',
    this.showLengthHint = true,
    this.isSingleLine = true,
    this.horizontalPadding = 25,
    this.verticalPadding = 20,
    this.showPrefixIcon = true,
    this.prefixIcon =
        const Icon(Icons.person_outline, color: Color(0xFF999999)),
    this.borderRadius = 18,
    this.overLengthHint = '已达到最大输入长度',
  });

  @override
  Widget build(BuildContext context) {
    final baseContentPadding = EdgeInsets.symmetric(
      horizontal: horizontalPadding,
      vertical: verticalPadding,
    );

    final adjustedPadding = showPrefixIcon
        ? baseContentPadding
        : EdgeInsets.only(
            left: baseContentPadding.horizontal / 2,
            right: baseContentPadding.right,
            top: baseContentPadding.top,
            bottom: baseContentPadding.bottom,
          );

    // 计算额外底部内边距（为多行时的字数提示预留空间）
    final extraBottomPadding = showLengthHint && !isSingleLine ? 20.0 : 0.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 3,
                offset: Offset(0, 1),
                spreadRadius: 0.5,
              )
            ],
          ),
          child: Stack(
            children: [
              TextField(
                maxLines: isSingleLine ? 1 : null,
                minLines: isSingleLine ? 1 : 3,
                maxLength: maxLength,
                controller: controller,
                onChanged: (value) {
                  if (value.length > maxLength) {
                    controller.text = value.substring(0, maxLength);
                    controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: maxLength),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(overLengthHint),
                        duration: const Duration(milliseconds: 800),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  if (onChanged != null) {
                    onChanged!(controller.text);
                  }
                },
                textInputAction: isSingleLine
                    ? TextInputAction.done
                    : TextInputAction.newline,
                keyboardType:
                    isSingleLine ? TextInputType.text : TextInputType.multiline,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF333333),
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF999999),
                  ),
                  prefixIcon: showPrefixIcon ? prefixIcon : null,
                  // 为多行输入添加额外底部内边距，避免文字被字数提示遮挡
                  contentPadding: adjustedPadding.copyWith(
                    bottom: adjustedPadding.bottom + extraBottomPadding,
                  ),
                  counterText: '',
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.cancel,
                                  color: Color(0xFF999999)),
                              onPressed: () => controller.clear(),
                              padding: const EdgeInsets.only(right: 8),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ),
              // 字数提示：单行在输入框内右侧，多行在最后一行右下角
              if (showLengthHint)
                Positioned(
                  right: horizontalPadding,
                  bottom: verticalPadding,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      final currentLength = controller.text.length;
                      return Text(
                        '$currentLength/$maxLength',
                        style: TextStyle(
                          color: currentLength >= maxLength
                              ? Colors.red
                              : const Color(0xFF333333),
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
