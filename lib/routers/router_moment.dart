// lib/routers/router_moment.dart
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_index_page.dart'; // 请根据实际情况修改路径
import 'package:alpaca/routers/router_base.dart';

// 朋友圈路由
List<GetPage> getMomentPages = [
  // 朋友圈列表页面
  getPage(
    name: MomentIndexPage.routeName,
    page: () => const MomentIndexPage(),
  ),
];
