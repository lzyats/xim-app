import 'package:alpaca/pages/mine/mine_email_page.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_birthday_page.dart';
import 'package:alpaca/pages/mine/mine_city_page.dart';
import 'package:alpaca/pages/mine/mine_collect_page.dart';
import 'package:alpaca/pages/mine/mine_error.dart';
import 'package:alpaca/pages/mine/mine_gender_page.dart';
import 'package:alpaca/pages/mine/mine_intro_page.dart';
import 'package:alpaca/pages/mine/mine_inventory_page.dart';
import 'package:alpaca/pages/mine/mine_nickname_page.dart';
import 'package:alpaca/pages/mine/mine_password_page.dart';
import 'package:alpaca/pages/mine/mine_privacy_page.dart';
import 'package:alpaca/pages/mine/mine_qrcode_page.dart';
import 'package:alpaca/pages/mine/mine_safety_page.dart';
import 'package:alpaca/pages/mine/mine_setting_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 我的路由
List<GetPage> getMinePages = [
  // 个人设置
  getPage(
    name: MineSettingPage.routeName,
    page: () => const MineSettingPage(),
  ),
  // 设置昵称
  getPage(
    name: MineNicknamePage.routeName,
    page: () => const MineNicknamePage(),
  ),
  // 设置密码
  getPage(
    name: MinePasswordPage.routeName,
    page: () => const MinePasswordPage(),
  ),
  // 设置性别
  getPage(
    name: MineGenderPage.routeName,
    page: () => const MineGenderPage(),
  ),
  // 设置签名
  getPage(
    name: MineIntroPage.routeName,
    page: () => const MineIntroPage(),
  ),
  // 设置地区
  getPage(
    name: MineCityPage.routeName,
    page: () => const MineCityPage(),
  ),
  // 设置生日
  getPage(
    name: MineBirthdayPage.routeName,
    page: () => const MineBirthdayPage(),
  ),
  // 我的二维码
  getPage(
    name: MineQrCodePage.routeName,
    page: () => const MineQrCodePage(),
  ),
  // 账号安全
  getPage(
    name: MineSafetyPage.routeName,
    page: () => const MineSafetyPage(),
  ),
  // 信息收集清单
  getPage(
    name: MineInventoryPage.routeName,
    page: () => const MineInventoryPage(),
  ),
  // 用户注销
  getPage(
    name: MineDeletedPage.routeName,
    page: () => const MineDeletedPage(),
  ),
  // 账号隐私
  getPage(
    name: MinePrivacyPage.routeName,
    page: () => const MinePrivacyPage(),
  ),
  // 我的收藏
  getPage(
    name: MineCollectPage.routeName,
    page: () => const MineCollectPage(),
  ),
  // 我的邮箱
  getPage(
    name: MineEmailPage.routeName,
    page: () => const MineEmailPage(),
  ),
  // 错误页面
  getPage(
    name: MineError.routeName,
    page: () => const MineError(),
  ),
];
