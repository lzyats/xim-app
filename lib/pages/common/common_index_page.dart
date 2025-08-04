import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/common/common_about_page.dart';
import 'package:alpaca/pages/common/common_feedback_page.dart';
import 'package:alpaca/pages/common/common_help_page.dart';
import 'package:alpaca/pages/mine/mine_inventory_page.dart';
import 'package:alpaca/pages/mine/mine_safety_page.dart';
import 'package:alpaca/pages/mine/mine_setting_page.dart';
import 'package:alpaca/pages/common/common_index_controller.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:share_plus/share_plus.dart';

// 软件设置
class CommonSoftwarePage extends GetView<CommonSoftwareController> {
  // 路由地址
  static const String routeName = '/common_software';
  const CommonSoftwarePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonSoftwareController());
    String str = "http://110.42.56.25:8080|wss://110.42.56.25:8888";
    String secret = AppConfig.secret;
    secret = ToolsEncrypt.encrypt(secret, str);
    print("加密：" + secret);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '软件设置',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              WidgetLineRow(
                "个人设置",
                onTap: () {
                  Get.toNamed(
                    MineSettingPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "账号安全",
                onTap: () {
                  Get.toNamed(
                    MineSafetyPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "关于我们",
                onTap: () {
                  Get.toNamed(
                    CommonAboutPage.routeName,
                  );
                },
              ),
              WidgetLineRow(
                "服务器设置",
                onTap: () async {
                  bool result = await ToolsPerms.camera();
                  if (!result) {
                    return;
                  }
                  ToolsScan.scan();
                },
              ),
              WidgetLineRow(
                "软件版本",
                value: '当前版本 V${AppConfig.version}',
                arrow: false,
                onLongPress: () {
                  if (ToolsSubmit.call()) {
                    RequestCommon.upgrade(force: true);
                  }
                },
              ),

              /* WidgetLineRow(
                "分享应用",
                onTap: () {
                  String content = '快来和我一起聊天吧${controller.sharePath}';
                  Share.share(content);
                },
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: controller.sharePath));
                  EasyLoading.showToast('文本已复制');
                },
              ), */
              /* WidgetLineRow(
                "帮助中心",
                onTap: () {
                  Get.toNamed(
                    CommonHelpPage.routeName,
                  );
                },
              ), */
              /* WidgetLineRow(
                "建议反馈",
                onTap: () {
                  Get.toNamed(
                    CommonFeedbackPage.routeName,
                  );
                },
                divider: false,
              ), */
              WidgetCommon.border(),
              WidgetLineRow(
                "消息声音",
                subtitle: '开启后接收消息会有声音提醒',
                widget: Obx(
                  () => Switch(
                    value: 'Y' == controller.audio.value,
                    onChanged: (bool value) {
                      controller.editAudio(value);
                    },
                  ),
                ),
                arrow: false,
              ),
              WidgetLineRow(
                "消息通知",
                subtitle: '开启后接收消息会有通知提醒',
                widget: Obx(
                  () => Switch(
                    value: 'Y' == controller.notice.value,
                    onChanged: (bool value) {
                      controller.editNotice(value);
                    },
                  ),
                ),
                arrow: false,
                divider: false,
              ),
              WidgetCommon.border(),
              WidgetLineRow(
                "服务协议",
                onTap: () {
                  Get.toNamed(
                    ViewPage.routeName,
                    arguments: ViewData(
                      title: '服务协议',
                      AppConfig.serviceHost,
                      warn: false,
                    ),
                  );
                },
              ),
              WidgetLineRow(
                "隐私协议",
                onTap: () {
                  Get.toNamed(
                    ViewPage.routeName,
                    arguments: ViewData(
                      title: '隐私协议',
                      AppConfig.privacyHost,
                      warn: false,
                    ),
                  );
                },
              ),
              /* WidgetLineRow(
                "信息收集",
                onTap: () {
                  Get.toNamed(
                    MineInventoryPage.routeName,
                  );
                },
                divider: false,
              ), */
              WidgetCommon.border(),
            ],
          ),
        ),
      ),
    );
  }
}
