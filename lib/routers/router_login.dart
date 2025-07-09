import 'package:alpaca/pages/login/login_register_page.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/login/login_banned_page.dart';
import 'package:alpaca/pages/login/login_scan_page.dart';
import 'package:alpaca/routers/router_base.dart';
import 'package:alpaca/pages/login/login_forgot_page.dart';
import 'package:alpaca/pages/login/login_index_page.dart';

// 登录路由
List<GetPage> getLoginPages = [
  // 登录页面
  getPage(
    name: LoginIndexPage.routeName,
    page: () => const LoginIndexPage(),
    middle: false,
  ),
  // 忘记密码
  getPage(
    name: LoginForgotPage.routeName,
    page: () => const LoginForgotPage(),
    middle: false,
  ),
  // 注册账号
  getPage(
    name: LoginRegisterPage.routeName,
    page: () => const LoginRegisterPage(),
    middle: false,
  ),
  // 禁用页面
  getPage(
    name: LoginBannedPage.routeName,
    page: () => const LoginBannedPage(),
    middle: false,
  ),
  // 禁用页面
  getPage(
    name: LoginBannedApplyPage.routeName,
    page: () => const LoginBannedApplyPage(),
    middle: false,
  ),
  // 扫码登录
  getPage(
    name: LoginScanPage.routeName,
    page: () => const LoginScanPage(),
    middle: false,
  ),
];
