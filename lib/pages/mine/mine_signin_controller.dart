import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/request/request_mine.dart';

class MineSigninController extends GetxController {
  LocalUser localUsery = ToolsStorage().local();
  LocalConfig localConfig = ToolsStorage().config();
  //签到日奖励
  double sign = 0;
  // 用 late 延迟初始化 localUser（避免在声明时依赖未初始化的 localUsery）
  late final Rx<LocalUser> localUser;
  final usdtBalance = 0.0.obs;
  final isTodaySigned = false.obs;
  // 签到状态列表长度改为21（对应21天）
  final signInStatus = List<bool>.filled(21, false).obs;
  // 存储东8区的21天日期（用于校验和存储）
  late List<DateTime> east8Dates;

  @override
  void onInit() {
    super.onInit();
    localUser = localUsery.obs;
    sign = localConfig.sign;
    _initData();
  }

  // 获取签到信息接口调用
  Future<void> _fetchSignInfo() async {
    try {
      // 调用RequestMine.getSignInfo()获取签到信息
      final Map<String, dynamic>? signInfo = await RequestMine.getSignInfo();
      print(signInfo.toString());
      if (signInfo != null) {
        // 调用统一处理方法
        _handleSignData(signInfo);
      }
    } catch (e) {
      // 处理接口调用异常
      print('获取签到信息失败: $e');
    }
  }

  // 统一处理签到数据（核心方法）
  void _handleSignData(Map<String, dynamic> signData) {
    // 1. 更新USDT余额（从totalReward提取）
    if (signData.containsKey('totalReward')) {
      usdtBalance.value =
          double.tryParse(signData['totalReward'].toString()) ?? 0.0;
    }

    // 2. 解析signDates并更新签到状态列表（signInStatus）
    if (signData.containsKey('signDates')) {
      // 关键修改：先判断是否为List类型，否则强制兜底为空列表
      dynamic rawSignDates = signData['signDates'];
      List<dynamic> signedDates = []; // 默认为空列表

      // 类型检查：仅当是List类型时才赋值，否则保持空列表
      if (rawSignDates is List) {
        signedDates = rawSignDates;
      } else {
        // 非List类型的异常情况（如null、字符串、数字等），打印日志便于调试
        print('signDates类型异常，预期List，实际为：${rawSignDates.runtimeType}');
      }

      // 仅当列表非空时才更新签到状态
      if (signedDates.isNotEmpty) {
        final todayKey = DateFormat('yyyy-MM-dd').format(east8Dates[20]);
        print('更新签到信息');
        print(todayKey);
        _updateSignInStatus(signedDates);
      } else {
        print('signDates为空列表或类型异常，不更新签到状态');
      }
    } else {
      print('接口返回不包含signDates字段');
    }
  }

  // 根据已签到日期列表更新signInStatus
  void _updateSignInStatus(List<dynamic> signedDates) {
    // 遍历21天的日期，判断是否在已签到列表中
    for (int i = 0; i < east8Dates.length; i++) {
      DateTime date = east8Dates[i];
      String dateStr = DateFormat('yyyy-MM-dd').format(date);
      //print(dateStr + ' =>' + date.toString());
      // 若当前日期在已签到列表中，则标记为已签到
      signInStatus[i] = signedDates.contains(dateStr);
      //print(signInStatus[i]);
    }
    // 更新"今天是否已签到"状态（21天列表中最后一项为今天）
    isTodaySigned.value = signInStatus[20];
  }

  // 初始化数据：基于东8区时间（调整为21天）
  Future<void> _initData() async {
    // 1. 获取用户信息
    final user = localUsery;
    if (user != null) localUser.value = user;

    // 2. 获取USDT余额
    final balance = 0.00;
    usdtBalance.value = balance ?? 0.0;

    // 3. 生成东8区的21天日期（包含今天）
    final east8Today = DateTime.now().toUtc().add(const Duration(hours: 8));
    east8Dates = List.generate(21, (i) {
      // 生成21天日期
      return DateTime(
        east8Today.year,
        east8Today.month,
        east8Today.day - (20 - i), // 索引0=今天前20天，索引20=今天（共21天）
      );
    });

    //调用获取签到信息接口
    await _fetchSignInfo();

    // 4. 加载这21天的签到状态（基于东8区日期）
    //await _loadSignInStatus();

    // 5. 标记东8区的今天是否已签到（21天中最后一天为索引20）
    isTodaySigned.value = signInStatus[20];
  }

  // 加载东8区21天的签到状态（从本地存储读取）
  Future<void> _loadSignInStatus() async {
    // 循环21天，加载每一天的签到状态
    for (int i = 0; i < 21; i++) {
      final date = east8Dates[i];
      // 用东8区日期的"yyyy-MM-dd"作为存储key（确保唯一）
      final dateKey = DateFormat('yyyy-MM-dd').format(date);
      final isSigned =
          await ToolsStorage().signInStatus(dateKey: dateKey) ?? false;
      signInStatus[i] = isSigned;
    }
  }

  // 东8区今日签到逻辑（适配21天）
  void signInToday() async {
    if (isTodaySigned.value) return; // 防止重复签到

    // 1. 更新东8区今天的签到状态（21天中今天是索引20）
    signInStatus[20] = true;
    isTodaySigned.value = true;

    //调用签到接口
    Map<String, dynamic>? signInfo = await RequestMine.sign();
    if (signInfo != null) {
      // 调用统一处理方法
      _handleSignData(signInfo);
    }

    // 3. 保存东8区今天的签到状态（key为东8区日期，索引20）
    //final todayKey = DateFormat('yyyy-MM-dd').format(east8Dates[20]);
    //await ToolsStorage().signInStatus(dateKey: todayKey, value: true);
    String signstr = sign.toString();
    Get.showSnackbar(GetSnackBar(
      message: '今日签到成功，获得$signstr USDT',
      duration: Duration(seconds: 2),
    ));
  }
}
