import 'package:flutter/material.dart';
import 'package:alpaca/config/app_config.dart';
import 'dart:io';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/tools/tools_perms.dart';

// 九宫格图片
class WidgetGrid extends StatefulWidget {
  final double spacing; // 图片间距
  final double ratio; // 宽高比
  final double? height; // 高度限制
  final int length; // 最大数量
  final Function(List<String>)? onChange; // 图片列表变化回调

  const WidgetGrid({
    super.key,
    this.spacing = 8.0,
    this.ratio = 1.0,
    this.height,
    this.length = 9,
    this.onChange,
  });

  @override
  createState() => _WidgetGridState();
}

class _WidgetGridState extends State<WidgetGrid> {
  final List<String> _images = [];

  // 选择图片
  Future<void> _pickImage() async {
    // 检查权限
    bool result = await ToolsPerms.photos();
    if (!result) return;

    // 选择图片
    // 计算剩余可选图片数量
    final int remainingSlots = widget.length - _images.length;
    if (remainingSlots <= 0) return;

    // 本次可选择的最大数量是剩余数量和单次限制中的较小值
    final int currentPickLimit =
        remainingSlots < widget.length ? remainingSlots : widget.length;

    final List<AssetEntity>? assetEntity = await AssetPicker.pickAssets(
      AppConfig.navigatorKey.currentContext!,
      pickerConfig: AssetPickerConfig(
        maxAssets: currentPickLimit,
        requestType: RequestType.image,
        pathNameBuilder: (AssetPathEntity path) {
          return WidgetCommon.pathName(path);
        },
      ),
    );

    if (assetEntity != null && assetEntity.isNotEmpty) {
      // 处理所有选中的图片
      for (var asset in assetEntity) {
        final File? file = await asset.file;
        if (file != null) {
          setState(() {
            _images.add(file.path);
          });
        }
      }
      // 回调通知图片列表变化
      widget.onChange?.call(_images);
    }
  }

  // 删除图片
  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
      widget.onChange?.call(_images);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 计算每行显示的图片数量
    int itemCount =
        _images.length < widget.length ? _images.length + 1 : _images.length;
    int crossAxisCount = _calculateCrossAxisCount(itemCount);
    // 计算行数
    int rowCount = (itemCount / crossAxisCount).ceil();
    // 计算网格高度
    _calculateGridHeight(crossAxisCount, rowCount);

    return Container(
      constraints: BoxConstraints(
        maxHeight: widget.height ?? double.infinity,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: widget.spacing,
          crossAxisSpacing: widget.spacing,
          childAspectRatio: widget.ratio,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return _buildImageItem(index);
        },
      ),
    );
  }

  // 构建单个图片项
  Widget _buildImageItem(int index) {
    // 添加图片按钮
    if (index == _images.length && _images.length < widget.length) {
      return GestureDetector(
        onTap: _pickImage,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: const Icon(
            Icons.add_photo_alternate,
            color: Colors.grey,
            size: 40,
          ),
        ),
      );
    }
    // 图片项
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            image: DecorationImage(
              image: FileImage(File(_images[index])) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 删除按钮
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () => _deleteImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 固定每行显示3个图片
  int _calculateCrossAxisCount(int length) {
    return 3;
  }

  // 计算网格总高度
  double _calculateGridHeight(int crossAxisCount, int rowCount) {
    // 假设每个图片项的基础大小为100
    double baseSize = 100.0;
    double totalSpacing = widget.spacing * (rowCount - 1);
    return (baseSize * rowCount) + totalSpacing;
  }
}
