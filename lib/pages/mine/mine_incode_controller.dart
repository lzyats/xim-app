import 'dart:async';

import 'package:alpaca/request/request_mine.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_timer.dart';

class MineIncodeController extends BaseController {
  LocalUser localUser = ToolsStorage().local();
  LocalConfig config = ToolsStorage().config();
}
