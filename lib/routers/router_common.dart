import 'package:get/get.dart';
import 'package:alpaca/pages/common/common_about_page.dart';
import 'package:alpaca/pages/common/common_feedback_page.dart';
import 'package:alpaca/pages/common/common_help_page.dart';
import 'package:alpaca/pages/common/common_index_page.dart';
import 'package:alpaca/pages/common/common_notices_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 公共路由
List<GetPage> getCommonPages = [
  // 关于我们
  getPage(
    name: CommonAboutPage.routeName,
    page: () => const CommonAboutPage(),
  ),
  // 帮助中心
  getPage(
    name: CommonHelpPage.routeName,
    page: () => const CommonHelpPage(),
  ),
  // 建议反馈
  getPage(
    name: CommonFeedbackPage.routeName,
    page: () => const CommonFeedbackPage(),
  ),
  // 通知公告
  getPage(
    name: CommonNoticesPage.routeName,
    page: () => const CommonNoticesPage(),
  ),
  // 软件设置
  getPage(
    name: CommonSoftwarePage.routeName,
    page: () => const CommonSoftwarePage(),
  ),
];
