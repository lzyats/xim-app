import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/login/login_banned_page.dart';
import 'package:alpaca/pages/login/login_index_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';

// 中间组件
class MainMiddleWare extends GetMiddleware {
  @override
  int? get priority => -1;

  @override
  RouteSettings? redirect(String? route) {
    String token = ToolsStorage().token();
    // 判断登录状态
    if (token.isEmpty) {
      return const RouteSettings(name: LoginIndexPage.routeName);
    }
    MiddleStatus status = ToolsStorage().status();
    // 判断登录状态
    if (MiddleStatus.login == status) {
      return const RouteSettings(name: LoginIndexPage.routeName);
    }
    // 判断禁用状态
    if (MiddleStatus.banned == status) {
      return const RouteSettings(name: LoginBannedPage.routeName);
    }
    // 表示不拦截
    return null;
  }
}
