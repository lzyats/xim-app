// 钱包接口
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';

class RequestWallet {
  static String get _prefix => '/wallet';

  // 获取详情
  static Future<String> getWalletInfo() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getInfo',
    );
    // 转换
    return ajaxData.getData((data) => data);
  }

  // 设置密码
  static Future<void> setPass(
    String code,
    String password,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setPass',
      data: {
        'code': code,
        'password': password,
      },
    );
    // 提醒
    EasyLoading.showToast('重置成功');
  }

  // 获取充值配置
  static Future<WalletModel08> getRechargeConfig() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/recharge/getConfig',
    );
    // 转行
    return ajaxData.getData((data) => WalletModel08.fromJson(data));
  }

  // 获取充值金额
  static Future<List<String>> getRechargeAmount() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/recharge/getPayAmount',
    );
    // 转行
    return ajaxData.getList((data) => data);
  }

  // 获取支付类型
  static Future<List<PayType>> getRechargeType() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/recharge/getPayType',
    );
    // 转行
    return ajaxData.getList((data) => PayType.init(data));
  }

  // 充值提交
  static Future<String> submitRecharge(PayType payType, String amount) async {
    // 执行
    AjaxData ajaxData =
        await ToolsRequest().post('$_prefix/recharge/submit', data: {
      "payType": payType.value,
      "amount": amount,
    });
    // 转行
    return ajaxData.getData((data) => data);
  }

  // 钱包列表
  static Future<List<WalletModel01>> getBankList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get('$_prefix/bank/getList');
    // 转行
    return ajaxData.getList((data) => WalletModel01.fromJson(data));
  }

  // 新增钱包
  static Future<void> addBank(String name, String wallet) async {
    // 执行
    await ToolsRequest().post('$_prefix/bank/add', data: {
      "name": name,
      "wallet": wallet,
    });
    // 弹框提示
    EasyLoading.showToast('新增成功');
  }

  // 删除钱包
  static Future<void> deleteBank(String walletId) async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/bank/delete/$walletId',
    );
    // 弹框提示
    EasyLoading.showToast('删除成功');
  }

  // 获取提现配置
  static Future<WalletModel02> getCashConfig() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/cash/getConfig',
    );
    // 转行
    return ajaxData.getData((data) => WalletModel02.fromJson(data));
  }

  // 申请提现
  static Future<void> applyCash(
    double amount,
    String name,
    String wallet,
    String password,
  ) async {
    // 执行
    await ToolsRequest().post('$_prefix/cash/apply', data: {
      "amount": amount,
      "name": name,
      "wallet": wallet,
      "password": password
    });
    // 提醒
    EasyLoading.showToast('已发起提现申请，等待平台审核');
    // 返回
    Get.back();
  }

  // 账单列表
  static Future<List<WalletModel03>> getTradeList(
    TradeType tradeType,
    int pageNum,
  ) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest()
        .page('$_prefix/trade/getTradeList', pageNum, pageSize: 20, data: {
      "tradeType": tradeType.value,
    });
    // 转换
    return ajaxData.getList((data) => WalletModel03.fromJson(data));
  }

  // 账单详情
  static Future<WalletModel04> getTradeInfo(String tradeId) async {
    // 执行
    AjaxData ajaxData =
        await ToolsRequest().get('$_prefix/trade/getTradeInfo/$tradeId');
    // 转换
    return ajaxData.getData((data) => WalletModel04.fromJson(data));
  }

  // 账单删除
  static Future<void> removeTrade(String tradeId) async {
    // 执行
    await ToolsRequest().get('$_prefix/trade/removeTrade/$tradeId');
  }

  // 扫码转账
  static Future<String> transfer(
    String receiveId,
    String password,
    double data,
    String remark,
  ) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/trade/transfer',
      data: {
        "receiveId": receiveId,
        "password": password,
        "data": data,
        "remark": remark
      },
    );
    // 转换
    return ajaxData.getData((data) => data['tradeId']);
  }

  // 接收交易
  static Future<String> doReceive(String tradeId) async {
    // 执行
    AjaxData ajaxData =
        await ToolsRequest().get('$_prefix/trade/doReceive/$tradeId');
    // 转换
    return ajaxData.getData((data) => data);
    //
  }

  // 发送详情
  static Future<WalletModel05> getSender(String tradeId) async {
    // 执行
    AjaxData ajaxData =
        await ToolsRequest().get('$_prefix/trade/getSender/$tradeId');
    // 转换
    return ajaxData.getData((data) => WalletModel05.fromJson(data));
  }

  // 接收详情
  static Future<List<WalletModel06>> getReceiver(String tradeId) async {
    // 执行
    AjaxData ajaxData =
        await ToolsRequest().get('$_prefix/trade/getReceiver/$tradeId');
    // 转换
    return ajaxData.getList((data) => WalletModel06.fromJson(data));
  }

  // 群组红包
  static Future<List<WalletModel07>> getGroupPacket(
    String groupId,
    int pageNum,
  ) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().page(
      '$_prefix/trade/getGroupPacket/$groupId',
      pageNum,
      pageSize: 20,
    );
    // 转换
    return ajaxData.getList((data) => WalletModel07.fromJson(data));
  }

  // 商品支付
  static Future<void> payment(
    String appId,
    String orderNo,
    String goodsName,
    String goodsPrice,
    String password,
  ) async {
    // 执行
    await ToolsRequest().post('$_prefix/trade/payment', data: {
      "appId": appId,
      "orderNo": orderNo,
      "goodsName": goodsName,
      "goodsPrice": goodsPrice,
      "password": password
    });
    // 返回
    Get.back();
  }
}

