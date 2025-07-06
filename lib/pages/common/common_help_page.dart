import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/common/common_help_controller.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 帮助中心
class CommonHelpPage extends GetView<CommonHelpController> {
  // 路由地址
  static const String routeName = '/common_help';
  const CommonHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CommonHelpController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('帮助中心'),
      ),
      body: GetBuilder<CommonHelpController>(
        builder: (builder) {
          if (controller.dataList.isEmpty) {
            return WidgetCommon.loading();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                TDCollapse.accordion(
                  children: List.generate(controller.dataList.length, (index) {
                    CommonModel01 model = controller.dataList[index];
                    return TDCollapsePanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Text('${index + 1}、${model.label}');
                      },
                      body: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(model.value),
                      ),
                      value: '$index',
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
