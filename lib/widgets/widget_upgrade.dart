import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

// 弹窗升级
class WidgetUpgrade {
  WidgetUpgrade({
    required String version,
    required String url,
    required String content,
    required String force,
  }) {
    showCupertinoDialog(
      context: AppConfig.navigatorKey.currentState!.context,
      builder: (builder) {
        return CupertinoAlertDialog(
          title: Text('发现新版本：$version'),
          content: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                child: Text(
                  content,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          actions: [
            if ('N' == force)
              CupertinoDialogAction(
                child: const Text('稍后再说'),
                onPressed: () {
                  Get.back();
                },
              ),
            CupertinoDialogAction(
              child: const Text('立即体验'),
              onPressed: () async {
                await launchUrl(Uri.parse(url));
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
