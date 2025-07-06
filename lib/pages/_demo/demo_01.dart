import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class Demo01 extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_01';
  const Demo01({super.key});

  @override
  createState() => _DemoState();
}

class _DemoState extends State<Demo01> {
  final String appId = '__UNI__7EA7DBC';
  // final String appName = '天气预报';
  final String appUrl = 'https://baidu.com/test/__UNI__7EA7DBC.wgt';
  // final String appUrl =
  //     'http://im-oss.baidu.com/group0/VT/E7/CD/655313c4e4b0141433c9412e.wgt';
  // final String appVersion = '1.0.0';

  // 通道
  final platform = const MethodChannel('UniMP_mini_apps');

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(onCallBack);
  }

  Future<dynamic> onCallBack(MethodCall method) async {
    print('回调函数');
    switch (method.method) {
      case "helloFromNative":
        print("收到原生消息1: ${method.arguments}");
        break;
      default:
        print("收到原生消息2: ${method.arguments}");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () {
              test1();
            },
            child: const Text("版本"),
          ),
          TextButton(
            onPressed: () {
              test2();
            },
            child: const Text("安装"),
          ),
          TextButton(
            onPressed: () {
              test3();
            },
            child: const Text("打开"),
          ),
          TextButton(
            onPressed: () {
              test4();
            },
            child: const Text("回调"),
          ),
        ],
      )),
    );
  }

  Future<void> test1() async {
    print('================');
    dynamic result = await platform.invokeMethod('version', {
      'appId': appId,
    });
    print(result);
    print('================');
  }

  Future<void> test2() async {
    // 获取应用的缓存目录
    final directory = await getTemporaryDirectory();
    String appPath = '${directory.path}/${const Uuid().v8()}.wgt';
    await Dio().download(appUrl, appPath);
    dynamic result = await platform.invokeMethod('install', {
      'appId': appId,
      'appPath': appPath,
    });
    print(result);
    print('================');
  }

  Future<void> test3() async {
    print('================');
    dynamic result = await platform.invokeMethod('open', {
      'appId': appId,
    });
    print(result);
    print('================');
  }

  Future<void> test4() async {
    print('================');
    await platform.invokeMethod('callback');
    print('================');
  }
}
