import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/main/main_controller.dart';
import 'package:alpaca/config/app_theme.dart';

// 主页面
class MainPage extends GetView<MainController> {
  // 路由地址
  static const String routeName = '/';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainController());
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        _backApp(context);
      },
      child: GetBuilder<MainController>(
        builder: (builder) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: IndexedStack(
              index: builder.currentIndex,
              children: MainController.children(),
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color.fromARGB(255, 219, 217, 217),
                    width: 0.8,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: builder.currentIndex,
                type: builder.items.length > 3
                    ? BottomNavigationBarType.fixed
                    : null,
                backgroundColor: Colors.white,
                fixedColor: AppTheme.color,
                items: builder.items,
                onTap: (int index) {
                  builder.currentIndex = index;
                  builder.update();
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // 退出app
  _backApp(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: const Text(
            '是否退出当前应用？',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确认'),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
