import 'package:alpaca/config/app_resource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_gender_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

// 设置性别页面
class MineGenderPage extends GetView<MineGenderController> {
  // 路由地址
  static const String routeName = '/mine_gender';

  const MineGenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化控制器
    Get.lazyPut(() => MineGenderController());

    // 页面首次渲染完成后自动显示弹窗（仅触发一次）
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.hasShownDialog.value) {
        _showGenderBottomSheet(context);
        controller.hasShownDialog.value = true;
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '修改性别',
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(), // 返回上一页
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: []),
      ),
    );
  }

  // 显示性别选择底部弹窗（核心修改）
  void _showGenderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '选择性别',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              // 用 Obx 包裹，监听 controller.gender 变化（若 gender 是响应式变量）
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _GenderOption(
                      imagePath: AppImage.sexm,
                      label: '男',
                      type: "1", // 男对应 type=1
                      currentGender: controller.gender.value, // 传入控制器的 gender 值
                      onSelected: () {
                        if (ToolsSubmit.call()) {
                          controller.submit("1"); // 提交时更新 gender 为"1"
                          Navigator.pop(context);
                          Get.back();
                        }
                      },
                    ),
                    _GenderOption(
                      imagePath: AppImage.sexwm,
                      label: '女',
                      type: "2", // 女对应 type=2
                      currentGender: controller.gender.value, // 传入控制器的 gender 值
                      onSelected: () {
                        if (ToolsSubmit.call()) {
                          controller.submit("2"); // 提交时更新 gender 为"2"
                          Navigator.pop(context);
                          Get.back();
                        }
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(height: 24),
              // 取消按钮
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.back();
                },
                child: const Text(
                  '取消',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

// 性别选项组件（选中时添加阴影和扩散效果）
class _GenderOption extends StatelessWidget {
  final String imagePath;
  final String label;
  final String type; // 自身类型："1"=男，"2"=女
  final String? currentGender; // 控制器中的当前性别值
  final VoidCallback onSelected;

  const _GenderOption({
    required this.imagePath,
    required this.label,
    required this.type,
    required this.currentGender,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    // 判断是否选中
    final isSelected = type == currentGender;

    // 选中/未选中时的阴影配置
    final List<BoxShadow> selectedShadows = [
      BoxShadow(
        color: Colors.red.withOpacity(0.3), // 红色阴影（与边框呼应）
        blurRadius: 12, // 更大的模糊半径（扩散感）
        spreadRadius: 2, // 扩散效果（阴影向外扩展）
        offset: const Offset(0, 4), // 向下偏移，增强立体感
      )
    ];

    final List<BoxShadow> unselectedShadows = [
      BoxShadow(
        color: Colors.black12, // 淡黑色阴影
        blurRadius: 4, // 小模糊半径
        spreadRadius: 0, // 无扩散
        offset: const Offset(0, 2), // 轻微向下偏移
      )
    ];

    return Column(
      children: [
        // 圆形头像（选中时带阴影和扩散效果）
        InkWell(
          onTap: onSelected,
          borderRadius: BorderRadius.circular(40),
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // 选中时红色边框，未选中时灰色边框
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey[200]!,
                width: isSelected ? 2.5 : 2,
              ),
              // 根据选中状态切换阴影效果
              boxShadow: isSelected ? selectedShadows : unselectedShadows,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 性别标签（选中时样式强化）
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.red : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
