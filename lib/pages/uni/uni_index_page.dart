import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/uni/uni_index_controller.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:alpaca/request/request_uni.dart';
import 'package:alpaca/tools/tools_uni.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 小程序页面
class UniIndexPage extends GetView<UniIndexController> {
  const UniIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<UniIndexController>(() => UniIndexController());
    double width = MediaQuery.of(context).size.width * 0.8 / 3;
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 40.0,
              color: Colors.grey[100],
              margin: const EdgeInsets.only(top: 10.0),
              padding: const EdgeInsets.only(left: 15.0, top: 10.0),
              child: const Text('应用扩展'),
            ),
            GetBuilder<UniIndexController>(builder: (builder) {
              if (controller.refreshList.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: WidgetCommon.none(),
                );
              }
              return Wrap(
                alignment: WrapAlignment.start,
                children: [
                  ...List.generate(
                    controller.refreshList.length,
                    (index) {
                      return _buildItem(
                        controller.refreshList[index],
                        width: width,
                      );
                    },
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  _buildItem(
    MiniModel01 model, {
    required double width,
  }) {
    String name = model.name;
    String icon = model.icon;
    return InkWell(
      onTap: () async {
        String type = model.type;
        String path = model.path;
        // 跳转网站
        if ('url' == type) {
          Get.toNamed(
            ViewPage.routeName,
            arguments: ViewData(
              title: name,
              path,
            ),
          );
        }
        // 跳转小程序
        else {
          if (ToolsSubmit.progress()) {
            return;
          }
          if (ToolsSubmit.call()) {
            ToolsUni().open(
              appId: model.appId,
              version: model.version,
              path: path,
            );
          }
        }
      },
      child: SizedBox(
        width: width,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WidgetCommon.showAvatar(icon, size: 40),
            Text(name),
          ],
        ),
      ),
    );
  }
}
