import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:alpaca/pages/mine/mine_signin_controller.dart';
import 'package:alpaca/pages/mine/mine_signlist_page.dart';
import 'package:alpaca/tools/tools_storage.dart';

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
            _buildHeader(controller.localUser.value.portrait),
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
      final east8Today = DateTime.now().toUtc().add(const Duration(hours: 8));
      // 生成21天的日期（从今天往前推20天到今天，共21天）
      final dates = List.generate(21, (i) {
        return DateTime(
          east8Today.year,
          east8Today.month,
          east8Today.day - (20 - i), // 21天对应索引0-20，i=20时为今天
        );
      });

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  // 显示21天的日期范围
                  '${DateFormat('yyyy年MM月dd日').format(dates.first)} - ${DateFormat('MM月dd日').format(dates.last)} 签到',
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
              childAspectRatio: 0.65,
              padding: const EdgeInsets.symmetric(vertical: 4),
              // 生成21个格子（对应21天）
              children: List.generate(21, (index) {
                final date = dates[index];
                final isSigned = controller
                    .signInStatus[index]; // 需确保控制器中signInStatus长度对应21天
                final isToday = index == 20; // 21天中最后一天（索引20）为今天

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
                      // +2框
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: isSigned
                              ? const Color(0xFFFF7D3F)
                              : const Color(0xFFE7E7E7),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '+${sign.round()}',
                            style: TextStyle(
                              color: isSigned ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 4),

                      // 日期或“今天”标签
                      if (!isToday)
                        Text(
                          '${date.month}-${date.day}',
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
                        )
                      else
                        Text(
                          '今天',
                          style: TextStyle(
                            color: isSigned ? Colors.orange : Colors.blue,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
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
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRules() {
    // 外层添加灰色圆角背景框
    return Container(
      margin: const EdgeInsets.all(16), // 与周围元素的间距
      padding: const EdgeInsets.all(16), // 内容与背景框的内边距
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7), // 规则区背景色
        borderRadius: BorderRadius.circular(10), // 圆角，视觉更柔和
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '签到规则',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87, // 标题颜色加深，与背景对比更清晰
            ),
          ),
          const SizedBox(height: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRuleItem('每日签到可获得对应金额奖励'),
              _buildRuleItem('签到获取的奖励符合系统提现要求即可提现'),
              _buildRuleItem(
                  '连续签到30天额外奖励 10 ${controller.localConfig.cashname}'),
              _buildRuleItem('漏签不可以进行补签，签到中断后签到从0开始计算'),
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
