import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/_demo/demo_01.dart';
import 'package:alpaca/pages/_demo/demo_02.dart';
import 'package:alpaca/pages/_demo/demo_03.dart';
import 'package:alpaca/pages/_demo/demo_briday.dart';
import 'package:alpaca/pages/_demo/demo_huadong.dart';
import 'package:alpaca/pages/_demo/demo_bank.dart';
import 'package:alpaca/pages/_demo/demo_launcher.dart';

import 'package:alpaca/pages/_demo/demo_pyq.dart';
import 'package:alpaca/pages/_demo/demo_sqflite.dart';
import 'package:alpaca/widgets/widget_common.dart';

class DemoTest extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_test';
  const DemoTest({super.key});

  @override
  createState() => _DemoDemoState();
}

class _DemoDemoState extends State<DemoTest> {
  List<TestDemo> dataList = [
    TestDemo(
      "小程序",
      Demo01.routeName,
    ),
    TestDemo(
      "开发2",
      Demo02.routeName,
    ),
    TestDemo(
      "开发3",
      Demo03.routeName,
    ),
    TestDemo(
      "数据库",
      DemoSqflite.routeName,
    ),
    TestDemo(
      "抖音视频",
      DemoHuadong.routeName,
    ),
    TestDemo(
      "银行卡",
      DemoBank.routeName,
    ),
    TestDemo(
      "朋友圈",
      DemoPyq.routeName,
    ),
    TestDemo(
      "生日修改",
      DemoBriday.routeName,
    ),
    TestDemo(
      "调用三方应用",
      DemoLauncher.routeName,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('测试页面'),
      ),
      body: ListView.separated(
        itemCount: dataList.length,
        separatorBuilder: (BuildContext context, int index) {
          // 构建分割线
          return WidgetCommon.divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 16, right: 8),
            title: Text(
              dataList[index].title,
            ),
            trailing: WidgetCommon.arrow(),
            onTap: () {
              Get.toNamed(dataList[index].path);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class TestDemo {
  final String title;
  final String path;
  TestDemo(this.title, this.path);
}
