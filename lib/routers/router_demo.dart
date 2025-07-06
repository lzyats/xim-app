import 'package:get/get.dart';
import 'package:alpaca/pages/_demo/demo_01.dart';
import 'package:alpaca/pages/_demo/demo_02.dart';
import 'package:alpaca/pages/_demo/demo_03.dart';
import 'package:alpaca/pages/_demo/demo_sqflite.dart';
import 'package:alpaca/pages/_demo/demo_huadong.dart';
import 'package:alpaca/pages/_demo/demo_bank.dart';
import 'package:alpaca/pages/_demo/_demo_test.dart';
import 'package:alpaca/pages/_demo/demo_pyq.dart';
import 'package:alpaca/pages/_demo/demo_briday.dart';
import 'package:alpaca/pages/_demo/demo_launcher.dart';
import 'package:alpaca/routers/router_base.dart';

// 主路由
List<GetPage> getDemoPages = [
  getPage(
    name: Demo01.routeName,
    page: () => const Demo01(),
  ),
  getPage(
    name: Demo02.routeName,
    page: () => const Demo02(),
  ),
  getPage(
    name: Demo03.routeName,
    page: () => const Demo03(),
  ),
  getPage(
    name: DemoTest.routeName,
    page: () => const DemoTest(),
  ),
  getPage(
    name: DemoBank.routeName,
    page: () => const DemoBank(),
  ),
  getPage(
    name: DemoPyq.routeName,
    page: () => const DemoPyq(),
  ),
  getPage(
    name: DemoBriday.routeName,
    page: () => const DemoBriday(),
  ),
  getPage(
    name: DemoHuadong.routeName,
    page: () => const DemoHuadong(),
  ),
  getPage(
    name: DemoLauncher.routeName,
    page: () => const DemoLauncher(),
  ),
  getPage(
    name: DemoSqflite.routeName,
    page: () => const DemoSqflite(),
  ),
];
