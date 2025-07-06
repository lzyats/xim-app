import 'package:get/get.dart';
import 'package:alpaca/routers/router_common.dart';
import 'package:alpaca/routers/router_demo.dart';
import 'package:alpaca/routers/router_friend.dart';
import 'package:alpaca/routers/router_group.dart';
import 'package:alpaca/routers/router_login.dart';
import 'package:alpaca/routers/router_main.dart';
import 'package:alpaca/routers/router_mine.dart';
import 'package:alpaca/routers/router_msg.dart';
import 'package:alpaca/routers/router_robot.dart';
import 'package:alpaca/routers/router_wallet.dart';

List<GetPage> getRouterPage = getMainPages +
    getDemoPages +
    getCommonPages +
    getLoginPages +
    getMinePages +
    getWalletPages +
    getMsgPages +
    getFriendPages +
    getGroupPages +
    getRobotPages;
