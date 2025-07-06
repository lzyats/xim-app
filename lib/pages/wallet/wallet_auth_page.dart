import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/pages/wallet/wallet_auth_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_upload.dart';

// 钱包认证
class WalletAuthPage extends GetView<WalletAuthController> {
  // 路由地址
  static const String routeName = '/wallet_auth';
  const WalletAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletAuthController());
    bool holdCard = ToolsStorage().config().holdCard == 'Y';
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('实名认证'),
          actions: [
            WidgetAction(
              onTap: () {
                if (ToolsSubmit.progress()) {
                  return;
                }
                // 校验
                if (controller.nameController.text.trim().isEmpty) {
                  throw Exception('姓名不能为空');
                }
                if (controller.idCardController.text.trim().isEmpty) {
                  throw Exception('身份证号码不能为空');
                }
                if (controller.identity1.isEmpty) {
                  throw Exception('身份证人像面不能为空');
                }
                if (controller.identity2.isEmpty) {
                  throw Exception('身份证国徽面不能为空');
                }
                if (holdCard && controller.holdCard.isEmpty) {
                  throw Exception('手持身份证不能为空');
                }
                if (ToolsSubmit.call()) {
                  // 提交
                  controller.editAuth();
                }
              },
            )
          ],
        ),
        body: GetBuilder<WalletAuthController>(builder: (builder) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  WidgetCommon.label('姓名'),
                  _buildName(),
                  WidgetCommon.divider(),
                  WidgetCommon.label('身份证号码'),
                  _buildIdCard(),
                  WidgetCommon.divider(),
                  WidgetCommon.label('身份证人像面'),
                  _buildUpload(context, 1),
                  WidgetCommon.divider(),
                  WidgetCommon.label('身份证国徽面'),
                  _buildUpload(context, 2),
                  WidgetCommon.divider(),
                  if (holdCard) WidgetCommon.label('手持身份证（需包含人脸和身份证人像面）'),
                  if (holdCard) _buildUpload(context, 3),
                  if (holdCard) WidgetCommon.divider(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  _buildName() {
    return TextField(
      controller: controller.nameController,
      decoration: const InputDecoration(
        hintText: '请输入姓名',
        filled: false,
        prefixIconConstraints: BoxConstraints(),
        counterText: '',
      ),
      maxLength: 20,
    );
  }

  _buildIdCard() {
    return TextField(
      controller: controller.idCardController,
      decoration: const InputDecoration(
        hintText: '请输入身份证号码',
        filled: false,
        prefixIconConstraints: BoxConstraints(),
        counterText: '',
      ),
      maxLength: 20,
    );
  }

  _buildUpload(BuildContext context, int index) {
    String image;
    IconData icon;
    if (index == 1) {
      image = controller.identity1;
      icon = AppFonts.e687;
    } else if (index == 2) {
      image = controller.identity2;
      icon = AppFonts.e688;
    } else {
      image = controller.holdCard;
      icon = AppFonts.e690;
    }
    return GestureDetector(
      onTap: () {
        WidgetUpload.image(
          context,
          upload: false,
          onTap: (value) {
            controller.image(index, value);
          },
        );
      },
      child: Row(
        children: [
          Container(),
          Expanded(
            child: image.isEmpty
                ? Icon(
                    icon,
                    color: AppTheme.color,
                    size: 150,
                  )
                : WidgetImage(
                    image,
                    ImageType.file,
                    width: 150,
                    height: 150,
                    fit: BoxFit.scaleDown,
                  ),
          ),
          Container(),
        ],
      ),
    );
  }
}
