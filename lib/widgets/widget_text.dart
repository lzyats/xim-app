import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/tools/tools_enum.dart';

// 文本组件
class WidgetText extends StatelessWidget {
  const WidgetText({super.key});

  @override
  Widget build(BuildContext context) {
    String data = Get.arguments;
    // 选中文本
    var text = '';
    return GestureDetector(
      onTap: () {
        // 返回
        Get.back();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SelectionArea(
                child: GestureDetector(
                  onTap: () {
                    // 返回
                    Get.back();
                  },
                  child: Text(
                    data,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
                onSelectionChanged: (SelectedContent? selectContent) {
                  text = selectContent?.plainText ?? '';
                },
                contextMenuBuilder: (context, selectableRegionState) {
                  final List<ContextMenuButtonItem> buttonItems = [
                    ContextMenuButtonItem(
                      label: '复制',
                      onPressed: () {
                        if (text.isNotEmpty) {
                          Clipboard.setData(ClipboardData(text: text));
                          EasyLoading.showToast('复制成功');
                        }
                      },
                    ),
                    ContextMenuButtonItem(
                      label: '全选',
                      onPressed: () {
                        selectableRegionState.selectAll(
                          SelectionChangedCause.toolbar,
                        );
                      },
                    ),
                    ContextMenuButtonItem(
                      label: '转发',
                      onPressed: () async {
                        if (text.isNotEmpty) {
                          // 转发
                          dynamic result = await Get.toNamed(
                            MsgForwardPage.routeName,
                            arguments: [
                              ForwardModel(MsgType.text, {'data': text.trim()}),
                            ],
                          );
                          if (result != null) {
                            Get.back();
                          }
                        }
                      },
                    ),
                  ];
                  return AdaptiveTextSelectionToolbar.buttonItems(
                    buttonItems: buttonItems,
                    anchors: selectableRegionState.contextMenuAnchors,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
