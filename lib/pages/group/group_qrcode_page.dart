import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/group/group_qrcode_controller.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

// 群二维码
class GroupQrCodePage extends GetView<GroupQrCodeController> {
  // 路由地址
  static const String routeName = '/group_qrcode';

  const GroupQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GroupQrCodeController());
    GlobalKey globalKey = GlobalKey();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('群二维码'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQrCode(globalKey),
            const SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              child: const Icon(
                Icons.image,
              ),
              onPressed: () async {
                // 权限
                bool result = await ToolsPerms.storage();
                if (!result) {
                  return;
                }
                // widgit转图片
                Uint8List image = await WidgetCommon.widgetToImage(globalKey);
                // 保存图片到本地
                await ImageGallerySaver.saveImage(image);
                // 弹框提示
                EasyLoading.showToast('保存成功');
              },
            ),
            const SizedBox(
              height: 20,
            ),
            WidgetCommon.tips('保存到相册'),
          ],
        ),
      ),
    );
  }

  _buildQrCode(GlobalKey globalKey) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        color: Colors.white,
        child: GetBuilder<GroupQrCodeController>(
          builder: (builder) {
            ChatGroup chatGroup = controller.chatGroup;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    chatGroup.groupName,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '群ID：${chatGroup.groupNo}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  WidgetCommon.showQrCode(
                    data: 'group:${chatGroup.groupId}',
                    avatar: chatGroup.portrait,
                  ),
                  Text(
                    '请使用《${AppConfig.appName}》扫描二维码，加入群聊',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
