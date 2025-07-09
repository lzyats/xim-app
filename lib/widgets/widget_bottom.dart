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
                title: Text(
                  model.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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

  BottomModel(this.label, {this.onTap});
}
