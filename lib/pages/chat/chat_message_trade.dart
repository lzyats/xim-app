import 'package:flutter/material.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 聊天=消息=交易
class ChatMessageTrade extends StatefulWidget {
  final String tradeId;
  const ChatMessageTrade(this.tradeId, {super.key});

  @override
  createState() => _ChatMessageTradeState();
}

class _ChatMessageTradeState extends State<ChatMessageTrade> {
  String label = '红包';
  double amount = 0.00;
  Color color = Colors.red.shade400;

  WalletModel05 model05 = WalletModel05.init();
  List<WalletModel06> dataList = [];
  @override
  void initState() {
    super.initState();
    // 发送者
    getSender(widget.tradeId);
    // 接收者
    getReceiver(widget.tradeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('$label详情'),
      ),
      body: Column(
        children: [
          _buildSender(),
          _buildLabel(),
          WidgetCommon.divider(),
          Expanded(
            child: _buildReceiver(),
          ),
        ],
      ),
    );
  }

  _buildSender() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.showAvatar(
            model05.portrait,
            size: 65,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            model05.nickname,
          ),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            model05.remark,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '¥ ${model05.amount} 元',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  _buildLabel() {
    switch (model05.tradeType) {
      case TradeType.transfer:
      case TradeType.groupTansfer:
        return Container();
      default:
        break;
    }
    String count = dataList.length.toString();
    return Column(
      children: [
        WidgetCommon.tips(
          '红包已领取 $count/${model05.total} 个，共 ${amount.toStringAsFixed(2)}/${model05.amount} 元',
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _buildReceiver() {
    if (dataList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      itemCount: dataList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      itemBuilder: (ctx, index) {
        if (dataList.length == index) {
          return Container();
        }
        WalletModel06 model = dataList[index];
        return ListTile(
          leading: WidgetCommon.showAvatar(
            model.portrait,
          ),
          title: Text(
            model.nickname,
          ),
          subtitle: WidgetCommon.tips(
            'ID：${model.userNo}\n${model.createTime}',
            textAlign: TextAlign.left,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¥ ${model.amount}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              if (model.best == 'Y')
                const Text(
                  '手气最佳',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                  ),
                ),
              if (model.best == 'N')
                const Text(
                  '手气最差',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // 发送者
  Future<void> getSender(String tradeId) async {
    // 请求
    model05 = await RequestWallet.getSender(tradeId);
    switch (model05.tradeType) {
      case TradeType.transfer:
      case TradeType.groupTansfer:
        label = '转账';
        color = Colors.orange.shade400;
        break;
      default:
        break;
    }
    setState(() {});
  }

  // 接收者
  Future<void> getReceiver(String tradeId) async {
    // 请求
    dataList = await RequestWallet.getReceiver(tradeId);
    // 计算
    for (var data in dataList) {
      amount += double.parse(data.amount);
    }
    setState(() {});
  }
}
