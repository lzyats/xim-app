import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/request/request_mine.dart';

class MineSigninController extends GetxController {
  LocalUser? localUsery = ToolsStorage().local();
  LocalConfig localConfig = ToolsStorage().config();
  double sign = 0;
  late final Rx<LocalUser?> localUser;
  final usdtBalance = 0.0.obs;
  final isTodaySigned = false.obs;
  // 动态存储当月天数的签到状态
  late final RxList<bool> signInStatus;
  // 存储每日签到奖励金额
  late final RxList<double> dailyRewards;
  // 当日签到奖励
  late final RxDouble reward = 0.0.obs;
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

    // 初始化签到状态列表和奖励列表（与当月天数一致）
    signInStatus = List<bool>.filled(daysInMonth, false).obs;
    dailyRewards = List<double>.filled(daysInMonth, 0.0).obs;

    // 加载签到信息
    await _fetchSignInfo();

    // 更新今日签到状态
    final todayIndex = east8MonthDates.indexWhere((date) =>
        DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(east8Now));
    if (todayIndex != -1) {
      isTodaySigned.value = signInStatus[todayIndex];
    }
  }

  // 获取签到信息接口调用
  // 获取签到信息接口调用
  Future<void> _fetchSignInfo() async {
    try {
      // 接口实际返回 Map<String, dynamic> 类型，正确接收
      final Map<String, dynamic>? signInfoMap = await RequestMine.getSignInfo();
      debugPrint(signInfoMap.toString());

      if (signInfoMap != null) {
        // 从地图中提取签到列表（假设列表对应 key 为 'signList'，根据实际接口字段修改）
        final List<dynamic> signDataList =
            signInfoMap['signDates'] as List<dynamic>? ?? [];
        // 修复 reward.value 的赋值
        reward.value =
            double.tryParse(signInfoMap['reward']?.toString() ?? '0') ?? 0.0;
        _handleSignData(signDataList);
      }
    } catch (e) {
      debugPrint('获取签到信息失败: $e');
    }
  }

  // 统一处理签到数据（新格式：列表）
  void _handleSignData(List<dynamic> signDataList) {
    // 计算总奖励金额
    double totalReward = 0.0;

    // 遍历所有签到记录
    for (var item in signDataList) {
      if (item is Map<String, dynamic>) {
        final signDate = item['signDate']?.toString() ?? '';
        final rewardAmount =
            double.tryParse(item['rewardAmount']?.toString() ?? '0') ?? 0.0;

        // 累加总奖励
        totalReward += rewardAmount;

        // 更新对应日期的签到状态和奖励金额
        _updateSingleDateStatus(signDate, rewardAmount);
      }
    }

    // 更新总USDT余额
    usdtBalance.value = totalReward;
  }

  // 更新单个日期的签到状态和奖励金额
  void _updateSingleDateStatus(String signDate, double rewardAmount) {
    for (int i = 0; i < east8MonthDates.length; i++) {
      final dateStr = DateFormat('yyyy-MM-dd').format(east8MonthDates[i]);
      if (dateStr == signDate) {
        signInStatus[i] = true;
        dailyRewards[i] = rewardAmount;
        break;
      }
    }

    // 更新今天是否已签到状态
    final east8Now = DateTime.now().toUtc().add(const Duration(hours: 8));
    final todayIndex = east8MonthDates.indexWhere((date) =>
        DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(east8Now));
    if (todayIndex != -1) {
      isTodaySigned.value = signInStatus[todayIndex];
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
      debugPrint('今日不在当月日期列表中');
      return;
    }

    // 调用签到接口
    Map<String, dynamic>? signResult = await RequestMine.sign();
    if (signResult != null) {
      // 假设签到接口返回当前签到记录：{signDate: "2025-08-07", rewardAmount: 3.0}
      final signDate = signResult['signDate']?.toString() ?? '';
      final rewardAmount =
          double.tryParse(signResult['rewardAmount']?.toString() ?? '0') ?? 0.0;

      // 更新今日签到状态和奖励
      signInStatus[todayIndex] = true;
      dailyRewards[todayIndex] = rewardAmount;
      isTodaySigned.value = true;

      // 重新计算总奖励
      usdtBalance.value += rewardAmount;

      // 保存今日签到状态到本地
      final todayKey = DateFormat('yyyy-MM-dd').format(east8Now);
      await ToolsStorage().signInStatus(dateKey: todayKey, value: true);

      Get.showSnackbar(GetSnackBar(
        message: '今日签到成功',
        duration: const Duration(seconds: 2),
      ));
    }
  }
}
