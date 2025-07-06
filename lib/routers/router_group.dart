import 'package:get/get.dart';
import 'package:alpaca/pages/group/group_approve_page.dart';
import 'package:alpaca/pages/group/group_at_page.dart';
import 'package:alpaca/pages/group/group_create_page.dart';
import 'package:alpaca/pages/group/group_details_page.dart';
import 'package:alpaca/pages/group/group_index_page.dart';
import 'package:alpaca/pages/group/group_inform_page.dart';
import 'package:alpaca/pages/group/group_invite_page.dart';
import 'package:alpaca/pages/group/group_kicked_page.dart';
import 'package:alpaca/pages/group/group_level_page.dart';
import 'package:alpaca/pages/group/group_manager_page.dart';
import 'package:alpaca/pages/group/group_member_page.dart';
import 'package:alpaca/pages/group/group_name_page.dart';
import 'package:alpaca/pages/group/group_nickname_page.dart';
import 'package:alpaca/pages/group/group_notice_page.dart';
import 'package:alpaca/pages/group/group_packet_white_page.dart';
import 'package:alpaca/pages/group/group_qrcode_page.dart';
import 'package:alpaca/pages/group/group_remark_page.dart';
import 'package:alpaca/pages/group/group_manage_page.dart';
import 'package:alpaca/pages/group/group_scan_page.dart';
import 'package:alpaca/pages/group/group_search_page.dart';
import 'package:alpaca/pages/group/group_speak_page.dart';
import 'package:alpaca/pages/group/group_transfer_page.dart';
import 'package:alpaca/pages/group/group_trade_page.dart';
import 'package:alpaca/routers/router_base.dart';

// 群聊路由
List<GetPage> getGroupPages = [
  // 群聊首页
  getPage(
    name: GroupIndexPage.routeName,
    page: () => const GroupIndexPage(),
  ),
  // 群聊详情
  getPage(
    name: GroupDetailsPage.routeName,
    page: () => const GroupDetailsPage(),
  ),
  // 群聊管理
  getPage(
    name: GroupManagePage.routeName,
    page: () => const GroupManagePage(),
  ),
  // 群二维码
  getPage(
    name: GroupQrCodePage.routeName,
    page: () => const GroupQrCodePage(),
  ),
  // 群聊举报
  getPage(
    name: GroupInformPage.routeName,
    page: () => const GroupInformPage(),
  ),
  // 设置群名
  getPage(
    name: GroupNamePage.routeName,
    page: () => const GroupNamePage(),
  ),
  // 设置公告
  getPage(
    name: GroupNoticePage.routeName,
    page: () => const GroupNoticePage(),
  ),
  // 设置备注
  getPage(
    name: GroupRemarkPage.routeName,
    page: () => const GroupRemarkPage(),
  ),
  // 邀请好友
  getPage(
    name: GroupInvitePage.routeName,
    page: () => const GroupInvitePage(),
  ),
  // 群聊成员
  getPage(
    name: GroupMemberPage.routeName,
    page: () => const GroupMemberPage(),
  ),
  // 搜索群聊
  getPage(
    name: GroupSearchPage.routeName,
    page: () => const GroupSearchPage(),
  ),
  // 扫码群聊
  getPage(
    name: GroupScanPage.routeName,
    page: () => const GroupScanPage(),
  ),
  // 群聊建群
  getPage(
    name: GroupCreatePage.routeName,
    page: () => const GroupCreatePage(),
  ),
  // 设置管理员
  getPage(
    name: GroupManagerPage.routeName,
    page: () => const GroupManagerPage(),
  ),
  // 转让群聊
  getPage(
    name: GroupTransferPage.routeName,
    page: () => const GroupTransferPage(),
  ),
  // 移出群聊
  getPage(
    name: GroupKickedPage.routeName,
    page: () => const GroupKickedPage(),
  ),
  // 成员昵称
  getPage(
    name: GroupNicknamePage.routeName,
    page: () => const GroupNicknamePage(),
  ),
  // 红包白名单
  getPage(
    name: GroupPacketWhitePage.routeName,
    page: () => const GroupPacketWhitePage(),
  ),
  // 群聊禁言
  getPage(
    name: GroupSpeakPage.routeName,
    page: () => const GroupSpeakPage(),
  ),
  // 群聊扩容
  getPage(
    name: GroupLevelPage.routeName,
    page: () => const GroupLevelPage(),
  ),
  // 群聊@人
  getPage(
    name: GroupAtPage.routeName,
    page: () => const GroupAtPage(),
  ),
  // 群聊红包
  getPage(
    name: GroupTradePage.routeName,
    page: () => const GroupTradePage(),
  ),
  // 群聊审批
  getPage(
    name: GroupApprovePage.routeName,
    page: () => const GroupApprovePage(),
  ),
];
