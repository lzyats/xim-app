import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/pages/mine/mine_inventory_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

// 信息收集清单
class MineInventoryPage extends GetView<MineInventoryController> {
  // 路由地址
  static const String routeName = '/mine_inventory';
  const MineInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineInventoryController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('信息收集清单'),
      ),
      body: Column(
        children: [
          _buildLabel(),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: WidgetCommon.tips('您可以查询${AppConfig.appName}对您的个人信息收集情况'),
    );
  }

  _buildList() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TDCollapse.accordion(
            children: List.generate(controller.headerList.length, (index) {
              return TDCollapsePanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Text(controller.headerList[index]);
                },
                body: _buildItem(index),
                value: '$index',
              );
            }),
          ),
        ],
      ),
    );
  }

  // 详情
  _buildItem(int index) {
    Widget child = Container();
    if (index == 0) {
      child = _build01();
    } else if (index == 1) {
      child = _build02();
    } else if (index == 2) {
      child = _build03();
    }
    return child;
  }

  _build01() {
    return _buildCard(
      '操作系统',
      content: AppConfig.device,
      useTo: '提供统计分析服务改进性能和用户体验，为用户提供更好的服务',
      useDo: '登录账号时',
    );
  }

  _build02() {
    LocalUser localUser = controller.localUser;
    return Column(
      children: [
        _buildCard(
          '昵称',
          content: localUser.nickname,
          useTo: '用户自行完善信息',
          useDo: '修改个人资料时',
        ),
        _buildCard(
          '性别',
          content: localUser.genderLabel,
          useTo: '用户自行完善信息',
          useDo: '修改个人资料时',
        ),
        _buildCard(
          '地区',
          content: localUser.province + localUser.city,
          useTo: '用户自行完善信息',
          useDo: '修改个人资料时',
        ),
        _buildCard(
          '个性签名',
          content: localUser.intro,
          useTo: '用户自行完善信息',
          useDo: '修改个人资料时',
        ),
        _buildCard(
          '手机号码',
          content: localUser.phone,
          useTo: '用于用户唯一性凭证',
          useDo: '用户注册登录时',
        ),
      ],
    );
  }

  _build03() {
    return Column(
      children: [
        _buildCard(
          '位置',
          content:
              '在获取您的授权后，在您使用聊天发送位置信息、发布动态、寻找好友功能时《${AppConfig.appName}》会收集您的地理位置作为信息的一部分',
          useTo: '用于社交功能',
          useDo: '发布动态选择地理位置，进入寻找好友时，聊天发送位置信息时',
        ),
        _buildCard(
          '图片和视频',
          content:
              '在获取您的授权后，在您使用聊天发送图片或视频时《${AppConfig.appName}》会收集您的图片和视频作为信息的一部分',
          useTo: '用于社交功能',
          useDo: '发布附带图片或视频动态时，聊天发送图片或视频信息时',
        ),
      ],
    );
  }

  _buildCard(
    String title, {
    String content = '',
    String useTo = '',
    String useDo = '',
  }) {
    return Card(
      child: Column(
        children: [
          WidgetLineTable(
            '使用类型',
            title,
          ),
          WidgetLineTable(
            '使用内容',
            content,
          ),
          WidgetLineTable(
            '使用目的',
            useTo,
          ),
          WidgetLineTable(
            '使用场景',
            useDo,
          ),
          const WidgetLineTable(
            '使用次数',
            '1次',
          ),
        ],
      ),
    );
  }
}
