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
    this.divider = true,
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
  final Icon? leading;
  final bool badger;
  final String? value;
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
    this.value,
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  value != null
                      ? Padding(
                          padding: EdgeInsets.only(right: arrow ? 0 : 10),
                          child: Text(
                            value!,
                            maxLines: 8,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Container(),
                  widget ?? Container(),
                  arrow ? WidgetCommon.arrow() : Container(),
                ],
              ),
              onTap: onTap,
              onLongPress: onLongPress,
            ),
            if (badger)
              const Positioned(
                left: 45,
                top: 10,
                child: TDBadge(
                  TDBadgeType.redPoint,
                  size: TDBadgeSize.large,
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
class WidgetLineCenter extends StatelessWidget {
  final String title;
  final bool enable;
  final bool divider;
  final Color? color;
  final GestureTapCallback? onTap;

  const WidgetLineCenter(
    this.title, {
    this.enable = true,
    this.divider = true,
    this.color,
    this.onTap,
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
                      fontSize: 14,
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
                  width: 10,
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