class WalletModel01 {
  String bankId;
  String name;
  String wallet;

  WalletModel01(
    this.bankId,
    this.name,
    this.wallet,
  );

  factory WalletModel01.fromJson(Map<String, dynamic>? data) {
    return WalletModel01(
      data?['bankId'] ?? '',
      data?['name'] ?? '',
      data?['wallet'] ?? '',
    );
  }

  factory WalletModel01.init() {
    return WalletModel01.fromJson({});
  }
}

class WalletModel02 {
  double cost;
  double rate;
  double max;
  double min;
  int count;
  String remark;
  String auth;

  WalletModel02(
    this.cost,
    this.rate,
    this.max,
    this.min,
    this.count,
    this.remark,
    this.auth,
  );

  factory WalletModel02.fromJson(Map<String, dynamic>? data) {
    return WalletModel02(
      double.parse(data?['cost'] ?? '0.00'),
      double.parse(data?['rate'] ?? '0.00'),
      double.parse(data?['max'] ?? '0.00'),
      double.parse(data?['min'] ?? '0.00'),
      data?['count'] ?? 0,
      data?['remark'] ?? '',
      data?['auth'] ?? '',
    );
  }

  factory WalletModel02.init() {
    return WalletModel02.fromJson({});
  }
}

class WalletModel03 {
  String tradeId;
  TradeType tradeType;
  String tradeStatus;
  String tradeLabel;
  String tradeAmount;
  String createTime;

  WalletModel03(
    this.tradeId,
    this.tradeType,
    this.tradeStatus,
    this.tradeLabel,
    this.tradeAmount,
    this.createTime,
  );

  factory WalletModel03.fromJson(Map<String, dynamic>? data) {
    return WalletModel03(
      data?['tradeId'] ?? '',
      TradeType.init(data?['tradeType']),
      data?['tradeStatus'] ?? '',
      data?['tradeLabel'] ?? '',
      data?['tradeAmount'] ?? '',
      data?['createTime'] ?? '',
    );
  }

  factory WalletModel03.init() {
    return WalletModel03.fromJson({});
  }
}

class WalletModel04 {
  String tradeId;
  TradeType tradeType;
  String tradeStatus;
  String tradeAmount;
  String createTime;
  String updateTime;
  // 充值
  String payType;
  String tradeNo;
  String orderNo;
  // 提现
  String name;
  String wallet;
  String remark;
  // 转账/红包/扫码
  String nickname;
  String userNo;
  String receiveName;
  String receiveNo;
  String tradeLabel;
  // 普通/手气/专属
  String groupName;
  String groupNo;
  int count;
  // 退款
  String source;

