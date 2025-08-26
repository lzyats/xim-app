import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alpaca/pages/mine/mine_signin_controller.dart';
import 'package:alpaca/pages/mine/mine_signlist_page.dart';

class MineSigninPage extends GetView<MineSigninController> {
  static const String routeName = '/mine_signin';
  const MineSigninPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MineSigninController());
    double sign = controller.sign;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(controller.localUser.value!.portrait),
            _buildSignPrompt(sign),
            _buildSignGrid(sign),
            _buildRules(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String imav) {
    return Obx(() {
      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0099FF), Color(0xFF66CCFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(imav),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '签到累计获得',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      controller.usdtBalance.toStringAsFixed(0) +
                          " ${controller.localConfig.cashname}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(MineSignlistPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('签到记录'),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSignPrompt(double sign) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '每日签到获取$sign ${controller.localConfig.cashname}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '连续签到可获到额外奖励',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.isTodaySigned.value
                  ? null
                  : controller.signInToday,
              style: ElevatedButton.styleFrom(
                backgroundColor: controller.isTodaySigned.value
                    ? Colors.grey[300]
                    : Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(controller.isTodaySigned.value ? '已签到' : '立即签到'),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSignGrid(double sign) {
    return Obx(() {
      // 获取当前东八区时间
      final east8Now = DateTime.now().toUtc().add(const Duration(hours: 8));
      // 获取当月第一天
      final firstDayOfMonth = DateTime(east8Now.year, east8Now.month, 1);
      // 获取当月最后一天
      final lastDayOfMonth = DateTime(east8Now.year, east8Now.month + 1, 0);
      // 计算当月总天数
      final daysInMonth = lastDayOfMonth.day;

      // 生成当月所有日期
      final dates = List.generate(daysInMonth, (i) {
        return DateTime(east8Now.year, east8Now.month, i + 1);
      });

      // 计算当月第一天是星期几（1-7，对应周一到周日）
      int firstDayWeekday = firstDayOfMonth.weekday;

      // 计算需要的前置空白格子数量（使第一天对齐正确的星期位置）
      final leadingEmptyCount = firstDayWeekday - 1;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${DateFormat('yyyy年MM月').format(firstDayOfMonth)} 签到',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('一', style: TextStyle(color: Colors.grey)),
                Text('二', style: TextStyle(color: Colors.grey)),
                Text('三', style: TextStyle(color: Colors.grey)),
                Text('四', style: TextStyle(color: Colors.grey)),
                Text('五', style: TextStyle(color: Colors.grey)),
                Text('六', style: TextStyle(color: Colors.grey)),
                Text('日', style: TextStyle(color: Colors.grey)),
              ],
            ),
            GridView.count(
              crossAxisCount: 7, // 保持7列（一周）
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 0.68,
              padding: const EdgeInsets.symmetric(vertical: 4),
              // 生成日历格子（前置空白格子 + 当月日期）
              children: [
                // 添加前置空白格子（用于对齐星期几）
                ...List.generate(leadingEmptyCount, (index) {
                  return Container(); // 空白格子
                }),
                // 当月日期格子
                ...List.generate(daysInMonth, (index) {
                  final date = dates[index];
                  final isSigned = controller.signInStatus[index];
                  final isToday = date.year == east8Now.year &&
                      date.month == east8Now.month &&
                      date.day == east8Now.day;

                  // 新增：判断当前日期是否为未来日期（大于今天）
                  final isFuture = date.isAfter(east8Now);

                  return Container(
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: isSigned
                          ? Colors.orange.shade200
                          : isToday
                              ? Colors.blue.shade50
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: isToday && !isSigned
                          ? Border.all(color: Colors.blue, width: 1.5)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 奖励金额框
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: isSigned
                                ? const Color(0xFFFF7D3F)
                                : const Color(0xFFE7E7E7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              controller.dailyRewards[index] > 0
                                  ? controller.dailyRewards[index].toString()
                                  : isToday
                                      ? (sign + controller.reward.value)
                                          .toStringAsFixed(2)
                                      : isFuture
                                          ? "?"
                                          : sign.toString(),
                              style: TextStyle(
                                color: isSigned
                                    ? Colors.white
                                    : isFuture
                                        ? Colors.blue
                                        : Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // 日期显示
                        Text(
                          isToday ? '今日' : '${date.day}',
                          style: TextStyle(
                            color: isSigned
                                ? Colors.orange
                                : isToday
                                    ? Colors.blue
                                    : Colors.grey,
                            fontSize: 12,
                            fontWeight:
                                isToday ? FontWeight.w700 : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // 已签到勾
                        if (isSigned)
                          const Icon(
                            Icons.check,
                            color: Color(0xFFFF9014),
                            size: 12,
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRules() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '签到规则',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRuleItem('请不要在每日23点30分以后签到，漏签不可以进行补签'),
              _buildRuleItem(
                  '第1天 0.1元,第2天 0.15元,第3天 0.2元,第4天 0.25元,第5天 0.3元,第6天 0.35元元,第7天及以上 0.45元,中断后签到从第1天开始重新计算'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRuleItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(color: Colors.blue)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
