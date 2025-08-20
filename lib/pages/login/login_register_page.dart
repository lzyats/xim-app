import 'dart:async';

import 'package:alpaca/pages/login/login_index_page%20copy.dart';
import 'package:alpaca/pages/login/login_register_controller.dart';
import 'package:alpaca/pages/view/view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/tools/tools_name.dart';
import 'package:alpaca/config/app_config.dart';

class LoginRegisterPage extends StatefulWidget {
  static const String routeName = '/login_register';
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final bool showEmailField = false;
  bool isPassVisible = false;
  bool isConfirmPassVisible = false;
  bool isCountingDown = false;
  int countdownSeconds = 60;
  late Timer _countdownTimer;
  bool _isTimerInitialized = false;
  bool _isRead = true;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => LoginRegisterController());
    final controller = Get.find<LoginRegisterController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.nicknameController.text.isEmpty) {
        controller.nicknameController.text = ToolsName.generateRandomName();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎注册'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // 手机号码输入（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85, // 标签固定宽度
                    child: Text(
                      '手机号码',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            ToolsRegex.regExpNumber),
                        LengthLimitingTextInputFormatter(11),
                      ],
                      controller: controller.phoneController,
                      decoration: InputDecoration(
                        hintText: '请输入手机号码',
                        prefixIcon: const Icon(Icons.phone_iphone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 昵称输入（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '用户昵称',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: controller.nicknameController,
                      decoration: InputDecoration(
                        hintText: '请输入昵称',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            controller.nicknameController.text =
                                ToolsName.generateRandomName();
                          },
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 邮箱输入（左右结构，条件显示）
              if (showEmailField) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 85,
                      child: Text(
                        '邮箱地址',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(200),
                        ],
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          hintText: '请输入邮箱地址',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // 密码输入（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '用户密码',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: !isPassVisible,
                      controller: controller.passController,
                      decoration: InputDecoration(
                        hintText: '请设置密码',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPassVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPassVisible = !isPassVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 确认密码输入（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '确认密码',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: !isConfirmPassVisible,
                      controller: controller.confirmPassController,
                      decoration: InputDecoration(
                        hintText: '请再次输入密码',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPassVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPassVisible = !isConfirmPassVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 系统安全码（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '安全密码',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      // 添加数字键盘配置
                      keyboardType: TextInputType.number, // 关键配置：强制显示数字键盘
                      controller: controller.safePassController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        hintText: '请设置4-6位的系统安全码',
                        prefixIcon: const Icon(Icons.security),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 邀请码输入框（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '邀请码(选填)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller.inviteCodeController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]')),
                        LengthLimitingTextInputFormatter(6),
                      ],
                      decoration: InputDecoration(
                        hintText: '请输入6位邀请码（选填）',
                        prefixIcon: const Icon(Icons.card_giftcard),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 验证码输入（左右结构）
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 85,
                    child: Text(
                      '验 证 码',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(6),
                            ],
                            controller: controller.codeController,
                            decoration: InputDecoration(
                              hintText: '请输入验证码',
                              prefixIcon: const Icon(Icons.code),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(35),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: isCountingDown
                              ? null
                              : () => _startCountdown(controller),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: isCountingDown
                                  ? Colors.grey[300]
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Text(
                              isCountingDown
                                  ? '${countdownSeconds}s后重新获取'
                                  : '获取验证码',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 注册按钮
              ElevatedButton(
                onPressed: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  _checkPhone(controller);
                  _checkNickname(controller);
                  _checkEmail(controller);
                  _checkPass(controller);
                  _checkSafe(controller);
                  _checkincode(controller);
                  _checkCode(controller);
                  if (ToolsSubmit.call()) {
                    controller.submit();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: const Text(
                  '立即注册',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 协议勾选
              Row(
                children: [
                  Checkbox(
                    value: _isRead,
                    onChanged: (value) {
                      setState(() {
                        _isRead = value ?? true;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                  const Text('已阅读并同意'),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        ViewPage.routeName,
                        arguments: ViewData(
                          title: '服务协议',
                          AppConfig.serviceHost,
                          warn: false,
                        ),
                      );
                    },
                    child: const Text(
                      '《用户协议》',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Text('和'),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        ViewPage.routeName,
                        arguments: ViewData(
                          title: '隐私协议',
                          AppConfig.privacyHost,
                          warn: false,
                        ),
                      );
                    },
                    child: const Text(
                      '《隐私政策》',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // 已有账号登录
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('已有账号？'),
                  GestureDetector(
                    onTap: () => Get.toNamed(LoginIndexPage.routeName),
                    child: const Text(
                      '立即登录',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // 校验方法保持不变
  _checkPhone(LoginRegisterController controller) {
    var phone = controller.phoneController.text.trim();
    if (!ToolsRegex.isPhone(phone)) {
      throw Exception('请输入正确的手机号码');
    }
  }

  _checkEmail(LoginRegisterController controller) {
    if (showEmailField) {
      var email = controller.emailController.text.trim();
      if (!ToolsRegex.isEmail(email)) {
        throw Exception('请输入正确的邮箱地址');
      }
    }
  }

  _checkPass(LoginRegisterController controller) {
    var pass1 = controller.passController.text.trim();
    var pass2 = controller.confirmPassController.text.trim();
    if (pass1.length < 6) {
      throw Exception('请输入至少6位密码');
    }
    if (pass1 != pass2) {
      throw Exception('两次输入的密码不一致');
    }
  }

  _checkSafe(LoginRegisterController controller) {
    var safe = controller.safePassController.text.trim();
    if (safe.length < 4) {
      throw Exception('请设置一个至少6位的系统安全码');
    }
  }

  _checkNickname(LoginRegisterController controller) {
    var nickname = controller.nicknameController.text.trim();
    if (nickname.isEmpty) {
      throw Exception('昵称不能为空');
    }
    if (nickname.length < 2) {
      throw Exception('昵称长度不能少于2个字符');
    }
  }

  _checkincode(LoginRegisterController controller) {
    var safe = controller.inviteCodeController.text.trim();
    if (!safe.isEmpty) {
      if (safe.length < 6) {
        throw Exception('邀请码长度为6位');
      }
    }
  }

  _checkCode(LoginRegisterController controller) {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }

  void _startCountdown(LoginRegisterController controller) {
    try {
      _checkPhone(controller);
      _checkEmail(controller);
    } catch (e) {
      return;
    }

    setState(() {
      isCountingDown = true;
      countdownSeconds = 60;
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownSeconds > 1) {
          countdownSeconds--;
        } else {
          isCountingDown = false;
          countdownSeconds = 60;
          timer.cancel();
        }
      });
    });
    _isTimerInitialized = true;
    controller.sendCode();
  }

  @override
  void dispose() {
    if (_isTimerInitialized && _countdownTimer.isActive) {
      _countdownTimer.cancel();
    }
    super.dispose();
  }
}
