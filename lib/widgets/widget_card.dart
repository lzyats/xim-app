import 'package:flutter/material.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 名片组件
class WidgetCard extends StatelessWidget {
  final String nickname;
  final String portrait;
  final String userNo;
  const WidgetCard({
    super.key,
    required this.nickname,
    required this.portrait,
    required this.userNo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: WidgetCommon.showAvatar(
              portrait,
              size: 55,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'ID：$userNo',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 123, 122, 122),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
