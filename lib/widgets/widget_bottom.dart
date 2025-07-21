import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 底部弹出
class WidgetBottom {
  WidgetBottom(List<BottomModel> dataList) {
    dataList.add(
      BottomModel(
        '取消',
        onTap: () {
          Get.back();
        },
      ),
    );
    int length = dataList.length;
    showModalBottomSheet(
      context: AppConfig.navigatorKey.currentState!.context,
      builder: (builder) {
        return SizedBox(
          height: 60.0 * length,
          child: ListView.separated(
            itemCount: length,
            separatorBuilder: (BuildContext context, int index) {
              if (length == index + 2) {
                return Container(
                  color: Colors.grey.shade200,
                  height: 12,
                );
              }
              return WidgetCommon.divider();
            },
            itemBuilder: (ctx, index) {
              BottomModel model = dataList[index];
              return ListTile(
                // 移除 leading 属性，因为我们将图标和文字放到一个容器中
                // 文字和图标整体居中
                title: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (model.icon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: model.icon,
                        ),
                      Text(
                        model.label,
                        style: TextStyle(
                          color: AppTheme.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // 调整内边距，让内容居中显示
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                onTap: model.onTap,
              );
            },
          ),
        );
      },
    );
  }
}

// 底部弹出对象
class BottomModel {
  // 文本
  String label;
  // 点击
  GestureTapCallback? onTap;
  Icon? icon; // 图标属性

  BottomModel(this.label, {this.onTap, this.icon});
}
