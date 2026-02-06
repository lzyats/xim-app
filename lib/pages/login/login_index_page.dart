import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/login/login_register_page.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/pages/login/login_forgot_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/pages/login/login_index_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginIndexPage extends GetView<LoginIndexController> {
  static const String routeName = '/login';
  static const int routeCode = 401;

  const LoginIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginIndexController());
    String str = "http://110.42.56.25:8080|ws://110.42.56.25:8888";
    String secret = AppConfig.secret;
    secret = ToolsEncrypt.encrypt(secret, str);
    debugPrint("加密：" + secret);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 使用背景图片
          Image.asset(
            AppImage.appbg,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(), // 将 logo 移动到背景框上方
                const SizedBox(height: 44),
                SingleChildScrollView(
                  child: Container(
                    width: 340,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      // 使用原背景渐变色
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFF4F9FE),
                          Color(0xFFECF4FF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildAccountField(),
                        _buildPasswordField(),
                        // 选择线路（添加点击事件功能）
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextButton.icon(
                            onPressed: () async {
                              // 从本地存储获取配置
                              SysConfig localConfig =
                                  ToolsStorage().sysConfig();
                              // 获取线路列表
                              List<Map<String, String>> routeList =
                                  await AppConfig.requestHostgroup;
                              _showRouteDialog(localConfig, routeList);
                            },
                            icon: const Icon(AppFonts.e642,
                                color: Color(0xFF00ABFF), size: 18),
                            label: const Text(
                              '选择线路',
                              style: TextStyle(
                                  color: Color(0xFF00ABFF), fontSize: 16),
                            ),
                          ),
                        ),
                        _buildLoginButton(),
                        _buildRegisterAndForgotPassword(),
                        /* Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: TextButton.icon(
                            onPressed: () async {
                              ChatRobot chatRobot = await ToolsSqlite()
                                  .robot
                                  .getById(AppConfig.robotId);
                              ToolsRoute().chatPage(
                                chatId: chatRobot.robotId,
                                nickname: chatRobot.nickname,
                                portrait: chatRobot.portrait,
                                chatTalk: ChatTalk.robot,
                              );
                            },
                            icon: const Icon(Icons.headset_mic,
                                size: 16, color: Colors.grey),
                            label: const Text(
                              '联系客服',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ), */
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // 设置圆角
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000), // 阴影颜色，调整透明度可以改变阴影的深浅
            blurRadius: 12, // 阴影模糊程度，数值越大越模糊
            spreadRadius: 2, // 阴影扩散程度，正值会使阴影变大
            offset: Offset(0, 6), // 阴影偏移量
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16), // 确保图片也有圆角
          child: Image.asset(
            AppImage.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildAccountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '手机号',
          style: TextStyle(color: Color(0xFF333333)),
        ),
        const SizedBox(height: 4),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                ToolsRegex.regExpNumber,
              ),
              LengthLimitingTextInputFormatter(11),
            ],
            decoration: InputDecoration(
              hintText: '请输入手机号',
              prefixIcon: const Icon(Icons.phone_iphone),
              hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 无边框
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 焦点时无边框
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '密码',
          style: TextStyle(color: Color(0xFF333333)),
        ),
        const SizedBox(height: 4),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextField(
            controller: controller.passController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '请输入密码',
              hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 无边框
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 焦点时无边框
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              filled: true,
              prefixIcon: Icon(Icons.lock),
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        onPressed: () {
          _checkPhone();
          _submit();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0463F7),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: const Text(
          '会员登录',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // 修改 _buildRegisterAndForgotPassword 方法中的对话框部分
  Widget _buildRegisterAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              '没有账号？',
              style: TextStyle(color: Color(0xFF333333)),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(LoginRegisterPage.routeName);
              },
              child: const Text(
                '立即注册',
                style: TextStyle(color: Color(0xFF0463F7)),
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.toNamed(LoginForgotPage.routeName);
          },
          child: const Text(
            '忘记密码',
            style: TextStyle(color: Color(0xFF0463F7)),
          ),
        ),
      ],
    );
  }

  // 显示线路选择对话框
  void _showRouteDialog(
      SysConfig localConfig, List<Map<String, String>> routeList) async {
    int selectedIndex;

    if (routeList.isEmpty) {
      selectedIndex = 0;
    } else {
      final matchedIndex = routeList.indexWhere((route) {
        return localConfig != null &&
            route["httpUrl"] != null &&
            route["wsUrl"] != null &&
            route["httpUrl"] == localConfig.requestHost &&
            route["wsUrl"] == localConfig.requestSocket;
      });
      selectedIndex = matchedIndex != -1 ? matchedIndex : 0;
    }

    bool showAddRoute = false;

    await showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 40),
              contentPadding: const EdgeInsets.all(16),
              title: const Center(
                child: Text(
                  "选择服务线路",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold),
                ),
              ),
              // 在content外层包裹ConstrainedBox
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth:
                      MediaQuery.of(context).size.width * 0.65, // 占屏幕宽度的80%
                ),
                child: routeList.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            "暂无可用服务线路",
                            style: TextStyle(color: Color(0xFF666666)),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...routeList.asMap().entries.map((entry) {
                              int index = entry.key;
                              var route = entry.value;
                              final routeName = route["name"] ?? "未知线路";
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: selectedIndex == index
                                          ? const Color(0xFF00ABFF)
                                          : const Color(0xFFBDBDBD),
                                      width: 1),
                                  color: selectedIndex == index
                                      ? const Color(0xFFF0F7FF)
                                      : Colors.white,
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    selectedIndex == index
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: const Color(0xFF00ABFF),
                                  ),
                                  title: Text(
                                    routeName,
                                    style: TextStyle(
                                      color: selectedIndex == index
                                          ? const Color(0xFF00ABFF)
                                          : Colors.black,
                                    ),
                                  ),
                                  onTap: () {
                                    if (index >= 0 &&
                                        index < routeList.length) {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    }
                                  },
                                ),
                              );
                            }).toList(),
                            if (!showAddRoute && routeList.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xFF00ABFF),
                                  ),
                                  title: const Text(
                                    "添加新线路",
                                    style: TextStyle(color: Color(0xFF00ABFF)),
                                  ),
                                  onTap: () async {
                                    bool result = await ToolsPerms.camera();
                                    if (!result) return;
                                    if (Get.context != null) {
                                      Navigator.of(Get.context!).pop();
                                    }
                                    ToolsScan.scan();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
              ),
              actions: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (routeList.isEmpty) {
                        EasyLoading.showError('暂无可用服务线路');
                      } else if (selectedIndex < 0 ||
                          selectedIndex >= routeList.length) {
                        EasyLoading.showError('请选择有效的服务线路');
                      } else {
                        var selectedRoute = routeList[selectedIndex];
                        final httpUrl = selectedRoute["httpUrl"] ?? "";
                        final wsUrl = selectedRoute["wsUrl"] ?? "";
                        if (httpUrl.isEmpty || wsUrl.isEmpty) {
                          EasyLoading.showError('选中线路信息不完整');
                          return;
                        }
                        final eName = selectedRoute["name"] ?? "未知线路";
                        debugPrint("选中线路：$eName");
                        debugPrint("HTTP地址：$httpUrl");
                        debugPrint("WS地址：$wsUrl");
                        SysConfig newConfig = SysConfig(
                          hostName: eName,
                          requestHost: httpUrl,
                          requestSocket: wsUrl,
                        );
                        Navigator.pop(dialogContext);
                        await controller.saveRouteConfig(newConfig, eName);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      "确定",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // 校验手机号
  _checkPhone() {
    var phone = controller.phoneController.text.trim();
    if (!ToolsRegex.isPhone(phone)) {
      throw Exception('请输入正确的手机号码');
    }
  }

  // 校验密码
  _checkPass() {
    var pass = controller.passController.text.trim();
    if (pass.isEmpty) {
      throw Exception('请输入密码');
    }
  }

  // 提交登录
  _submit() {
    _checkPhone();
    if (controller.isPass.isFalse) {
      _loginPass();
    } else {
      _loginCode();
    }
  }

  // 密码登录
  _loginPass() {
    if (ToolsSubmit.progress()) {
      return;
    }
    _checkPass();
    if (ToolsSubmit.call()) {
      controller.loginPass();
    }
  }

  // 校验验证码
  _checkCode() {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }

  // 验证码登录
  _loginCode() {
    if (ToolsSubmit.progress()) {
      return;
    }
    _checkCode();
    if (ToolsSubmit.call()) {
      controller.loginCode();
    }
  }
}
