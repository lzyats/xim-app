import 'dart:convert';

import 'package:alipay_kit/alipay_kit_platform_interface.dart' as alipay;
import 'package:fluwx/fluwx.dart' as wechat;
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';

class WalletRechargeController extends BaseController {
  // 充值次数
  int rechargeCount = 0;
  // 充值金额
  List<String> rechargeAmount = [];
  // 充值方式
  List<PayType> rechargeType = [];
  // 金额
  String amount = '';
  // 类型
  PayType payType = PayType.none;
  // 充值配置
  void _getConfig() async {
    rechargeCount = await RequestWallet.getRechargeConfig();
    update();
  }

  // 充值金额
  void _getAmount() async {
    rechargeAmount = await RequestWallet.getRechargeAmount();
    if (rechargeAmount.isNotEmpty) {
      amount = rechargeAmount.first;
    }
    update();
  }

  // 支付类型
  void _getPayType() async {
    // 获取类型
    rechargeType = await RequestWallet.getRechargeType();
    // 移除微信
    try {
      wechat.Fluwx fluwx = wechat.Fluwx();
      if (!await fluwx.isWeChatInstalled) {
        rechargeType.remove(PayType.wechat);
      }
    } catch (e) {}
    // 默认第一条
    if (rechargeType.isNotEmpty) {
      payType = rechargeType.first;
    }
    update();
  }

  // 改变金额
  void changeAmount(String changeAmount) {
    amount = changeAmount;
    update();
  }

  // 改变类型
  void changeType(PayType changeType) {
    payType = changeType;
    update();
  }

  // 支付
  submit() async {
    // 提交
    String encrypt = await RequestWallet.submitRecharge(payType, amount);
    // 取消
    ToolsSubmit.cancel();
    // 密钥
    String secret = AppConfig.secret;
    // 解密
    String decrypt = ToolsEncrypt.decrypt(secret, encrypt);
    // 切换
    switch (payType) {
      case PayType.alipay:
        await alipay.AlipayKitPlatform.instance.pay(
          orderInfo: decrypt,
        );
        break;
      case PayType.wechat:
        Map<String, dynamic> result = jsonDecode(decrypt);
        // 转换
        wechat.Fluwx fluwx = wechat.Fluwx();
        await fluwx.registerApi(
          appId: result['appid'],
          universalLink: result['universalLink'],
        );
        await fluwx.pay(
          which: wechat.Payment(
            appId: result['appid'].toString(),
            partnerId: result['partnerid'].toString(),
            prepayId: result['prepayid'].toString(),
            packageValue: result['package'].toString(),
            nonceStr: result['noncestr'].toString(),
            timestamp: int.parse(result['timestamp']),
            sign: result['sign'].toString(),
          ),
        );
        break;
      default:
        break;
    }
    // 返回
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    _getConfig();
    _getAmount();
    _getPayType();
  }
}
