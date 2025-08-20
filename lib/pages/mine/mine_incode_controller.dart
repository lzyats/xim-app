import 'package:alpaca/tools/tools_storage.dart';

import 'package:alpaca/pages/base/base_controller.dart';

class MineIncodeController extends BaseController {
  LocalUser localUser = ToolsStorage().local();
  LocalConfig config = ToolsStorage().config();
}
