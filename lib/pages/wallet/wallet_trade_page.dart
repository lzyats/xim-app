import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_trade_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 钱包账单
class WalletTradePage extends GetView<WalletTradeController> {
  // 路由地址
  static const String routeName = '/wallet_trade';
  const WalletTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletTradeController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(controller.tradeType.title),
      ),
      body: GetBuilder<WalletTradeController>(builder: (builder) {
        return SlidableAutoCloseBehavior(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: controller.refreshController,
            onRefresh: () {
              controller.onRefresh();
            },
            onLoading: () {
              controller.onLoading();
            },
            child: _buildBody(),
          ),
        );
      }),
    );
  }

  _buildBody() {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      itemCount: controller.refreshList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider(indent: 10);
      },
      padding: const EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (ctx, index) {
        if (controller.refreshList.length == index) {
          return Container();
        }
        WalletModel03 model = controller.refreshList[index];
        String label = model.tradeType.label;
        if (controller.tradeType == TradeType.cash) {
          label += ' (${model.tradeLabel})';
        }
        return Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const BehindMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  if (ToolsSubmit.call()) {
                    // 提交
                    controller.removeTrade(model.tradeId);
                  }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                label: '删除',
              ),
            ],
          ),
          child: WidgetLineRow(
            label,
            divider: false,
            subtitle: model.createTime,
            value: model.tradeAmount,
            onTap: () {
              Get.toNamed(
                WalletTradeInfoPage.routeName,
                arguments: model.tradeId,
              );
            },
          ),
        );
      },
    );
  }
}

// 账单详情
class WalletTradeInfoPage extends GetView<WalletTradeInfoController> {
  // 路由地址
  static const String routeName = '/wallet_trade_info';
  const WalletTradeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletTradeInfoController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('账单详情'),
      ),
      body: GetBuilder<WalletTradeInfoController>(
        builder: (builder) {
          WalletModel04? model04 = controller.refreshData;
          if (model04 == null) {
            return WidgetCommon.none();
          }
          return SingleChildScrollView(
            child: _buildBody(model04),
          );
        },
      ),
    );
  }

  _buildSteps(String tradeStatus) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: TDSteps(
              steps: [
                TDStepsItemData(title: '发起申请', content: ''),
                TDStepsItemData(title: '系统审核', content: ''),
                TDStepsItemData(
                  title: tradeStatus == '3' ? '审核失败' : '审核成功',
                  content: '',
                ),
              ],
              activeIndex: int.parse(tradeStatus),
              simple: true,
            ),
          )
        ],
      ),
    );
  }

  _buildBody(WalletModel04 model04) {
    // 账单
    TradeType tradeType = model04.tradeType;
    // 充值
    switch (tradeType) {
      // 充值
      case TradeType.recharge:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '支付方式',
              model04.payType,
            ),
            WidgetLineTable(
              '支付金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '商户单号',
              model04.tradeNo,
            ),
            WidgetLineTable(
              '交易单号',
              model04.orderNo,
            ),
            WidgetLineTable(
              '发起时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '到账时间',
              model04.updateTime,
            ),
          ],
        );
      // 提现
      case TradeType.cash:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '提现姓名',
              model04.name,
            ),
            WidgetLineTable(
              '提现账户',
              model04.wallet,
            ),
            WidgetLineTable(
              '提现金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '发起时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '提现状态',
              model04.tradeLabel,
            ),
            WidgetLineTable(
              '提现备注',
              model04.remark,
            ),
            WidgetLineTable(
              '处理时间',
              model04.updateTime,
            ),
            _buildSteps(model04.tradeStatus),
          ],
        );
      // 个人转账
      case TradeType.transfer:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '接收账号',
              '${model04.receiveName}(${model04.receiveNo})',
            ),
            WidgetLineTable(
              '转账备注',
              model04.remark,
            ),
          ],
        );
      // 个人红包
      case TradeType.packet:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '接收账号',
              '${model04.receiveName}(${model04.receiveNo})',
            ),
            WidgetLineTable(
              '红包祝语',
              model04.remark,
            ),
          ],
        );
      // 专属红包
      case TradeType.packetAssign:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '群聊账号',
              '${model04.groupName}(${model04.groupNo})',
            ),
            WidgetLineTable(
              '接收账号',
              '${model04.receiveName}(${model04.receiveNo})',
            ),
          ],
        );
      // 群聊红包
      case TradeType.packetLuck:
      case TradeType.packetNormal:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '群聊账号',
              '${model04.groupName}(${model04.groupNo})',
            ),
          ],
        );
      // 扫码转账
      case TradeType.scan:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '接收账号',
              '${model04.receiveName}(${model04.receiveNo})',
            ),
          ],
        );
      // 退款记录
      case TradeType.refund:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '退款金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '退款时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '退款来源',
              model04.source,
            ),
          ],
        );
      // 消费记录
      case TradeType.shopping:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '消费金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '消费时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '消费说明',
              model04.remark,
            ),
          ],
        );
      // 专属红包
      case TradeType.groupTansfer:
        return Column(
          children: [
            WidgetLineTable(
              '账单类型',
              tradeType.title,
            ),
            WidgetLineTable(
              '交易金额',
              model04.tradeAmount,
            ),
            WidgetLineTable(
              '交易时间',
              model04.createTime,
            ),
            WidgetLineTable(
              '发起账号',
              '${model04.nickname}(${model04.userNo})',
            ),
            WidgetLineTable(
              '群聊账号',
              '${model04.groupName}(${model04.groupNo})',
            ),
            WidgetLineTable(
              '接收账号',
              '${model04.receiveName}(${model04.receiveNo})',
            ),
          ],
        );
      // 其他
      default:
        return WidgetLineTable(
          '账单类型',
          tradeType.title,
        );
    }
  }
}
