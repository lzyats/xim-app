import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_apply_page.dart';
import 'package:alpaca/pages/friend/friend_approve_page.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/friend/friend_inform_page.dart';
import 'package:alpaca/pages/friend/friend_remark_page.dart';
import 'package:alpaca/pages/friend/friend_setting_page.dart';
import 'package:alpaca/pages/friend/friend_search_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 好友路由
List<GetPage> getFriendPages = [
  // 好友搜索
  getPage(
    name: FriendSearchPage.routeName,
    page: () => const FriendSearchPage(),
  ),
  // 好友详情
  getPage(
    name: FriendDetailsPage.routeName,
    page: () => const FriendDetailsPage(),
  ),
  // 好友申请
  getPage(
    name: FriendApplyPage.routeName,
    page: () => const FriendApplyPage(),
  ),
  // 好友举报
  getPage(
    name: FriendInformPage.routeName,
    page: () => const FriendInformPage(),
  ),
  // 好友设置
  getPage(
    name: FriendSettingPage.routeName,
    page: () => const FriendSettingPage(),
  ),
  // 好友备注
  getPage(
    name: FriendRemarkPage.routeName,
    page: () => const FriendRemarkPage(),
  ),
  // 好友审批
  getPage(
    name: FriendApprovePage.routeName,
    page: () => const FriendApprovePage(),
  ),
];
