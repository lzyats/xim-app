import 'package:alpaca/request/request_auth.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_submit.dart';
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
    print("token:"+token+route.toString());
    // 判断登录状态
    if (token.isEmpty) {
      //判断是否游客状态
      if(route=='/msg_chat'){
        //执行游客登录
        vlogin();
        return null;
      }
      return const RouteSettings(name: LoginIndexPage.routeName);
    }
    
    MiddleStatus status = ToolsStorage().status();
    print(status);
    if(route=='/msg_chat'){
        //执行游客登录
        return null;
      }
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
  // 游客登录
  Future<void> vlogin() async {
    String vtoekn = ToolsStorage().visitorLogin();
    print(vtoekn);
    // 执行
    AuthModel02 model = await RequestAuth.loginTourist(vtoekn);
    print(model.banned.toString());
    print(model.token.toString());
    // 更新token
    ToolsStorage().token(token: model.token);
    await RequestMine.getInfo();
    // 取消
    ToolsSubmit.cancel();
    // 登录成功
  }
}
