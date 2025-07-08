import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_add_controller.dart';
import 'package:alpaca/widgets/widget_amap.dart';

class LocationPickerWidget extends StatelessWidget {
  final String currentLocation;
  final Function(String) onLocationSelected;

  LocationPickerWidget({
    required this.currentLocation,
    required this.onLocationSelected,
  });

  final MomentAddController _controller = Get.find<MomentAddController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickLocation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.blue,
            ),
            const SizedBox(width: 8.0),
            Text(
              currentLocation.isEmpty ? '所在位置' : currentLocation,
              style: TextStyle(
                color: currentLocation.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickLocation() async {
    try {
      // 这里可以打开高德地图定位界面
      // 实际实现中需要使用高德地图SDK
      // 这里仅作示例，使用当前位置或模拟位置

      /* final location = await LocationService.pickLocation();
      if (location.isNotEmpty) {
        onLocationSelected(location);
      } */
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: '错误',
          message: '获取位置失败，请重试',
          duration: Duration(seconds: 2),
        ),
      );
      print('获取位置失败: $e');
    }
  }
}
