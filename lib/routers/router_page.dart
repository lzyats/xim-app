import 'package:get/get.dart';
import 'package:alpaca/routers/router_common.dart';
import 'package:alpaca/routers/router_friend.dart';
import 'package:alpaca/routers/router_group.dart';
import 'package:alpaca/routers/router_login.dart';
import 'package:alpaca/routers/router_main.dart';
import 'package:alpaca/routers/router_mine.dart';
import 'package:alpaca/routers/router_msg.dart';
import 'package:alpaca/routers/router_robot.dart';
import 'package:alpaca/routers/router_wallet.dart';
import 'package:alpaca/routers/router_moment.dart'; // 引入朋友圈路由

List<GetPage> getRouterPage = getMainPages +
    getCommonPages +
    getLoginPages +
    getMinePages +
    getWalletPages +
    getMsgPages +
    getFriendPages +
    getGroupPages +
    getRobotPages +
    getMomentPages; // 添加朋友圈路由
