import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_qrcode_controller.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

// 我的二维码
class MineQrCodePage extends GetView<MineQrCodeController> {
  // 路由地址
  static const String routeName = '/mine_qrcode';

  const MineQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineQrCodeController());
    GlobalKey globalKey = GlobalKey();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF3F8FD),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '我的二维码',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF3F8FD),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQrCode(globalKey),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0463F7),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('         保存到相册         '),
                onPressed: () async {
                  bool result = await ToolsPerms.storage();
                  if (!result) return;
                  Uint8List image = await WidgetCommon.widgetToImage(globalKey);
                  await ImageGallerySaver.saveImage(image);
                  EasyLoading.showToast('保存成功');
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildQrCode(GlobalKey globalKey) {
    return RepaintBoundary(
      key: globalKey,
      child: Container(
        child: GetBuilder<MineQrCodeController>(
          builder: (builder) {
            LocalUser localUser = controller.localUser;
            return Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  // 蓝色背景框（改为上下渐变色）
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: 350,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // 移除color，使用gradient
                      gradient: const LinearGradient(
                        // 从上到下的渐变色
                        colors: [
                          Color(0xFF3B6EE7), // 顶部深蓝色
                          Color(0xFF44ACF7), // 底部浅蓝色
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 50),
                        Text(
                          localUser.nickname,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'ID:${localUser.userNo}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          // 固定宽度为200（可根据需求调整具体数值）
                          width: 250,
                          color: Colors.white,
                          // 居中显示（可选，让固定宽度的容器在父组件中居中）
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            color: Colors.white,
                            child: WidgetCommon.showQrCode(
                                data: 'friend:${localUser.userId}',
                                avatar: localUser.portrait,
                                width: 200,
                                height: 200),
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          '扫一扫上面的二维码，添加我为好友',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                  // 头像
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFFF3F8FD),
                    child: CircleAvatar(
                      radius: 46,
                      backgroundImage: NetworkImage(localUser.portrait),
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
