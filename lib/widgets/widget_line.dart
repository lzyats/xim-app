import 'package:flutter/material.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 表格组件
class WidgetLineTable extends StatelessWidget {
  final String label;
  final bool enable;
  final bool divider;
  final String value;

  const WidgetLineTable(
    this.label,
    this.value, {
    super.key,
    this.enable = true,
    this.divider = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
    String text = '$label :';
    double width = WidgetCommon.textSize(text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(14),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              SizedBox(
                width: width,
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFFa9a9a9),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF353535),
                  ),
                ),
              ),
            ],
          ),
        ),
        // 间隔线
        if (divider) WidgetCommon.divider(),
      ],
    );
  }
}

// 单行组件
class WidgetLineRow extends StatelessWidget {
  final bool enable;
  final bool divider;
  final String title;
  final String? subtitle;
  final Color? color;
  final double hight;
  final Widget? leading;
  final bool badger;
  final int? badger1;
  final String value;
  final Widget? widget;
  final bool arrow;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const WidgetLineRow(
    this.title, {
    this.enable = true,
    this.divider = true,
    this.subtitle,
    this.color,
    this.hight = 0.0,
    this.leading,
    this.badger = false,
    this.badger1 = 0,
    this.value = '',
    this.widget,
    this.arrow = true,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(
                top: hight,
                bottom: hight,
                left: 12,
                right: 5,
              ),
              leading: leading,
              title: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: color,
                ),
              ),
              subtitle: subtitle != null
                  ? Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 149, 144, 144),
                      ),
                    )
                  : null,
              trailing: Container(
                constraints: const BoxConstraints(
                  maxWidth: 110,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: arrow ? 0 : 10),
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    widget ?? Container(),
                    arrow ? WidgetCommon.arrow() : Container(),
                  ],
                ),
              ),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            if (badger)
              Positioned(
                right: 20,
                top: 20,
                //bottom: 0,
                child: TDBadge(
                  TDBadgeType.message,
                  count: badger1! > 99 ? '99+' : badger1.toString(),
                  size: TDBadgeSize.large,
                  padding: EdgeInsetsGeometry.infinity,
                ),
              ),
          ],
        ),
        if (divider) WidgetCommon.divider(),
      ],
    );
  }
}

// 单行组件
// 单行居中组件（新增字体大小配置参数）
class WidgetLineCenter extends StatelessWidget {
  final String title;
  final bool enable;
  final bool divider;
  final Color? color;
  final GestureTapCallback? onTap;
  // 新增：字体大小参数，默认14（与原组件默认样式一致）
  final double? fontSize;

  // 构造函数：添加fontSize参数，默认值设为14
  const WidgetLineCenter(
    this.title, {
    this.enable = true,
    this.divider = true,
    this.color,
    this.onTap,
    this.fontSize = 14, // 默认字体大小，兼容原有使用场景
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return Container();
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      // 绑定新增的fontSize参数，??确保不为空（兜底14）
                      fontSize: fontSize ?? 14,
                    ),
                  ),
                ],
              ),
            ),
            if (divider) WidgetCommon.divider(),
          ],
        ),
      ),
    );
  }
}

// 内容组件
class WidgetLineContent extends StatelessWidget {
  final String label;
  final String value;
  final bool divider;

  final GestureTapCallback? onTap;

  const WidgetLineContent(
    this.label,
    this.value, {
    this.divider = true,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 15),
            padding: const EdgeInsets.only(left: 12, right: 6),
            child: Row(
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                    value,
                    maxLines: 8,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                onTap != null ? WidgetCommon.arrow() : Container(width: 10),
              ],
            ),
          ),
          if (divider) WidgetCommon.divider(),
        ],
      ),
    );
  }
}
