import 'package:alpaca/pages/view/html_page.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_safety_page.dart';
import 'package:alpaca/pages/mine/mine_setting_page.dart';
import 'package:alpaca/pages/common/common_index_controller.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';

// 软件设置
class CommonSoftwarePage extends GetView<CommonSoftwareController> {
  // 路由地址
  static const String routeName = '/common_software';
  const CommonSoftwarePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonSoftwareController());
    String str = "http://110.42.56.25:8080|wss://110.42.56.25:8888";
    String secret = AppConfig.secret;
    secret = ToolsEncrypt.encrypt(secret, str);
    debugPrint("加密：" + secret);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '软件设置',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            children: [
              RoundedContainer(
                  child: Column(children: [
                WidgetLineRow(
                  "个人设置",
                  onTap: () {
                    Get.toNamed(
                      MineSettingPage.routeName,
                    );
                  },
                ),
                WidgetLineRow(
                  "账号安全",
                  onTap: () {
                    Get.toNamed(
                      MineSafetyPage.routeName,
                    );
                  },
                ),
                WidgetLineRow(
                  "关于我们",
                  onTap: () {
                    Get.toNamed(
                      //CommonAboutPage.routeName,
                      HtmlPage.routeName,
                      arguments: "sys-aboutus", // 传入roulekey参数
                    );
                  },
                  divider: false,
                ),
              ])),
              RoundedContainer(
                  child: Column(children: [
                WidgetLineRow(
                  "服务器设置",
                  onTap: () async {
                    // 从本地存储获取配置
                    SysConfig localConfig = ToolsStorage().sysConfig();
                    // 获取线路列表
                    List<Map<String, String>> routeList =
                        await AppConfig.requestHostgroup;
                    _showRouteDialog(localConfig, routeList);
                  },
                ),
                WidgetLineRow(
                  "软件版本(V${AppConfig.version})",
                  value: '长按检查更新',
                  arrow: false,
                  onLongPress: () {
                    if (ToolsSubmit.call()) {
                      RequestCommon.upgrade(force: true);
                    }
                  },
                ),
              ])),

              /* WidgetLineRow(
                "分享应用",
                onTap: () {
                  String content = '快来和我一起聊天吧${controller.sharePath}';
                  Share.share(content);
                },
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: controller.sharePath));
                  EasyLoading.showToast('文本已复制');
                },
              ), */
              /* WidgetLineRow(
                "帮助中心",
                onTap: () {
                  Get.toNamed(
                    CommonHelpPage.routeName,
                  );
                },
              ), */
              /* WidgetLineRow(
                "建议反馈",
                onTap: () {
                  Get.toNamed(
                    CommonFeedbackPage.routeName,
                  );
                },
                divider: false,
              ), */
              RoundedContainer(
                  child: Column(children: [
                WidgetLineRow(
                  "消息声音",
                  subtitle: '开启后接收消息会有声音提醒',
                  widget: Obx(
                    () => Switch(
                      value: 'Y' == controller.audio.value,
                      onChanged: (bool value) {
                        controller.editAudio(value);
                      },
                      activeTrackColor: const Color(0xFF00ABFF), // 开启状态轨道颜色
                      inactiveTrackColor: const Color(0xFFDFDFDF), // 关闭状态轨道颜色
                    ),
                  ),
                  arrow: false,
                ),
                WidgetLineRow(
                  "消息通知",
                  subtitle: '开启后接收消息会有通知提醒',
                  widget: Obx(
                    () => Switch(
                      value: 'Y' == controller.notice.value,
                      onChanged: (bool value) {
                        controller.editNotice(value);
                      },
                      activeTrackColor: const Color(0xFF00ABFF), // 开启状态轨道颜色
                      inactiveTrackColor: const Color(0xFFDFDFDF), // 关闭状态轨道颜色
                    ),
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetLineRow(
                  "传统导航",
                  subtitle: '开启后聊天时底部默认传统导航占位',
                  widget: Obx(
                    () => Switch(
                      value: 'Y' == controller.nav.value,
                      onChanged: (bool value) {
                        controller.editNav(value);
                      },
                      activeTrackColor: const Color(0xFF00ABFF), // 开启状态轨道颜色
                      inactiveTrackColor: const Color(0xFFDFDFDF), // 关闭状态轨道颜色
                    ),
                  ),
                  arrow: false,
                  divider: false,
                ),
                WidgetLineRow(
                  "服务协议",
                  onTap: () {
                    Get.toNamed(HtmlPage.routeName, arguments: "sys-service");
                  },
                ),
                WidgetLineRow(
                  "隐私协议",
                  onTap: () {
                    Get.toNamed(HtmlPage.routeName, arguments: "sys-privacy");
                  },
                ),
                /* WidgetLineRow(
                "信息收集",
                onTap: () {
                  Get.toNamed(
                    MineInventoryPage.routeName,
                  );
                },
                divider: false,
              ), */
              ])),
            ],
          ),
        ),
      ),
    );
  }

  // 显示线路选择对话框
  void _showRouteDialog(
      SysConfig localConfig, List<Map<String, String>> routeList) async {
    int selectedIndex;

    if (routeList.isEmpty) {
      selectedIndex = 0;
    } else {
      final matchedIndex = routeList.indexWhere((route) {
        return localConfig != null &&
            route["httpUrl"] != null &&
            route["wsUrl"] != null &&
            route["httpUrl"] == localConfig.requestHost &&
            route["wsUrl"] == localConfig.requestSocket;
      });
      selectedIndex = matchedIndex != -1 ? matchedIndex : 0;
    }

    bool showAddRoute = false;

    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              contentPadding: const EdgeInsets.all(16),
              title: const Center(
                child: Text(
                  "选择服务线路",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold),
                ),
              ),
              // 在content外层包裹ConstrainedBox
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth:
                      MediaQuery.of(context).size.width * 0.65, // 占屏幕宽度的80%
                ),
                child: routeList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            "暂无可用服务线路",
                            style: TextStyle(color: Color(0xFF666666)),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...routeList.asMap().entries.map((entry) {
                              int index = entry.key;
                              var route = entry.value;
                              final routeName = route["name"] ?? "未知线路";
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: selectedIndex == index
                                          ? const Color(0xFF00ABFF)
                                          : const Color(0xFFBDBDBD),
                                      width: 1),
                                  color: selectedIndex == index
                                      ? const Color(0xFFF0F7FF)
                                      : Colors.white,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    selectedIndex == index
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: const Color(0xFF00ABFF),
                                  ),
                                  title: Text(
                                    routeName,
                                    style: TextStyle(
                                      color: selectedIndex == index
                                          ? const Color(0xFF00ABFF)
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    if (index >= 0 &&
                                        index < routeList.length) {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                            if (!showAddRoute && routeList.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF00ABFF),
                                  ),
                                  title: const Text(
                                    "添加新线路",
                                    style: TextStyle(color: Color(0xFF00ABFF)),
                                  ),
                                  onTap: () async {
                                    bool result = await ToolsPerms.camera();
                                    if (!result) return;
                                    if (Get.context != null) {
                                      Navigator.of(Get.context!).pop();
                                    }
                                    ToolsScan.scan();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (routeList.isEmpty) {
                        EasyLoading.showError('暂无可用服务线路');
                      } else if (selectedIndex < 0 ||
                          selectedIndex >= routeList.length) {
                        EasyLoading.showError('请选择有效的服务线路');
                      } else {
                        var selectedRoute = routeList[selectedIndex];
                        final httpUrl = selectedRoute["httpUrl"] ?? "";
                        final wsUrl = selectedRoute["wsUrl"] ?? "";
                        if (httpUrl.isEmpty || wsUrl.isEmpty) {
                          EasyLoading.showError('选中线路信息不完整');
                          return;
                        }
                        final eName = selectedRoute["name"] ?? "未知线路";
                        debugPrint("选中线路：$eName");
                        debugPrint("HTTP地址：$httpUrl");
                        debugPrint("WS地址：$wsUrl");
                        SysConfig newConfig = SysConfig(
                          hostName: eName,
                          requestHost: httpUrl,
                          requestSocket: wsUrl,
                        );
                        Navigator.pop(dialogContext);
                        await controller.saveRouteConfig(newConfig, eName);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "确定",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
