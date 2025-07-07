import 'dart:async';
import 'dart:io';

import 'package:alpaca/tools/tools_push.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getuiflut/getuiflut.dart';
import 'package:alpaca/config/app_setting.dart';
import 'package:alpaca/request/request_message.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_socket.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 总配置
class AppConfig {
  /// 开发模式=dev
  /// 生产模式=pro
  static const String active = 'dev';
  // debug模式
  static late bool debug;
  // 以下为配置文件读取出来
  static final navigatorKey = GlobalKey<NavigatorState>();
  // 封面图片
  static const String thumbnail =
      'https://img.alicdn.com/imgextra/i4/87413133/O1CN01G3RG1G1Z0xr11pokW_!!87413133.png';
  // 在线客服
  static const String robotId = '10001';
  // 视频大小
  static const int videoSize = 100;
  // appId
  static late String appId;
  // appSecret
  static late String appSecret;
  // secret
  static late String secret;
  // 朋友圈接口请求地址
  static late String commentHost;
  // 接口请求地址
  static late String requestHost;
  // socket地址
  static late String requestSocket;
  // 请求隐私协议
  static late String privacyHost;
  // 请求服务协议
  static late String serviceHost;
  // 数据库
  static const String dbName = 'alpaca—im.db';
  // 高德地图
  static late String amapAndroid;
  static late String amapIos;
  // 个推推送
  static late String pushId;
  static late String pushKey;
  static late String pushSecret;
  // 群主领取红包
  static late bool groupTrade;
  // 密码登录
  static late bool loginPwd;
  // 邮箱注册
  static late bool register;
  // 小程序
  static late bool mini;
  // 设备类型
  static final String device = Platform.operatingSystem;
  // 项目名称
  static late final String appName;
  // 版本号码
  static late final String version;
  // network
  static bool network = false;
  // socket
  static bool socket = false;
  // 是否在线
  static RxString onlineMark = '消息'.obs;
  // 是否打开
  static bool open = true;
  // 超时时间
  static Duration timeout = const Duration(seconds: 5);
  // 密码文本
  static const String passText = '密码长度为8-16位，可以使用字母、数字和特殊字符';
  // 通话
  static bool callKit = false;
  // 定时
  static Timer? _timer;

  // 初始化
  static init() async {
    // 全局异常
    await _loadException();
    // 全局存储
    await GetStorage.init();
    // 禁止横屏
    await _loadPortrait();
    // 通知栏
    await _loadNotification();
    // 加载配置文件
    await _loadConfig();
    // 加载配置文件
    await _loadSetting();
    // 读取app配置
    await _loadPackage();
    // 生命周期
    await _loadAppLifecycle();
    // 全局定时任务
    await _loadTimer();
    // 网络监测
    await _loadNetwork();
    // 推送集成
    await _loadPush();
  }

  // 拦截异常
  static _loadException() {
    FlutterError.onError = (details) {
      // 错误
      String error = details.exception.toString();
      // 处理
      error = error.replaceFirst('Exception: ', '');
      if ('' == error) {
        return;
      }
      EasyLoading.showToast(error);
    };
  }

  // 禁止横屏
  static _loadPortrait() async {
    // 禁止横屏
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  // 通知栏
  static _loadNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'alerts',
          onlyAlertOnce: true,
          importance: NotificationImportance.High,
        )
      ],
    );
    await AwesomeNotifications().getInitialNotificationAction(
      removeFromActionEvents: false,
    );
    // 请求权限
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // 加载配置文件
  static _loadConfig() {
    'dev' == active ? AppSetting.dev() : AppSetting.pro();
  }

  // 加载配置文件
  static _loadSetting() async {
    ChatConfig value = await ToolsSqlite().config.getConfig();
    ToolsStorage().setting(value: value);
  }

  // 读取app配置
  static _loadPackage() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    version = packageInfo.version;
  }

  // 生命周期
  static _loadAppLifecycle() {
    SystemChannels.lifecycle.setMessageHandler((handler) async {
      if (AppLifecycleState.resumed.toString() == handler) {
        debugPrint('打开app');
        // 是否打开
        AppConfig.open = true;
        // 重置角标
        await AwesomeNotifications().resetGlobalBadge();
      } else if (AppLifecycleState.paused.toString() == handler) {
        debugPrint('关闭app');
        // 是否打开
        AppConfig.open = false;
      }
      return handler;
    });
  }

  // 全局定时任务
  static _loadTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 在线标志
      AppConfig.setOnline();
      // 心跳
      if (MiddleStatus.normal == ToolsStorage().status()) {
        ToolsSocket().heartbeat();
        ToolsPush().heartbeat();
      }
      // 关闭
      else {
        ToolsSocket().close();
        ToolsPush().close();
      }
    });
  }

  // 在线标志
  static setOnline({bool? network, bool? socket}) {
    if (network != null) {
      AppConfig.network = network;
    }
    if (socket != null) {
      AppConfig.socket = socket;
    }
    String onlineMark = '消息';
    // 离线
    if (!AppConfig.network) {
      onlineMark = '消息(离线)';
    }
    // 在线
    else if (!AppConfig.socket) {
      onlineMark = '收取中...';
    }
    AppConfig.onlineMark.value = onlineMark;
  }

  // 推送集成
  static _loadPush() async {
    // 苹果设备
    if (Platform.isIOS) {
      Getuiflut().startSdk(
        appId: AppConfig.pushId,
        appKey: AppConfig.pushKey,
        appSecret: AppConfig.pushSecret,
      );
    }
    // 安卓设备
    if (Platform.isAndroid) {
      Getuiflut.initGetuiSdk;
    }
    // 连接
    ToolsPush().onConnect();
  }

  // 网络监测
  static _loadNetwork() async {
    Connectivity().onConnectivityChanged.listen((result) {
      switch (result.first) {
        // 在线
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          // 在线标志
          AppConfig.setOnline(network: true);
          // 拉取离线
          if (MiddleStatus.normal == ToolsStorage().status()) {
            RequestMessage.pullMsg();
          }
          break;
        // 离线
        default:
          // 在线标志
          AppConfig.setOnline(network: false);
          break;
      }
    });
  }

  // 下拉刷新全局配置
  static refreshConfig({required Widget child}) {
    return RefreshConfiguration(
      // 配置默认头部指示器
      headerBuilder: () => const ClassicHeader(
        idleText: "下拉刷新",
        refreshingText: "刷新中...",
        completeText: "刷新成功",
        releaseText: "松开立即刷新",
        failedText: '刷新失败',
      ),
      // 配置默认底部指示器
      footerBuilder: () => const ClassicFooter(
        idleText: "上拉加载",
        loadingText: "加载中…",
        canLoadingText: "松手开始加载数据",
        failedText: "加载失败",
        noDataText: "没有更多数据了",
        // noMoreIcon: ,"没有内容的图标"
      ),
      // 头部触发刷新的越界距离
      headerTriggerDistance: 60.0,
      // 底部触发刷新的越界距离,距离底部多少开始刷新
      footerTriggerDistance: 0,
      // 头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
      maxOverScrollExtent: 100,
      // 这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
      enableScrollWhenRefreshCompleted: false,
      // 在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      enableLoadingWhenFailed: true,
      enableBallisticRefresh: true,
      // Viewport不满一屏时,禁用上拉加载更多功能
      hideFooterWhenNotFull: false,
      // 可以通过惯性滑动触发加载更多
      enableBallisticLoad: false,
      // 子包
      child: child,
    );
  }

  // 主题
  static final ThemeData theme = AppTheme.theme;
}
