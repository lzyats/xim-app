// 好友接口

import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';

class RequestRobot {
  static String get _prefix => '/robot';

  // 服务列表
  static Future<List<ChatRobot>> getRobotList() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getRobotList',
      showError: false,
    );
    // 转换
    List<ChatRobot> dataList = ajaxData.getList((data) {
      ChatRobot robot = ChatRobot.fromJson(data);
      ToolsStorage().top(robot.robotId, value: robot.top);
      ToolsStorage().disturb(robot.robotId, value: robot.disturb);
      return robot;
    });
    // 存储
    await ToolsSqlite().robot.addBatch(dataList);
    // 通知
    EventSetting().event.add(SettingModel(SettingType.robot));
    return dataList;
  }

  // 服务置顶
  static Future<void> setTop(String robotId, String top) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setTop',
      data: {
        "robotId": robotId,
        "top": top,
      },
    );
    ToolsStorage().top(robotId, value: top);
  }

  // 服务静默
  static Future<void> setDisturb(String robotId, String disturb) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/setDisturb',
      data: {
        "robotId": robotId,
        "disturb": disturb,
      },
    );
    ToolsStorage().disturb(robotId, value: disturb);
  }
}
