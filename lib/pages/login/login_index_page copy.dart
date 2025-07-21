import 'package:alpaca/pages/login/login_register_page.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_resource.dart';
import 'package:alpaca/pages/login/login_forgot_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/pages/login/login_index_controller.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_checkbox.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_image.dart';

// 登录页面
class LoginIndexPage extends GetView<LoginIndexController> {
  // 路由地址
  static const String routeName = '/login';
  // 路由编码
  static const int routeCode = 401;

  const LoginIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginIndexController());
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AnimateGradient(
            primaryColors: const [
              Colors.pink,
              Colors.pinkAccent,
              Colors.white,
            ],
            secondaryColors: [
              AppTheme.color,
              Colors.blueAccent,
              Colors.white,
            ],
            child: Column(
              children: [
                _buildLogo(),
                _buildProject(),
                _buildPhone(),
                Obx(
                  () => controller.isPass.isTrue ? _buildPass() : _buildCode(),
                ),
                _buildSubmit(),
                _buildPath(),
                _buildPrivacy(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: ClipOval(
        child: WidgetImage(
          AppImage.logo,
          ImageType.asset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildProject() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        AppConfig.appName,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildPhone() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
      child: TextField(
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            ToolsRegex.regExpNumber,
          ),
          LengthLimitingTextInputFormatter(11),
        ],
        controller: controller.phoneController,
        decoration: const InputDecoration(
          hintText: '请输入手机号码',
          prefixIcon: Icon(Icons.phone_iphone),
        ),
      ),
    );
  }

  _buildPass() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: TextField(
        obscureText: true,
        controller: controller.passController,
        decoration: const InputDecoration(
          hintText: '请输入密码',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  _buildCode() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                ToolsRegex.regExpNumber,
              ),
              LengthLimitingTextInputFormatter(6),
            ],
            controller: controller.codeController,
            decoration: const InputDecoration(
              hintText: '请输入验证码',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          Positioned(
            right: 10,
            child: GestureDetector(
              onTap: () {
                // 校验
                _checkPhone();
                // 校验
                bool result = _checkPrivacy();
                if (!result) {
                  return;
                }
                // 提交
                controller.sendCode();
              },
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 20,
                  ),
                  color: Colors.grey[200],
                  child: Text(
                    controller.toolsTimer.sendText.value,
                    style: TextStyle(
                      color: AppTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSubmit() {
    return Obx(
      () => WidgetButton(
        label: controller.isPass.isTrue
            ? '密码登录'
            : (AppConfig.register ? '登  录' : '登录/注册'),
        onTap: () {
          _submit();
        },
      ),
    );
  }

  _buildPath() {
    if (!AppConfig.loginPwd) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, right: 20),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TDLink(
              label: controller.isPass.isFalse ? '使用密码登录' : '使用验证码登录',
              style: TDLinkStyle.primary,
              linkClick: (uri) {
                _changePass();
              },
            ),
            if (controller.isPass.isTrue)
              TDLink(
                label: '找回密码',
                style: TDLinkStyle.primary,
                linkClick: (uri) {
                  Get.toNamed(LoginForgotPage.routeName);
                },
              ),
            if (controller.isPass.isFalse)
              TDLink(
                label: '注册账号',
                style: TDLinkStyle.primary,
                linkClick: (uri) {
                  Get.toNamed(LoginRegisterPage.routeName);
                },
              ),
          ],
        );
      }),
    );
  }

  _buildPrivacy() {
    return GestureDetector(
      onTap: () {
        controller.isPrivacy.value = !controller.isPrivacy.value;
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: Row(
          children: [
            Obx(
              () => WidgetCheckbox(
                value: controller.isPrivacy.isTrue,
                size: 22,
                onChanged: (bool? value) {
                  controller.isPrivacy.value = !controller.isPrivacy.value;
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('已阅读并同意'),
            TDLink(
              label: '《服务协议》',
              style: TDLinkStyle.primary,
              type: TDLinkType.withUnderline,
              uri: Uri(),
              linkClick: (uri) {
                Get.toNamed(
                  ViewPage.routeName,
                  arguments: ViewData(
                    title: '服务协议',
                    AppConfig.serviceHost,
                    warn: false,
                  ),
                );
              },
            ),
            const Text('与'),
            TDLink(
              label: '《隐私协议》',
              style: TDLinkStyle.primary,
              type: TDLinkType.withUnderline,
              uri: Uri(),
              linkClick: (uri) {
                Get.toNamed(
                  ViewPage.routeName,
                  arguments: ViewData(
                    title: '隐私协议',
                    AppConfig.privacyHost,
                    warn: false,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // 改变隐私协议
  _changePrivacy(value) {
    controller.isPrivacy.value = value;
  }

  // 改变密码
  _changePass() {
    controller.isPass.value = !controller.isPass.value;
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

  // 校验
  _checkCode() {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }

  // 校验
  _checkPrivacy() {
    if (controller.isPrivacy.isFalse) {
      showCupertinoDialog(
        context: AppConfig.navigatorKey.currentState!.context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: const Text(
              '是否同意隐私协议',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('拒绝'),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoDialogAction(
                child: const Text('同意'),
                onPressed: () {
                  // 返回
                  Get.back();
                  _changePrivacy(true);
                },
              ),
            ],
          );
        },
      );
    }
    return controller.isPrivacy.value;
  }

  // 提交
  _submit() {
    // 校验
    bool result = _checkPrivacy();
    if (!result) {
      return;
    }
    // 校验
    _checkPhone();
    // 密码
    if (controller.isPass.isTrue) {
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
