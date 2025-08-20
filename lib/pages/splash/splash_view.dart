import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  final logic = Get.find<SplashLogic>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned(
            top: 603,
            width: 375,
            child: Center(
              child: Image.asset(
                ImageRes.ic_app,
                width: 52,
                height: 53,
              ),
            ),
          ),
          Positioned(
            top: 673,
            width: 375,
            child: Center(
              child: Text(
                StrRes.welcomeHint,
                style: PageStyle.ts_333333_16sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
