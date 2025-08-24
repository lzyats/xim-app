import 'package:alpaca/pages/login/login_register_page.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/pages/login/login_forgot_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/pages/login/login_index_controller.dart';
import 'package:alpaca/tools/tools_submit.dart';

class LoginIndexPage extends GetView<LoginIndexController> {
  static const String routeName = '/login';
  // 路由编码
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
                      gradient: LinearGradient(
                        colors: const [
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
                        // 移除 _buildLogo()
                        _buildAccountField(),
                        _buildPasswordField(),
                        _buildLoginButton(),
                        _buildRegisterAndForgotPassword(),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), // 确保图片也有圆角
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              prefixIcon: Icon(Icons.phone_iphone),
              hintStyle: const TextStyle(color: Color(0xFFCCCCCC)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 无边框
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none, // 焦点时无边框
              ),
              /* suffixIcon: IconButton(
                icon: Obx(() => Icon(
                      Icons.clear,
                      color:
                          controller.phoneController.value?.isNotEmpty == true
                              ? Colors.blue
                              : const Color(0xFF999999),
                    )),
                onPressed: clearAccount,
              ), */
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
          // 校验
          _checkPhone();
          // 校验
          // 提交
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

  Widget _buildRegisterAndForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // 替换为 GestureDetector 实现长按事件
            GestureDetector(
              // 长按事件（核心修改）
              onLongPress: () async {
                bool result = await ToolsPerms.camera();
                if (!result) {
                  return;
                }
                ToolsScan.scan();
              },
              // 可选：添加长按反馈（震动或提示）

              child: const Icon(
                Icons.settings,
                color: Color(0xFF666666),
                size: 18,
              ),
            ),
            const SizedBox(width: 5), // 图标与文字之间的间距
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

  // 校验
  _checkPhone() {
    var phone = controller.phoneController.text.trim();
    if (!ToolsRegex.isPhone(phone)) {
      throw Exception('请输入正确的手机号码');
    }
  }

  // 校验
  _checkPass() {
    var pass = controller.passController.text.trim();
    if (pass.isEmpty) {
      throw Exception('请输入密码');
    }
  }

  // 提交
  _submit() {
    // 校验
    // 校验
    _checkPhone();
    // 密码
    if (controller.isPass.isFalse) {
      _loginPass();
    }
    // 验证码
    else {
      _loginCode();
    }
  }

  // 密码登录
  _loginPass() {
    if (ToolsSubmit.progress()) {
      return;
    }
    // 校验
    _checkPass();
    if (ToolsSubmit.call()) {
      // 提交
      controller.loginPass();
    }
  }

  // 校验
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
    // 校验
    _checkCode();
    if (ToolsSubmit.call()) {
      // 提交
      controller.loginCode();
    }
  }
}
