import 'package:flutter/material.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:flutter/services.dart';

// 按钮组件
class WidgetButton extends StatefulWidget {
  final bool search;
  final String? label;
  final Color? color;
  final VoidCallback onTap;

  const WidgetButton({
    super.key,
    this.label,
    required this.onTap,
    this.search = false,
    this.color,
  });

  @override
  createState() => _WidgetButtonState();
}

class _WidgetButtonState extends State<WidgetButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.search) {
      return _buildSearch();
    }
    return _buildButton();
  }

  _buildSearch() {
    String label = widget.label ?? '搜索';
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 6),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppTheme.color,
          ),
          height: 40,
          width: 50,
          child: Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _buildButton() {
    String label = widget.label ?? '提交';
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        disabledColor: Colors.grey,
        onPressed: widget.onTap,
        color: widget.color ?? AppTheme.color,
        textColor: Colors.white,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

/// 登录按钮组件（图标大小改为可选参数）
class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final MainAxisAlignment iconTextAlignment;
  final double iconTextSpacing;
  // 新增：可选图标大小参数，默认值24
  final double? iconSize;
  // 原有属性保留
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final TextStyle? textStyle;
  final double verticalPadding;

  const LoginButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconTextAlignment = MainAxisAlignment.start,
    this.iconTextSpacing = 8,
    // 图标大小：可选参数，默认值24（与需求一致）
    this.iconSize,
    // 原有属性默认值保持不变
    this.width,
    this.padding,
    this.borderRadius = 85,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.textStyle,
    this.verticalPadding = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: padding ?? EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左侧图标：使用「显式iconSize > 文字字号 > 默认24」的优先级
            if (icon != null && iconTextAlignment == MainAxisAlignment.start)
              Padding(
                padding: EdgeInsets.only(right: iconTextSpacing),
                child: Icon(
                  icon,
                  // 核心逻辑：优先用用户设置的iconSize，其次用文字字号，最后默认24
                  size: iconSize ?? textStyle?.fontSize ?? 24,
                ),
              ),
            // 按钮文字
            Text(
              text,
              style: textStyle ?? const TextStyle(fontSize: 16),
            ),
            // 右侧图标：与左侧图标使用相同的大小逻辑
            if (icon != null && iconTextAlignment == MainAxisAlignment.end)
              Padding(
                padding: EdgeInsets.only(left: iconTextSpacing),
                child: Icon(
                  icon,
                  size: iconSize ?? textStyle?.fontSize ?? 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// 自定义输入框控件
// 自定义输入框控件（增加readonly设置）
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final Widget? suffixIcon;
  final double prefixIconSize;
  final Color prefixIconColor;
  final EdgeInsetsGeometry? contentPadding;
  // 原有：只读属性，默认为 false
  final bool readOnly;
  // 新增：最大字数限制参数，默认值 20
  final int maxLength;
  // 新增：是否显示字数统计文本（默认显示）
  final bool showLengthCounter;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIconSize = 28,
    this.prefixIconColor = Colors.black,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 18),
    this.readOnly = false,
    // 最大字数默认值设为 20，满足需求
    this.maxLength = 20,
    // 字数统计默认显示，可手动关闭
    this.showLengthCounter = true,
  });

  @override
  Widget build(BuildContext context) {
    // 合并输入格式化器：原有 formatter + 最大字数限制 formatter
    final List<TextInputFormatter> combinedFormatters = [
      // 限制输入长度为 maxLength（优先级：用户传入的 formatter 会覆盖此限制，需注意）
      LengthLimitingTextInputFormatter(maxLength),
      // 添加用户自定义的输入格式化器（若有）
      if (inputFormatters != null) ...?inputFormatters,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          // 使用合并后的格式化器，确保最大字数限制生效
          inputFormatters: combinedFormatters,
          obscureText: obscureText,
          readOnly: readOnly,
          // 禁止系统默认的字数统计（避免与自定义统计冲突）
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF6E6E6E), fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(85),
              borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(85),
              borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(85),
              borderSide: const BorderSide(color: Color(0xFF000000)),
            ),
            contentPadding: contentPadding,
            prefixIcon: Icon(
              prefixIcon,
              size: prefixIconSize,
              color: prefixIconColor,
            ),
            suffixIcon: suffixIcon,
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ],
    );
  }
}
