import 'package:get/get.dart';
import 'package:alpaca/pages/main/main_middle.dart';

// 基础路由
GetPage getPage({
  required String name,
  required GetPageBuilder page,
  bool middle = true,
}) {
  return GetPage(
    name: name,
    // 中间页面
    middlewares: middle ? [MainMiddleWare()] : null,
    page: () {
      return page();
    },
  );
}
