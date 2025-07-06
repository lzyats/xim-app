import 'package:get/get.dart';
import 'package:alpaca/pages/robot/robot_index_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 服务路由
List<GetPage> getRobotPages = [
  // 群聊首页
  getPage(
    name: RobotIndexPage.routeName,
    page: () => const RobotIndexPage(),
  ),
];
