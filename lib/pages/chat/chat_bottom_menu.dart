import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/mine/mine_error.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:alpaca/pages/wallet/wallet_trade_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_storage.dart';

class ChatBottomMenu extends StatefulWidget {
  final RxString menu;
  const ChatBottomMenu({super.key, required this.menu});

  @override
  createState() => _ChatBottomMenuState();
}

class _ChatBottomMenuState extends State<ChatBottomMenu> {
  late List<MenuModel> dataList;
  OverlayEntry? _overlayEntry;
  GlobalKey? _globalKey;
  // 发布订阅
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    dataList = MenuModel.getList(widget.menu.value);
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close == model.setting) {
        // 隐藏弹窗
        _hideOverlay();
      }
    });
  }

  @override
  void dispose() {
    // 隐藏弹窗
    _hideOverlay();
    if (mounted) {
      _subscription?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideOverlay();
      },
      child: ChatMenuBottom(
        dataList: dataList,
        onButtonTap: (menuModel) {
          // 赋值
          GlobalKey? globalKey = _globalKey;
          // 隐藏弹窗
          _hideOverlay();
          // 没子菜单
          if (menuModel.children.isEmpty) {
            // 执行菜单
            _doMenu(menuModel);
          }
          // 有子菜单
          else if (menuModel.globalKey != globalKey) {
            // 显示弹窗
            _showOverlay(context, menuModel);
          }
        },
      ),
    );
  }

  // 显示弹窗
  void _showOverlay(BuildContext context, MenuModel menuModel) {
    // 赋值
    _globalKey = menuModel.globalKey;
    List<MenuModel> children = menuModel.children;
    final RenderBox renderBox =
        menuModel.globalKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    // 弹出宽度
    final overlayWidth = MediaQuery.of(context).size.width / 3 - 5;
    // 弹出高度
    final overlayHeight = children.length * 40.0 + 5;
    // 弹出位置
    final overlayPosition = Offset(
      position.dx + (renderBox.size.width - overlayWidth) / 2,
      position.dy - overlayHeight,
    );
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: overlayPosition.dx,
        top: overlayPosition.dy,
        child: Container(
          width: overlayWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // 阴影颜色
                spreadRadius: 2, // 扩散半径
                blurRadius: 7, // 模糊半径
              )
            ],
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              MenuModel child = children[index];
              bool border = index != children.length - 1;
              return GestureDetector(
                onTap: () {
                  // 隐藏菜单
                  _hideOverlay();
                  // 执行菜单
                  _doMenu(child);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: 40,
                  decoration: border
                      ? const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 0.2,
                            ),
                          ),
                        )
                      : null,
                  child: Center(
                    child: Text(
                      child.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  // 执行菜单
  void _doMenu(MenuModel menuModel) {
    String value = menuModel.value;
    switch (menuModel.type) {
      // 视图
      case 'view':
        Get.toNamed(
          ViewPage.routeName,
          arguments: ViewData(
            value,
          ),
        );
        break;
      // 事件
      case 'even':
        Map<String, dynamic> content = {
          'data': value,
        };
        MsgType msgType = MsgType.even;
        // 组装消息
        EventChatModel model = EventChatModel(
          ToolsStorage().chat(),
          msgType,
          content,
          write: false,
        );
        // 发布消息
        EventMessage().listenSend.add(model);
        break;
      // 应用
      case 'page':
        // 账单
        if (value.startsWith(WalletTradePage.routeName)) {
          Get.toNamed(value, arguments: TradeType.init(value.split('?').last));
          return;
        }
        // 判断是否存在
        if (!ToolsRoute().existRoute(value)) {
          // 如果不存在，则跳转到错误页面
          value = MineError.routeName;
        }
        Get.toNamed(value);
        break;
      // 小程序
      case 'mini':
        break;
    }
  }

  // 隐藏弹窗
  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _globalKey = null;
  }
}

class ChatMenuBottom extends StatelessWidget {
  final List<MenuModel> dataList;
  final Function(MenuModel) onButtonTap;

  const ChatMenuBottom({
    super.key,
    required this.dataList,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(dataList.length, (index) {
          return Expanded(
            child: _buildMenu(
              dataList[index],
              index != dataList.length - 1,
            ),
          );
        }),
      ),
    );
  }

  // 构建一级菜单
  _buildMenu(MenuModel menuModel, bool border) {
    return GestureDetector(
      onTap: () {
        onButtonTap(menuModel);
      },
      child: Container(
        key: menuModel.globalKey,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: border
                ? const BorderSide(
                    color: Colors.grey,
                    width: 0.2,
                  )
                : BorderSide.none,
            top: const BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 阴影颜色
              blurRadius: 1, // 模糊半径
            )
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                menuModel.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (menuModel.children.isNotEmpty)
                const Icon(
                  AppFonts.e604,
                  color: Colors.grey,
                  size: 25,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 服务号菜单
class MenuModel {
  GlobalKey globalKey;
  String name;
  String type;
  String value;
  List<MenuModel> children;

  MenuModel(
    this.globalKey,
    this.name,
    this.type,
    this.value,
    this.children,
  );

  static List<MenuModel> getList(String menu) {
    List<dynamic> dataList = jsonDecode(menu);
    return dataList.map((data) => MenuModel.fromJson(data)).toList();
  }

  factory MenuModel.fromJson(Map<String, dynamic> data) {
    List<dynamic> children = data['children'] ?? [];

    return MenuModel(
      GlobalKey(),
      data['name'] ?? '',
      data['type'] ?? '',
      data['value'] ?? '',
      children.map((data) => MenuModel.fromJson(data)).toList(),
    );
  }
}
