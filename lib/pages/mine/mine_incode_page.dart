import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart'; // 用于复制邀请码（Clipboard）
import 'package:alpaca/pages/mine/mine_incode_controller.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:share_plus/share_plus.dart';

class MineIncodePage extends GetView<MineIncodeController> {
  // 路由地址
  static const String routeName = '/mine_incode';
  const MineIncodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineIncodeController());
    late LocalUser localUser = controller.localUser;
    late LocalConfig config = controller.config;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF66B3FF), Color(0xFF007AFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '邀请有礼',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ), // 页面背景透明，交由外层Container处理渐变
      backgroundColor: Colors.transparent,
      body: Container(
        // 背景渐变：从深蓝色到浅蓝色
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF007AFF), Color(0xFF66B3FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // —————— 顶部标题区 ——————
            const Center(
              child: Text(
                '邀好友 赚赏金',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Center(
              child: Text(
                '扫一扫二维码立即下载',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // —————— 红包&二维码区 ——————
            Center(
              child: Container(
                width: 300,
                height: 300, // 红包整体高度（含二维码、领按钮、邀请码）
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 二维码图片（示例用网络图片，实际需替换为项目资源）
                    Container(
                      width: 180,
                      height: 180, // 红
                      alignment: Alignment.center, // 确保内部白色背景Container居中
                      //margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: // 二维码图片（带白色圆角背景框）
                          Container(
                        // 白色圆角背景框
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10), // 圆角大小可调整
                        ),
                        padding: const EdgeInsets.all(18), // 二维码与背景框的间距
                        margin: const EdgeInsets.symmetric(
                            vertical: 10), // 与上下元素的间距
                        child: PrettyQrView.data(
                          data: controller.config.sharePath,
                          errorCorrectLevel: QrErrorCorrectLevel.Q,
                        ),
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Text(
                          '领',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 邀请码 + 复制按钮
                    // 邀请码 + 复制按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 带白色圆角背景框的邀请码
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6), // 文字与背景框的间距
                          decoration: BoxDecoration(
                            color: Colors.white, // 白色背景
                            borderRadius: BorderRadius.circular(8), // 圆角弧度
                          ),
                          child: Text(
                            localUser.incode,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black, // 文字改为黑色（原白色会与背景冲突）
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // 复制邀请码到剪贴板
                            Clipboard.setData(
                              ClipboardData(text: localUser.incode),
                            ).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('邀请码已复制')),
                              );
                            });
                          },
                          child: const Text('复制'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // —————— 立即分享按钮 ——————
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 此处对接分享逻辑（如使用 share_plus 插件）
                  String content =
                      '快来和我一起聊天吧,下载地址：${controller.config.sharePath} 邀请码：${localUser.incode} ';
                  Share.share(content);
                },
                child: const Text(
                  '立即分享',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // —————— 规则详情区 ——————
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 规则详情标题栏
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '规则详情',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // 规则列表（示例用占位文本，实际需替换为真实规则）
                  Column(
                    children: const [
                      ListTile(
                        title: Text('1. 成功推荐用户并注册成功即可获得奖励;'),
                      ),
                      ListTile(
                        title: Text('2. 推荐用户注销后重新注册只能获取一次奖励;'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // —————— 底部声明 ——————
            const Center(
              child: Text(
                '本活动最终解释权归平台所有',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class QrImageView {}
