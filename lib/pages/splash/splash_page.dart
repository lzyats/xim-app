import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/splash/splash_controller.dart';
import 'package:alpaca/config/app_resource.dart';

class SplashPage extends GetView<SplashController> {
  // 路由地址
  static const String routeName = '/splash';
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned(
            child: Center(
              child: Image.asset(
                AppImage.logos,
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            child: Center(
              child: Text(
                "欢迎使用密聊",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF333333),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
