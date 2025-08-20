import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_birthday_page.dart';
import 'package:alpaca/pages/mine/mine_city_page.dart';
import 'package:alpaca/pages/mine/mine_gender_page.dart';
import 'package:alpaca/pages/mine/mine_intro_page.dart';
import 'package:alpaca/pages/mine/mine_nickname_page.dart';
import 'package:alpaca/pages/mine/mine_qrcode_page.dart';
import 'package:alpaca/pages/mine/mine_setting_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_upload.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 设置页面
class MineSettingPage extends GetView<MineSettingController> {
  // 路由地址
  static const String routeName = '/mine_setting';
  const MineSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineSettingController());
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
              '个人设置',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: GetBuilder<MineSettingController>(
        builder: (builder) {
          LocalUser localUser = controller.localUser;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  WidgetLineRow(
                    '头像',
                    widget: WidgetCommon.showAvatar(
                      localUser.portrait,
                      size: 55,
                    ),
                    hight: 10,
                    onTap: () {
                      WidgetUpload.image(
                        context,
                        onTap: (value) {
                          if (ToolsSubmit.call()) {
                            // 提交
                            controller.editPortrait(value);
                          }
                        },
                      );
                    },
                  ),
                  WidgetLineRow(
                    '昵称',
                    value: localUser.nickname,
                    onTap: () {
                      Get.toNamed(MineNicknamePage.routeName);
                    },
                  ),
                  WidgetLineContent(
                    '签名',
                    localUser.intro,
                    onTap: () {
                      Get.toNamed(MineIntroPage.routeName);
                    },
                  ),
                  WidgetLineRow(
                    'ID号',
                    value: localUser.userNo,
                    arrow: false,
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: localUser.userNo));
                      EasyLoading.showToast('文本已复制');
                    },
                  ),
                  WidgetLineRow(
                    '手机号码',
                    value: localUser.phone,
                    arrow: false,
                  ),
                  WidgetLineRow(
                    enable: AppConfig.register,
                    '我的邮箱',
                    value: localUser.email,
                    onTap: () {
                      Get.toNamed(MineEmailPage.routeName);
                    },
                  ),
                  WidgetLineRow(
                    '我的二维码',
                    widget: const Icon(Icons.qr_code),
                    onTap: () {
                      Get.toNamed(MineQrCodePage.routeName);
                    },
                  ),
                  WidgetLineRow(
                    '我的性别',
                    value: localUser.genderLabel,
                    onTap: () {
                      Get.toNamed(MineGenderPage.routeName);
                    },
                  ),
                  WidgetLineRow(
                    '我的生日',
                    value: localUser.birthday,
                    onTap: () {
                      Get.toNamed(MineBirthdayPage.routeName);
                    },
                  ),
                  WidgetLineRow(
                    '我的地区',
                    value: '${localUser.province} ${localUser.city}',
                    onTap: () {
                      Get.toNamed(MineCityPage.routeName);
                    },
                  ),

                  // WidgetLineRow(
                  //   '账号隐私',
                  //   onTap: () {
                  //     Get.toNamed(MinePrivacyPage.routeName);
                  //   },
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
