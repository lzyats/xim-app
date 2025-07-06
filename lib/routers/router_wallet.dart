import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_auth_page.dart';
import 'package:alpaca/pages/wallet/wallet_card_page.dart';
import 'package:alpaca/pages/wallet/wallet_cash_page.dart';
import 'package:alpaca/pages/wallet/wallet_goods_page.dart';
import 'package:alpaca/pages/wallet/wallet_index_page.dart';
import 'package:alpaca/pages/wallet/wallet_payment_page.dart';
import 'package:alpaca/pages/wallet/wallet_qrcode_page.dart';
import 'package:alpaca/pages/wallet/wallet_recharge_page.dart';
import 'package:alpaca/pages/wallet/wallet_transfer_page.dart';
import 'package:alpaca/pages/wallet/wallet_trade_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 钱包路由
List<GetPage> getWalletPages = [
  // 首页
  getPage(
    name: WalletIndexPage.routeName,
    page: () => const WalletIndexPage(),
  ),
  // 收款码
  getPage(
    name: WalletQrCodePage.routeName,
    page: () => const WalletQrCodePage(),
  ),
  // 支付密码
  getPage(
    name: WalletPaymentPage.routeName,
    page: () => const WalletPaymentPage(),
  ),
  // 充值
  getPage(
    name: WalletRechargePage.routeName,
    page: () => const WalletRechargePage(),
  ),
  // 钱包
  getPage(
    name: WalletCardPage.routeName,
    page: () => const WalletCardPage(),
  ),
  // 提现
  getPage(
    name: WalletCashPage.routeName,
    page: () => const WalletCashPage(),
  ),
  // 认证
  getPage(
    name: WalletAuthPage.routeName,
    page: () => const WalletAuthPage(),
  ),
  // 账单
  getPage(
    name: WalletTradePage.routeName,
    page: () => const WalletTradePage(),
  ),
  // 账单
  getPage(
    name: WalletTradeInfoPage.routeName,
    page: () => const WalletTradeInfoPage(),
  ),
  // 扫码
  getPage(
    name: WalletTransferPage.routeName,
    page: () => const WalletTransferPage(),
  ),
  // 商品
  getPage(
    name: WalletGoodsPage.routeName,
    page: () => const WalletGoodsPage(),
  ),
];
