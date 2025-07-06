import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/routers/router_page.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

// 主页面
Future<void> main() async {
  // 初始化
  await AppConfig.init();
  // 运行程序
  runApp(
    // 下拉刷新
    AppConfig.refreshConfig(
      child: _MainApp(),
    ),
  );
}

// 入口函数
class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 设置当前语言环境为中文
      locale: const Locale('zh', 'CH'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
      ],
      // 全局key
      navigatorKey: AppConfig.navigatorKey,
      // debug
      debugShowCheckedModeBanner: AppConfig.debug,
      // 主题
      theme: AppConfig.theme,
      // ios 风格
      defaultTransition: Transition.rightToLeft,
      // 初始化路由
      initialRoute: MainPage.routeName,
      // 路由页面
      getPages: getRouterPage,
      // loading
      builder: EasyLoading.init(),
      // 导航历史
      navigatorObservers: [NavigationHistoryObserver()],
    );
  }
}
