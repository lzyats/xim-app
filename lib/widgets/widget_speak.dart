import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 禁言组件
class WidgetSpeak extends StatefulWidget {
  final String? speakType;
  final Function(String value) onChange;

  const WidgetSpeak({
    super.key,
    required this.onChange,
    this.speakType,
  });

  @override
  createState() => _WidgetSpeakState();
}

class _WidgetSpeakState extends State<WidgetSpeak> {
  _SpeakType speakType = _SpeakType.one;
  @override
  void initState() {
    if (widget.speakType != null) {
      speakType = _SpeakType.init(widget.speakType!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "禁言时间：",
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
              selectData: speakType.label,
              onConfirm: (label, position) {
                speakType = _SpeakType.init(label);
                widget.onChange(speakType.value);
                setState(() {});
              },
            );
          },
          child: _showResult(
            speakType.label,
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
    List<_SpeakType> typeList = _SpeakType.values;
    List<String> dataList = [];
    for (var element in typeList) {
      dataList.add(element.label);
    }
    return dataList;
  }
}

// 举报枚举
enum _SpeakType {
  one('1', '1小时'),
  two('2', '1天'),
  three('3', '1周'),
  four('4', '1月'),
  five('5', '1年'),
  six('6', '永久'),
  ;

  const _SpeakType(this.value, this.label);
  final String value;
  final String label;

  static _SpeakType init(String label) {
    return _SpeakType.values
        .firstWhere((e) => e.label == label, orElse: () => _SpeakType.one);
  }
}
