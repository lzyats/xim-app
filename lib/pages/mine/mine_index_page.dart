import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/common/common_about_page.dart';
import 'package:alpaca/pages/common/common_feedback_page.dart';
import 'package:alpaca/pages/common/common_help_page.dart';
import 'package:alpaca/pages/common/common_notices_page.dart';
import 'package:alpaca/pages/mine/mine_collect_page.dart';
import 'package:alpaca/pages/mine/mine_index_controller.dart';
import 'package:alpaca/pages/mine/mine_safety_page.dart';
import 'package:alpaca/pages/mine/mine_setting_page.dart';
import 'package:alpaca/pages/common/common_index_page.dart';
import 'package:alpaca/pages/wallet/wallet_index_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';

double _iconSize = 25;

// 我的页面
class MineIndexPage extends GetView<MineIndexController> {
  const MineIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineIndexController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          WidgetAction(
            icon: const Icon(
              AppFonts.e681,
            ),
            onTap: () async {
              ChatRobot chatRobot =
                  await ToolsSqlite().robot.getById(AppConfig.robotId);
              ToolsRoute().chatPage(
                chatId: chatRobot.robotId,
                nickname: chatRobot.nickname,
                portrait: chatRobot.portrait,
                chatTalk: ChatTalk.robot,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              Obx(
                () => _buildHeader(),
              ),
              WidgetCommon.divider(),
              WidgetLineRow(
                "我的钱包",
                leading: Icon(
                  AppFonts.e607,
                  color: Colors.red,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    WalletIndexPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "账号安全",
                leading: Icon(
                  AppFonts.e609,
                  color: const Color.fromARGB(255, 239, 139, 7),
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    MineSafetyPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "通知公告",
                leading: Icon(
                  AppFonts.e61a,
                  color: Colors.green,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    CommonNoticesPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "我的收藏",
                leading: Icon(
                  AppFonts.ec85,
                  color: Colors.orange,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    MineCollectPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "软件设置",
                leading: Icon(
                  AppFonts.e602,
                  color: const Color.fromARGB(255, 236, 42, 239),
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    CommonSoftwarePage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "帮助中心",
                leading: Icon(
                  AppFonts.e603,
                  color: Colors.blue,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    CommonHelpPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "建议反馈",
                leading: Icon(
                  AppFonts.e65c,
                  color: Colors.orange,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    CommonFeedbackPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "关于我们",
                leading: Icon(
                  AppFonts.e64d,
                  color: Colors.red,
                  size: _iconSize,
                ),
                onTap: () {
                  Get.toNamed(
                    CommonAboutPage.routeName,
                  );
                },
                divider: false,
              ),
              WidgetCommon.border(),
            ],
          ),
        ),
      ),
    );
  }

  // 头像
  _buildHeader() {
    LocalUser localUser = controller.localUser.value;
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
          left: 12,
          right: 6,
          top: 20,
          bottom: 20,
        ),
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: WidgetCommon.showAvatar(
                      localUser.portrait,
                      size: 55,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localUser.nickname,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                        Text('ID：${localUser.userNo}'),
                        Text(
                          '签名：${localUser.intro}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.qr_code),
            WidgetCommon.arrow(),
          ],
        ),
      ),
      onTap: () {
        Get.toNamed(MineSettingPage.routeName);
      },
    );
  }
}
