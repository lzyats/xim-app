import 'package:barcode_scan2/model/scan_options.dart';
import 'package:barcode_scan2/model/scan_result.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/friend/friend_details_page.dart';
import 'package:alpaca/pages/group/group_scan_page.dart';
import 'package:alpaca/pages/login/login_scan_page.dart';
import 'package:alpaca/pages/wallet/wallet_transfer_page.dart';
import 'package:alpaca/request/request_friend.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

// 扫一扫
class ToolsScan {
  // 扫码
  static Future<void> scan() async {
    // 现在时间
    final currentTime = DateTime.now().hour;
    // 控制灯光
    bool light = currentTime < 07 || currentTime > 20;
    // ScanOptions设置闪光灯和前后摄像头
    var options = ScanOptions(autoEnableFlash: light, strings: {
      'cancel': '关闭',
      'flash_on': '打开灯光',
      'flash_off': '关闭灯光',
    });
    // 返回扫描的参数
    ScanResult scanResult = await BarcodeScanner.scan(options: options);
    // 返回参数
    String result = scanResult.rawContent;
    // 执行扫码
    doScan(result);
  }

  // 扫码
  static Future<void> doScan(String result) async {
    // 返回参数
    if (result.startsWith('group:')) {
      _buildGroup(result);
    }
    // 跳转到好友
    else if (result.startsWith('friend:')) {
      _buildFriend(result);
    }
    // 跳转到转账
    else if (result.startsWith('wallet:')) {
      _buildWallet(result);
    }
    // 跳转到扫码
    else if (result.startsWith('scan:')) {
      _buildScan(result);
    }
    // 跳转到默认
    else if (result.isNotEmpty) {
      _buildOther(result);
    }
  }

  static _buildGroup(String result) async {
    String groupId = result.replaceFirst('group:', '');
    ToolsSubmit.show();
    GroupModel03? model = await RequestGroup.scan(groupId);
    ToolsSubmit.dismiss();
    // 判断
    if (model == null) {
      _buildOther(result);
      return;
    }
    // 成员，则去聊天
    if (model.isMember) {
      ToolsRoute().chatPage(
        chatId: model.groupId,
        nickname: model.groupName,
        portrait: model.portrait,
        chatTalk: ChatTalk.group,
      );
    }
    // 非成员，则去申请
    else {
      Get.toNamed(GroupScanPage.routeName, arguments: model);
    }
  }

  static _buildFriend(String result) async {
    String userId = result.replaceFirst('friend:', '');
    ToolsSubmit.show();
    ChatFriend? model = await RequestFriend.getInfo(userId);
    // 取消
    ToolsSubmit.dismiss();
    // 判断
    if (model == null) {
      _buildOther(result);
      return;
    }
    // 好友
    if (FriendType.other != model.friendType) {
      ToolsRoute().chatPage(
        chatId: model.userId,
        nickname: model.nickname,
        portrait: model.portrait,
        remark: model.remark,
        chatTalk: ChatTalk.friend,
      );
    }
    // 非好友，则去申请
    else {
      Get.toNamed(FriendDetailsPage.routeName, arguments: {
        'userId': model.userId,
        'source': FriendSource.scan,
      });
    }
  }

  static _buildWallet(String result) async {
    String userId = result.replaceFirst('wallet:', '');
    ToolsSubmit.show();
    ChatFriend? model = await RequestFriend.getInfo(userId);
    // 取消
    ToolsSubmit.dismiss();
    // 判断
    if (model == null) {
      _buildOther(result);
      return;
    }
    Get.toNamed(WalletTransferPage.routeName, arguments: model);
  }

  static _buildScan(String result) async {
    String token = result.replaceFirst('scan:', '');
    Get.toNamed(LoginScanPage.routeName, arguments: token);
  }

  static _buildOther(String result) {
    Get.to(_WidgetScan(result));
  }
}

// 扫码页面
class _WidgetScan extends StatelessWidget {
  final String result;
  const _WidgetScan(this.result);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('扫一扫'),
      ),
      body: Center(
        child: InkWell(
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: result));
            EasyLoading.showToast('文本已复制');
          },
          child: Text(result),
        ),
      ),
    );
  }
}
