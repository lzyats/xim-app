import 'package:flutter/material.dart';
import 'package:alpaca/config/app_fonts.dart';

// 顶部弹出组件
class WidgetPopup extends StatelessWidget {
  final List<PopupModel> dataList;
  const WidgetPopup({
    super.key,
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem> itemList = [];
    for (var data in dataList) {
      itemList.add(_popupItem(data));
    }
    return PopupMenuButton(
      color: Colors.white,
      offset: const Offset(0, 50),
      icon: const Icon(
        AppFonts.e625,
      ),
      itemBuilder: (BuildContext context) {
        return itemList;
      },
    );
  }

  // 顶部add加号详情
  _popupItem(PopupModel popupModel) {
    return PopupMenuItem(
      onTap: popupModel.onTap,
      child: Column(
        children: [
          Row(
            children: [
              popupModel.icon,
              const SizedBox(width: 10),
              Text(
                popupModel.label,
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PopupModel {
  String label;
  Icon icon;
  VoidCallback? onTap;
  PopupModel(
    this.label,
    this.icon, {
    required this.onTap,
  });
}
