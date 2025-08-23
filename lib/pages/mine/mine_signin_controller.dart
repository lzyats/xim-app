import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/request/request_mine.dart';

class MineSigninController extends GetxController {
  LocalUser localUsery = ToolsStorage().local();
  LocalConfig localConfig = ToolsStorage().config();
  double sign = 0;
  late final Rx<LocalUser> localUser;
  final usdtBalance = 0.0.obs;
  final isTodaySigned = false.obs;
  // 动态存储当月天数的签到状态
  late final RxList<bool> signInStatus;
  // 存储当月所有日期（东8区）
  late List<DateTime> east8MonthDates;
  // 当前月份信息（用于展示）
  late String currentMonth;

  @override
  void onInit() {
    super.onInit();
    localUser = localUsery.obs;
    sign = localConfig.sign;
    _initData();
  }

  // 初始化数据：基于东8区当月日期
  Future<void> _initData() async {
    // 获取用户信息
    final user = localUsery;
    if (user != null) localUser.value = user;

    // 获取USDT余额
    usdtBalance.value = 0.00;

    // 生成东8区当月所有日期
    final east8Now = DateTime.now().toUtc().add(const Duration(hours: 8));
    final currentYear = east8Now.year;
    final currentMonthNum = east8Now.month;

    // 设置当前月份显示（例如：2023年10月）
    currentMonth = DateFormat('yyyy年MM月').format(east8Now);

    // 获取当月第一天
    final firstDay = DateTime(currentYear, currentMonthNum, 1);
    // 获取当月最后一天（下个月第一天减一天）
    final lastDay = DateTime(currentYear, currentMonthNum + 1, 0);
    // 计算当月总天数
    final daysInMonth = lastDay.day;

    // 生成当月所有日期列表
    east8MonthDates = List.generate(daysInMonth, (i) {
      return DateTime(currentYear, currentMonthNum, i + 1);
    });

    // 初始化签到状态列表（与当月天数一致）
    signInStatus = List<bool>.filled(daysInMonth, false).obs;

    // 加载签到信息
    await _fetchSignInfo();

    // 加载本地签到状态
    //await _loadSignInStatus();

    // 更新今日签到状态
    final todayIndex = east8MonthDates.indexWhere((date) =>
        DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(east8Now));
    if (todayIndex != -1) {
      isTodaySigned.value = signInStatus[todayIndex];
    }
  }

  // 获取签到信息接口调用
  Future<void> _fetchSignInfo() async {
    try {
      final Map<String, dynamic>? signInfo = await RequestMine.getSignInfo();
      print(signInfo.toString());
      if (signInfo != null) {
        _handleSignData(signInfo);
      }
    } catch (e) {
      print('获取签到信息失败: $e');
    }
  }

  // 统一处理签到数据
  void _handleSignData(Map<String, dynamic> signData) {
    // 更新USDT余额
    if (signData.containsKey('totalReward')) {
      usdtBalance.value =
          double.tryParse(signData['totalReward'].toString()) ?? 0.0;
    }

    // 解析signDates并更新签到状态列表
    if (signData.containsKey('signDates')) {
      dynamic rawSignDates = signData['signDates'];
      List<dynamic> signedDates = [];

      if (rawSignDates is List) {
        signedDates = rawSignDates;
      } else {
        print('signDates类型异常，预期List，实际为：${rawSignDates.runtimeType}');
      }

      if (signedDates.isNotEmpty) {
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
    for (int i = 0; i < east8MonthDates.length; i++) {
      DateTime date = east8MonthDates[i];
      String dateStr = DateFormat('yyyy-MM-dd').format(date);
      signInStatus[i] = signedDates.contains(dateStr);
    }
    // 更新今天是否已签到状态（找到今天在列表中的索引）
    final todayIndex = east8MonthDates.indexWhere((date) =>
        DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd')
            .format(DateTime.now().toUtc().add(const Duration(hours: 8))));
    if (todayIndex != -1) {
      isTodaySigned.value = signInStatus[todayIndex];
    }
  }

  // 加载当月签到状态（从本地存储读取）
  Future<void> _loadSignInStatus() async {
    for (int i = 0; i < east8MonthDates.length; i++) {
      final date = east8MonthDates[i];
      final dateKey = DateFormat('yyyy-MM-dd').format(date);
      final isSigned =
          await ToolsStorage().signInStatus(dateKey: dateKey) ?? false;
      signInStatus[i] = isSigned;
    }
  }

  // 东8区今日签到逻辑
  void signInToday() async {
    if (isTodaySigned.value) return;

    final east8Now = DateTime.now().toUtc().add(const Duration(hours: 8));
    final todayIndex = east8MonthDates.indexWhere((date) =>
        DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(east8Now));

    if (todayIndex == -1) {
      print('今日不在当月日期列表中');
      return;
    }

    // 更新今日签到状态
    signInStatus[todayIndex] = true;
    isTodaySigned.value = true;

    // 调用签到接口
    Map<String, dynamic>? signInfo = await RequestMine.sign();
    if (signInfo != null) {
      _handleSignData(signInfo);
    }

    // 保存今日签到状态到本地
    final todayKey = DateFormat('yyyy-MM-dd').format(east8Now);
    await ToolsStorage().signInStatus(dateKey: todayKey, value: true);

    String signstr = sign.toString();
    Get.showSnackbar(GetSnackBar(
      message: '今日签到成功，获得$signstr USDT',
      duration: Duration(seconds: 2),
    ));
  }
}
