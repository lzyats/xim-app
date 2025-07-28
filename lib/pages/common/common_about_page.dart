import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/pages/common/common_about_controller.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';

class CommonAboutPage extends GetView<CommonAboutController> {
  // 路由地址
  static const String routeName = '/common_about';
  const CommonAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonAboutController());
    String beian = ToolsStorage().config().beian;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              '关于我们',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 80, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _buildLogo(),
                  _buildProject(),
                  _buildVersion(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  beian.isNotEmpty ? WidgetCommon.tips('') : Container(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildLogo() {
    return SizedBox(
      width: 96,
      height: 96,
      child: WidgetImage(
        AppImage.logo,
        ImageType.asset,
        width: 120,
        fit: BoxFit.cover,
      ),
    );
  }

  _buildProject() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Text(
        AppConfig.appName,
        style: const TextStyle(
          fontSize: 12 * 1.75,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildVersion() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Text('V${AppConfig.version}'),
    );
  }
}
