import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/wallet/wallet_card_controller.dart';
import 'package:alpaca/request/request_wallet.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';

// 钱包卡包
class WalletCardPage extends GetView<WalletCardController> {
  // 路由地址
  static const String routeName = '/wallet_card';
  const WalletCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletCardController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              '钱包管理',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                label: '添加',
                onTap: () {
                  Get.to(const WalletCardItemPage());
                },
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<WalletCardController>(
        builder: (builder) {
          return Column(
            children: [
              Expanded(
                child: _buildWalletCardSection(context),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          );
        },
      ),
    );
  }

  // 与_buildWallet保持一致的ListView.separated模式
  Widget _buildWalletCardSection(BuildContext context) {
    // 空状态判断（与_buildWallet逻辑一致）
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }

    // 使用ListView.separated展示内容（结构与_buildWallet完全一致）
    return ListView.separated(
      // 禁用列表滚动（避免与父级滚动冲突，根据实际场景调整）
      physics: const NeverScrollableScrollPhysics(),
      // 自适应内容高度（避免无限高度问题）
      shrinkWrap: true,
      //  itemCount与_buildWallet保持一致（列表长度+1）
      itemCount: controller.refreshList.length + 1,
      // 分隔线与_buildWallet保持一致
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      // 列表项构建（核心修改：返回Column卡片结构，替代ListTile）
      itemBuilder: (ctx, index) {
        // 最后一项返回空容器（与_buildWallet逻辑一致）
        if (controller.refreshList.length == index) {
          return Container();
        }

        // 非最后一项：返回当前的Column卡片结构（替代ListTile）
        // 可根据需要从model中获取数据（此处示例使用固定内容）
        WalletModel01 model = controller.refreshList[index];
        return _buildCardItem(
            model, context); // 提取卡片项为独立方法，与_buildWallet的itemBuilder对应
      },
    );
  }

// 卡片列表项内容（替代原来的ListTile，使用当前的Column结构）
  Widget _buildCardItem(WalletModel01 model, BuildContext context) {
    return Column(
      children: [
        // 地址卡片（可根据model动态填充数据，此处示例保留固定内容）
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0551E1), Colors.lightBlueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                // 示例：从model中动态获取标题（根据实际需求调整）
                '${model.name}USDT钱包地址',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF0489CF),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  // 示例：从model中动态获取地址（根据实际需求调整）
                  model.wallet,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        // 按钮区域（可根据model绑定事件，此处示例保留基础逻辑）
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (ToolsSubmit.progress()) {
                  return;
                }
                showCupertinoDialog(
                  context: context,
                  builder: (builder) {
                    return CupertinoAlertDialog(
                      content: const Text(
                        '确认删除此钱包吗？',
                        style: TextStyle(fontSize: 16),
                      ),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('取消'),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('确认'),
                          onPressed: () {
                            // 返回
                            Get.back();
                            if (ToolsSubmit.call()) {
                              // 提交
                              controller.delete(model);
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
                // 实际场景可调用删除方法：controller.delete(model)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 34.0, vertical: 2.0),
              ),
              child: const Text('删除'),
            ),
          ],
        ),
      ],
    );
  }

  _buildWallet(
    BuildContext context,
  ) {
    if (controller.refreshList.isEmpty) {
      return WidgetCommon.none();
    }
    return ListView.separated(
      itemCount: controller.refreshList.length + 1,
      separatorBuilder: (BuildContext context, int index) {
        return WidgetCommon.divider();
      },
      itemBuilder: (ctx, index) {
        if (controller.refreshList.length == index) {
          return Container();
        }
        WalletModel01 model = controller.refreshList[index];
        return ListTile(
          leading: Icon(
            PayType.alipay.icon,
            size: 40,
            color: PayType.alipay.color,
          ),
          title: Text(
            '姓名：${model.name}',
          ),
          subtitle: Text(
            '账户：${model.wallet}',
          ),
          trailing: InkWell(
            child: const Icon(
              Icons.delete,
            ),
            onTap: () {
              if (ToolsSubmit.progress()) {
                return;
              }
              showCupertinoDialog(
                context: context,
                builder: (builder) {
                  return CupertinoAlertDialog(
                    content: const Text(
                      '确认删除此钱包吗？',
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('取消'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('确认'),
                        onPressed: () {
                          // 返回
                          Get.back();
                          if (ToolsSubmit.call()) {
                            // 提交
                            controller.delete(model);
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

// 新增钱包
class WalletCardItemPage extends GetView<WalletCardController> {
  const WalletCardItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WalletCardController());
    controller.nameController.clear();
    controller.walletController.clear();
    return KeyboardDismissOnTap(
      child: Scaffold(
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
                '新增钱包',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                WidgetAction(
                  onTap: () {
                    if (ToolsSubmit.progress()) {
                      return;
                    }
                    // 验证
                    String name = controller.nameController.text.trim();
                    if (name.isEmpty) {
                      throw Exception('请输入实名认证的姓名信息');
                    }
                    String wallet = controller.walletController.text.trim();
                    if (wallet.isEmpty) {
                      throw Exception('请输入钱包地址');
                    }
                    if (ToolsSubmit.call()) {
                      // 提交
                      controller.add();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _buildName(),
              const SizedBox(
                height: 10,
              ),
              _buildWallet(),
              WidgetCommon.tips('说明：仅支持【TRC20协议】', color: Color(0xFFFF8600)),
            ],
          ),
        ),
      ),
    );
  }

  _buildName() {
    return TextField(
      controller: controller.nameController,
      maxLength: 20,
      decoration: const InputDecoration(
        hintText: '请输入实名认证的姓名信息',
        icon: Text(
          '姓名:',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  _buildWallet() {
    return TextField(
      controller: controller.walletController,
      maxLength: 32,
      maxLines: 3,
      decoration: const InputDecoration(
        hintText: '请输入你的TRC20钱包地址',
        icon: Text(
          '地址:',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
