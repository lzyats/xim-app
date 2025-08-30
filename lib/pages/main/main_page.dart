import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/main/main_controller.dart';
import 'package:alpaca/pages/moment/moment_index_controller.dart';

import 'package:flutter/services.dart'; // 新增：用于SystemChrome控制
import 'package:alpaca/config/app_config.dart'; // 新增：用于访问AppConfig中的通话状态

// 主页面
class MainPage extends GetView<MainController> with WidgetsBindingObserver {
  // 路由地址
  static const String routeName = '/';
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MainController());

    // 初始化生命周期观察者
    WidgetsBinding.instance.addObserver(this); // 新增

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
          // 初始化时检查通话参数并设置全屏（新增）
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkCallAndSetFullScreen();
          });
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
                    width: 0.2,
                  ),
                ),
                // 新增渐变阴影效果
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFEBF3FF), // 阴影起始色（淡黑）
                    blurRadius: 8, // 模糊半径
                    spreadRadius: 0, // 扩散半径
                    offset: Offset(0, -2), // 阴影偏移（向上2px）
                  ),
                  BoxShadow(
                    color: Color.fromARGB(5, 0, 0, 0), // 阴影过渡色（更淡）
                    blurRadius: 12, // 更大的模糊半径
                    spreadRadius: 0,
                    offset: Offset(0, -4), // 向上偏移更多
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: builder.currentIndex,
                type: builder.items.length > 3
                    ? BottomNavigationBarType.fixed
                    : null,
                backgroundColor: Colors.white,
                fixedColor: Color(0xFF0463F7),
                items: builder.items,
                onTap: (int index) {
                  builder.currentIndex = index;
                  builder.update();
                  if (index == 1) {
                    final momentController = Get.find<MomentIndexController>();
                    // 调用公共的刷新方法
                    momentController.onRefresh();
                    builder.items[1] = builder.initItem(1, badger: 0);
                    int momentbadger = ToolsStorage().momentbadger(update: 0);
                    builder.update();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // 新增：检查通话参数并设置全屏
  Future<void> _checkCallAndSetFullScreen() async {
    debugPrint('检查通话参数');
    const platform = MethodChannel('lansoft.com/launchParams');
    final Map<String, dynamic>? params =
        await platform.invokeMethod('getLaunchParams');
    if (params != null && params['isIncomingCall'] == true) {
      // 若为来电唤醒，立即设置全屏
      await SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
        overlays: [],
      );
    }
    try {} catch (e) {
      debugPrint('检查通话参数失败: $e');
    }
  }

// 新增：监听应用生命周期变化（从后台返回前台时）
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 应用从后台回到前台
    if (state == AppLifecycleState.resumed) {
      // 若当前在通话中，重新设置全屏（假设AppConfig中有通话状态标记）
      if (AppConfig.isInCall) {
        // 需确保AppConfig中定义isInCall标记通话状态
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
          overlays: [],
        );
      }
    }
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