  WalletModel04(
    this.tradeId,
    this.tradeType,
    this.tradeStatus,
    this.tradeAmount,
    this.createTime,
    this.updateTime,
    this.payType,
    this.tradeNo,
    this.orderNo,
    this.name,
    this.wallet,
    this.remark,
    this.nickname,
    this.userNo,
    this.receiveName,
    this.receiveNo,
    this.tradeLabel,
    this.groupName,
    this.groupNo,
    this.count,
    this.source,
  );

  factory WalletModel04.fromJson(Map<String, dynamic>? data) {
    return WalletModel04(
      data?['tradeId'] ?? '',
      TradeType.init(data?['tradeType'] ?? ''),
      data?['tradeStatus'] ?? '',
      data?['tradeAmount'] ?? '',
      data?['createTime'] ?? '',
      data?['updateTime'] ?? '-',
      data?['payType'] ?? '',
      data?['tradeNo'] ?? '',
      data?['orderNo'] ?? '',
      data?['name'] ?? '',
      data?['wallet'] ?? '',
      data?['remark'] ?? '',
      data?['nickname'] ?? '',
      data?['userNo'] ?? '',
      data?['receiveName'] ?? '',
      data?['receiveNo'] ?? '',
      data?['tradeLabel'] ?? '',
      data?['groupName'] ?? '',
      data?['groupNo'] ?? '',
      data?['count'] ?? 0,
      data?['source'] ?? '',
    );
  }
}

class WalletModel05 {
  String tradeId;
  TradeType tradeType;
  String amount;
  String remark;
  String total;
  String nickname;
  String portrait;
  String createTime;
  String updateTime;

  WalletModel05(
    this.tradeId,
    this.tradeType,
    this.amount,
    this.remark,
    this.total,
    this.nickname,
    this.portrait,
    this.createTime,
    this.updateTime,
  );

  factory WalletModel05.fromJson(Map<String, dynamic>? data) {
    return WalletModel05(
      data?['tradeId'] ?? '',
      TradeType.init(data?['tradeType'] ?? ''),
      data?['amount'] ?? '',
      data?['remark'] ?? '',
      data?['total'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['createTime'] ?? '',
      data?['updateTime'] ?? '',
    );
  }

  factory WalletModel05.init() {
    return WalletModel05.fromJson({});
  }
}

class WalletModel06 {
  String amount;
  String createTime;
  String userNo;
  String nickname;
  String portrait;
  String best;

  WalletModel06(
    this.amount,
    this.createTime,
    this.userNo,
    this.nickname,
    this.portrait,
    this.best,
  );

  factory WalletModel06.fromJson(Map<String, dynamic>? data) {
    return WalletModel06(
      data?['amount'] ?? '',
      data?['createTime'] ?? '',
      data?['userNo'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['best'] ?? '',
    );
  }
}

class WalletModel07 {
  String tradeId;
  TradeType tradeType;
  String tradeAmount;
  String createTime;

  WalletModel07(
    this.tradeId,
    this.tradeType,
    this.tradeAmount,
    this.createTime,
  );

  factory WalletModel07.fromJson(Map<String, dynamic>? data) {
    return WalletModel07(
      data?['tradeId'] ?? '',
      TradeType.init(data?['tradeType']),
      data?['tradeAmount'] ?? '',
      data?['createTime'] ?? '',
    );
  }
}

class WalletModel08 {
  int count;
  String remark;

  WalletModel08(
    this.count,
    this.remark,
  );

  factory WalletModel08.fromJson(Map<String, dynamic>? data) {
    return WalletModel08(
      data?['count'] ?? 0,
      data?['remark'] ?? '',
    );
  }

  factory WalletModel08.init() {
    return WalletModel08(
      0,
      '',
    );
  }
}
