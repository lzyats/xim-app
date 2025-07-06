import 'package:get/get.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 主路由
List<GetPage> getMainPages = [
  // 主页
  getPage(
    name: MainPage.routeName,
    page: () => const MainPage(),
  ),
  // 视图
  getPage(
    name: ViewPage.routeName,
    page: () => const ViewPage(),
    middle: false,
  ),
];
