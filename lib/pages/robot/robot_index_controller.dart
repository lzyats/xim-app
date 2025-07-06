import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_robot.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_contact.dart';

class RobotIndexController extends BaseController {
  // 联系人列表
  List<ContactModel> dataList = [];
  // 群组数量
  RxInt groupCount = 0.obs;
  // 刷新
  _onRefresh() async {
    // 执行
    List<ChatRobot> robotList = await ToolsSqlite().robot.getList();
    dataList.clear();
    // 转换
    if (robotList.isNotEmpty) {
      for (var robot in robotList) {
        dataList.add(
          ContactModel(
            userId: robot.robotId,
            nickname: robot.nickname,
            portrait: robot.portrait,
          ),
        );
      }
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // 刷新服务号
    _onRefresh();
    // 监听服务号
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.robot != model.setting) {
        return;
      }
      // 刷新服务号
      _onRefresh();
    });
    // 服务列表
    RequestRobot.getRobotList();
  }
}
