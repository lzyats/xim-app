import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/mine/mine_avatar_controller.dart';

class MineAvatarPage extends GetView<MineAvatarController> {
  static const String routeName = '/mine_avatar';

  const MineAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineAvatarController());

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
              '选择头像',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => controller.confirmSelection(),
                child: const Text(
                  '确定',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Obx(() {
        // 监听加载状态
        if (controller.isLoading.value) {
          // 加载中显示居中的CircularProgressIndicator
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        } else if (controller.avatarList.isEmpty) {
          // 空数据处理（可选）
          return const Center(
            child: Text('暂无头像数据'),
          );
        } else {
          // 数据加载完成，显示网格
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0,
            ),
            itemCount: controller.avatarList.length,
            itemBuilder: (context, index) {
              final avatarUrl = controller.avatarList[index];
              return Obx(() {
                final isSelected = controller.selectedIndex.value == index;
                return GestureDetector(
                  onTap: () => controller.selectAvatar(index),
                  child: Stack(
                    children: [
                      // 步骤3：使用缓存图片组件（带加载中占位）
                      _buildCachedAvatar(avatarUrl),
                      if (isSelected)
                        const Positioned(
                          right: 0,
                          top: 0,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 32,
                          ),
                        ),
                    ],
                  ),
                );
              });
            },
          );
        }
      }),
    );
  }

  // 带缓存、加载状态和圆角的头像组件
  Widget _buildCachedAvatar(String url) {
    return ClipRRect(
      // 设置圆角半径，可根据需要调整数值
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: url,
        // 图片宽高填充父容器
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        // 加载中显示占位图（可自定义）
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
            ),
          ),
        ),
        // 加载失败显示错误占位图
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: const Icon(
            Icons.error_outline,
            color: Colors.grey,
          ),
        ),
        // 缓存配置（可选）
        cacheManager: CacheManager(
          Config(
            'avatar_cache', // 缓存目录名称
            stalePeriod: const Duration(days: 30), // 缓存有效期30天
          ),
        ),
      ),
    );
  }
}
