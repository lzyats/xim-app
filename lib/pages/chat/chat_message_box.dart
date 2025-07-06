import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_trade_page.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=消息=卡片
class ChatMessageBox extends StatelessWidget {
  final ChatHis chatHis;
  const ChatMessageBox(this.chatHis, {super.key});

  @override
  Widget build(BuildContext context) {
    // 消息内容
    String title = chatHis.content['title'];
    String content = chatHis.content['content'];
    String remark = chatHis.content['remark'];
    String type = chatHis.content['type'];
    String value = chatHis.content['value'];
    // 高度
    double height = 120;
    // 计算备注
    height += _remarkHeight(context, remark);
    // 计算更多
    if ('system' != type) {
      height += 30;
    }
    return GestureDetector(
      onTap: () {
        if ('trade' == type) {
          // 返回
          Get.toNamed(WalletTradeInfoPage.routeName, arguments: value);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        width: double.infinity,
        height: height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white70,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            WidgetCommon.divider(indent: 0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(remark),
            if ('system' != type) WidgetCommon.divider(indent: 0),
            if ('system' != type)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('查看详情'),
                  WidgetCommon.arrow(),
                ],
              ),
          ],
        ),
      ),
    );
  }

  _remarkHeight(BuildContext context, String remark) {
    // 备注宽度
    double remarkWidth = WidgetCommon.textSize(remark);
    // 屏幕宽度
    double mediaWidth = MediaQuery.of(context).size.width - 36;
    // 计算备注
    return (remarkWidth / mediaWidth).ceil() * 20;
  }
}
