import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineError extends StatelessWidget {
  // 路由地址
  static const String routeName = '/mine_error';
  const MineError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('未知领域'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '天呐!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              '你探索到一个未知的领域',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Get.back(); // 返回上一页
              },
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
