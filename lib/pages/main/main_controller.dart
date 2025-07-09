import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/event/event_socket.dart';
//import 'package:alpaca/pages/_demo/_demo_test.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/friend/friend_index_page.dart';
import 'package:alpaca/pages/mine/mine_index_page.dart';
import 'package:alpaca/pages/msg/msg_index_page.dart';
import 'package:alpaca/pages/wallet/wallet_goods_page.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/request/request_robot.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_mark.dart';
import 'package:alpaca/tools/tools_uni.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'package:alpaca/pages/moment/moment_index_page.dart'; // 引入朋友圈页面

// tables
class _TabsModel {
  final String label;
  final IconData icon;
  final Widget widget;
  const _TabsModel(this.label, this.icon, this.widget);
}

class MainController extends BaseController {
  // 静态属性
  static final List<_TabsModel> _pageList = [
    const _TabsModel('消息', AppFonts.e67e, MsgIndexPage()),
    //const _TabsModel('圈子', AppFonts.qz01, DemoTest()),
    const _TabsModel('朋友圈', AppFonts.qz01, MomentIndexPage()),
    const _TabsModel('好友', AppFonts.e689, FriendIndexPage()),
    const _TabsModel('我的', AppFonts.e70f, MineIndexPage()),
    //const _TabsModel('测试', Icons.developer_board, DemoTest()),
  ];

  // 当前页面
  int currentIndex = 0;

  // 当前计数器
  final Map<String, int> _badgerMap = {};

  // 索引
  List<BottomNavigationBarItem> items = [];

  // 初始化
  _initItem(int index, {int badger = 0}) {
    _TabsModel model = _pageList[index];
    return BottomNavigationBarItem(
      label: model.label,
      icon: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SizedBox(
            width: 50,
            child: Icon(
              model.icon,
              size: 30,
            ),
          ),
          if (badger > 0)
            Positioned(
              right: 0,
              top: 0,
              child: TDBadge(
                TDBadgeType.message,
                count: badger > 99 ? '99+' : badger.toString(),
                size: TDBadgeSize.large,
                padding: EdgeInsetsGeometry.infinity,
              ),
            ),
        ],
      ),
    );
  }

  // 页面列表
  static List<Widget> children() {
    List<Widget> items = [];
    for (var item in _pageList) {
      items.add(item.widget);
    }
    return items;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    // 初始化
    for (var i = 0; i < (_pageList.length - (AppConfig.debug ? 0 : 1)); i++) {
      items.add(_initItem(i));
    }
    // 查询自己
    await RequestMine.getInfo();
    // 好友列表
    RequestFriend.getFriendList();
    // 群聊列表
    RequestGroup.getGroupList();
    // 服务列表
    RequestRobot.getRobotList();
    // 检查更新
    RequestCommon.upgrade();
    // 获取配置
    RequestCommon.getConfig();
    // 监听Socket消息
    subscription1 = EventSocket().addListen();
    // 监听聊天消息
    subscription2 = EventMessage().addListen();
    // 监听设置
    subscription3 = _listenSetting();
    // 监听小程序
    _listenMini();
    // 刷新用户
    RequestMine.refresh();
  }

  _listenSetting() {
    // 系统设置
    _listenConfig();
    // 系统设置
    _listenFirst();
    // 监听
    return EventSetting().event.stream.listen((model) {
      // 系统
      if (SettingType.sys == model.setting) {
        // 系统设置
        _listenConfig();
      }
      // 计数器
      else if (SettingType.badger == model.setting) {
        String label = model.label;
        int value = int.parse(model.value);
        switch (model.label) {
          case 'friend':
          case 'group':
            _badgerMap[label] = value;
            // 系统设置
            _listenSecond();
            break;
        }
      }
    });
  }

  // 系统设置
  _listenConfig() async {
    // 水印
    LocalConfig localConfig = ToolsStorage().config();
    Future.delayed(const Duration(seconds: 5), () {
      ToolsMark().build(Get.context!, localConfig.watermark);
    });
    // 截屏
    String screenshot = localConfig.screenshot;
    if ('Y' == screenshot) {
      if (Platform.isAndroid) {
        await ScreenProtector.protectDataLeakageOff();
      } else {
        await ScreenProtector.preventScreenshotOff();
      }
    } else if ('N' == screenshot) {
      if (Platform.isAndroid) {
        await ScreenProtector.protectDataLeakageOn();
      } else {
        await ScreenProtector.preventScreenshotOn();
      }
    }
  }

  // 系统设置
  _listenFirst() async {
    // 更新消息
    ToolsBadger().listen((value) {
      items[0] = _initItem(0, badger: value);
      update();
    });
  }

  // 系统设置
  _listenSecond() async {
    int friend = _badgerMap['friend'] ?? 0;
    int group = _badgerMap['group'] ?? 0;
    items[2] = _initItem(2, badger: friend + group);
    update();
  }

  // 系统设置
  _listenMini() async {
    // 初始化
    await ToolsUni().listen(receive: (native) async {
      String appId = native['appId'];
      UniEvent event = UniEvent.init(native['event']);
      Map<dynamic, dynamic> data = native['data'] ?? {};
      switch (event) {
        // 关闭
        case UniEvent.close:
          ToolsUni().close(appId: appId);
          break;
        // 授权
        case UniEvent.oauth:
          LocalUser local = ToolsStorage().local();
          Map<String, dynamic> data = {
            'userId': local.userId,
            'userNo': local.userNo,
            'nickname': local.nickname,
            'portrait': local.portrait,
          };
          ToolsUni().callback(appId: appId, event: 'oauth', data: data);
          break;
        // 支付
        case UniEvent.payment:
          // 隐藏
          await ToolsUni().hide(appId: appId);
          // 打开支付
          data['appId'] = appId;
          Get.offAndToNamed(WalletGoodsPage.routeName, arguments: data);
          break;
      }
    });
  }
}
