import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/pages/wallet/wallet_cash_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
// 补充图片资源配置导入
import 'package:alpaca/pages/common/common_about_page.dart';
import 'package:alpaca/pages/common/common_feedback_page.dart';
import 'package:alpaca/pages/common/common_help_page.dart';
import 'package:alpaca/pages/common/common_notices_page.dart';
import 'package:alpaca/pages/mine/mine_collect_page.dart';
import 'package:alpaca/pages/mine/mine_index_controller.dart';
import 'package:alpaca/pages/mine/mine_safety_page.dart';
import 'package:alpaca/pages/mine/mine_setting_page.dart';
import 'package:alpaca/pages/common/common_index_page.dart';
import 'package:alpaca/pages/wallet/wallet_index_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/widgets/widget_action.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_line.dart';

double _iconSize = 25;

// 我的页面
class MineIndexPage extends GetView<MineIndexController> {
  const MineIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MineIndexController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              '个人中心',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              WidgetAction(
                icon: const Icon(
                  AppFonts.e681,
                  color: Colors.blue,
                ),
                onTap: () async {
                  ChatRobot chatRobot =
                      await ToolsSqlite().robot.getById(AppConfig.robotId);
                  ToolsRoute().chatPage(
                    chatId: chatRobot.robotId,
                    nickname: chatRobot.nickname,
                    portrait: chatRobot.portrait,
                    chatTalk: ChatTalk.robot,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // 用Stack包裹背景图和内容，实现背景图效果
      body: Stack(
        children: [
          // 背景图片（置于底层）
          Image.asset(
            AppImage.appbg, // 确保AppImage中已定义appbg资源路径
            fit: BoxFit.cover, // 图片铺满容器，可能会裁剪
            width: double.infinity,
            height: double.infinity,
          ),
          // 原有内容区域（覆盖在背景图上）
          ListView(
            children: <Widget>[
              // 头像和用户名区域（用InkWell包裹以添加点击事件）
              InkWell(
                onTap: () {
                  Get.toNamed(MineSettingPage.routeName);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  // 可添加半透明背景色增强文字可读性
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // 白色半透明背景
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    // 使用MainAxisAlignment.spaceBetween让左右内容两端对齐
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // 左侧：头像和用户名
                      Obx(() {
                        final localUser = controller.localUser.value;
                        return Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 40.0,
                              backgroundImage: NetworkImage(
                                localUser.portrait,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  localUser.nickname,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  'ID号: ${localUser.userNo}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                      // 右侧：二维码图标和箭头（已移到最右边）
                      Row(
                        children: <Widget>[
                          Icon(Icons.qr_code),
                          SizedBox(width: 8.0), // 增加图标间距
                          WidgetCommon.arrow(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // 钱包区域
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8), // 增加透明度避免与背景冲突
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '我的钱包',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        // 余额与刷新按钮组合（用Row包裹）
                        Obx(() {
                          return Row(
                            children: [
                              // 余额文本（保持Obx监听）
                              Text(
                                controller.balance.value, // balance 为 RxString
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 12.0), // 文本与按钮间距
                              // 刷新按钮
                              IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.white, // 图标颜色与文本一致
                                  size: 20.0, // 图标大小
                                ),
                                onPressed: () {
                                  // 调用控制器方法刷新余额
                                  controller.getInfo();
                                },
                                padding: EdgeInsets.zero, // 去除默认内边距
                                constraints: BoxConstraints(), // 去除最小点击区域限制
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          WalletCashPage.routeName,
                        );
                      },
                      child: Text('提现'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),

              // 邀请好友和在线签到区域
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            // 使用Row布局实现文字与图片左右排列
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // 左右两端对齐
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // 垂直居中对齐
                              children: [
                                // 左侧：文字内容
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start, // 文字左对齐
                                  children: [
                                    Text(
                                      '邀请好友',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0463F7),
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      '得豪华大礼',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Color(0xFF0463F7),
                                      ),
                                    ),
                                    SizedBox(height: 2.0), // 文字图片区域与按钮的间距

                                    ElevatedButton(
                                      onPressed: () {
                                        // 去邀请按钮点击事件
                                      },
                                      child: Text('去邀请'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                // 右侧：新增图片hltj
                                Image.asset(
                                  AppImage.hltj,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade50.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: <Widget>[
                            // 使用Row布局实现文字与图片左右排列
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween, // 左右两端对齐
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, // 垂直居中对齐
                              children: [
                                // 左侧：文字内容
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start, // 文字左对齐
                                  children: [
                                    Text(
                                      '在线签到',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFC04EEB),
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      '得豪华大礼',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFFC04EEB),
                                      ),
                                    ),
                                    SizedBox(height: 2.0), // 文字图片区域与按钮的间距

                                    ElevatedButton(
                                      onPressed: () {
                                        // 去签到按钮点击事件
                                      },
                                      child: Text('去签到'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.0), //
                                  ],
                                ),
                                // 右侧：新增图片hltj
                                Image.asset(
                                  AppImage.mrqd,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 其他功能区域
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '其他功能',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        AppFonts.e607,
                      ),
                      title: Text('我的钱包'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // 关于我们点击事件
                        Get.toNamed(
                          WalletIndexPage.routeName,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.update),
                      title: Text('账号安全'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // 版本更新点击事件
                        Get.toNamed(
                          MineSafetyPage.routeName,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(AppFonts.ec85),
                      title: Text('我的收藏'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // 关于我们点击事件
                        Get.toNamed(
                          MineCollectPage.routeName,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('软件设置'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // 设置点击事件
                        Get.toNamed(
                          CommonSoftwarePage.routeName,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('关于我们'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // 关于我们点击事件
                        Get.toNamed(
                          CommonAboutPage.routeName,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
