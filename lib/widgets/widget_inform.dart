import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 举报组件
class WidgetInform extends StatefulWidget {
  final Function(String value) onChange;

  const WidgetInform({
    super.key,
    required this.onChange,
  });

  @override
  createState() => _WidgetInformState();
}

class _WidgetInformState extends State<WidgetInform> {
  _InformType informType = _InformType.one;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "举报类型：",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        InkWell(
          onTap: () {
            Pickers.showSinglePicker(
              pickerStyle: WidgetCommon.pickerStyle(),
              context,
              data: _informTypeList(),
              selectData: informType.label,
              onConfirm: (label, position) {
                informType = _InformType.init(label);
                widget.onChange(informType.value);
                setState(() {});
              },
            );
          },
          child: _showResult(
            informType.label,
          ),
        ),
      ],
    );
  }

  // 显示结果
  static _showResult(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
          size: 16,
        ),
      ],
    );
  }

  // 举报类型
  static _informTypeList() {
    List<_InformType> typeList = _InformType.values;
    List<String> dataList = [];
    for (var element in typeList) {
      dataList.add(element.label);
    }
    return dataList;
  }
}

// 举报枚举
enum _InformType {
  one('1', '涉及诽谤/辱骂/威胁/挑衅'),
  two('2', '涉嫌广告推销'),
  three('3', '涉嫌色情暴力'),
  four('4', '涉嫌反动/诈骗/谣言'),
  five('5', '涉及散布隐私'),
  six('6', '其他违规行为'),
  ;

  const _InformType(this.value, this.label);
  final String value;
  final String label;

  static _InformType init(String label) {
    return _InformType.values
        .firstWhere((e) => e.label == label, orElse: () => _InformType.one);
  }
}
