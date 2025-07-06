import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupTradeController extends BaseController {
  late String groupId;

  // 下拉刷新
  void onRefresh() {
    superRefresh(
      RequestWallet.getGroupPacket(groupId, refreshPageIndex),
    );
  }

  // 领取
  Future<void> receive(String tradeId) async {
    // 接收
    String amount = await RequestWallet.doReceive(tradeId);
    // 刷新
    onRefresh();
    // 查询
    ChatHis? chatHis = await ToolsSqlite().his.getById(tradeId);
    if (chatHis != null) {
      // 更新
      chatHis.content['amount'] = amount;
      await ToolsSqlite().his.add(chatHis);
      // 广播消息
      EventMessage().listenHis.add(chatHis);
    }
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    if (double.parse(amount) < 0.01) {
      EasyLoading.showToast('领取失败');
    } else {
      EasyLoading.showToast('成功领取了$amount');
    }
  }

  // 上滑加载
  void onLoading() {
    superLoading(
      RequestWallet.getGroupPacket(groupId, refreshPageIndex + 1),
    );
  }

  @override
  void onInit() {
    super.onInit();
    groupId = Get.arguments;
    onRefresh();
  }
}
