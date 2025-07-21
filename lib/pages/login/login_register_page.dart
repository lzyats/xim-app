import 'dart:async';

import 'package:alpaca/pages/login/login_index_page%20copy.dart';
import 'package:alpaca/pages/login/login_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/widgets/widget_action.dart';

// 1. 将无状态组件改为有状态组件（继承StatefulWidget）
class LoginRegisterPage extends StatefulWidget {
  // 路由地址
  static const String routeName = '/login_register';
  const LoginRegisterPage({super.key});

  // 2. 创建状态管理类
  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

// 3. 状态管理类（继承State）
class _LoginRegisterPageState extends State<LoginRegisterPage> {
  // 控制邮箱输入框显示/隐藏
  final bool showEmailField = false;

  // 4. 将状态变量移到State类中（移除static，避免静态变量导致的状态异常）
  bool isPassVisible = false; // 密码输入框的显示/隐藏状态
  bool isConfirmPassVisible = false; // 确认密码输入框的显示/隐藏状态

  // 新增倒计时相关变量
  bool isCountingDown = false; // 是否正在倒计时
  int countdownSeconds = 60; // 倒计时总时长（60秒）
  late Timer _countdownTimer; // 定时器
  bool _isTimerInitialized = false; // 跟踪定时器是否已经初始化

  @override
  Widget build(BuildContext context) {
    // 初始化控制器（GetX逻辑保持不变）
    Get.lazyPut(() => LoginRegisterController());
    // 获取控制器实例
    final controller = Get.find<LoginRegisterController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('欢迎注册'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),

              // 1. 手机号码输入
              TextField(
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(ToolsRegex.regExpNumber),
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
              const SizedBox(height: 16),

              // 2. 邮箱输入（条件显示）
              if (showEmailField) ...[
                TextField(
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
                const SizedBox(height: 16),
              ],

              // 3. 密码输入（添加显示/隐藏切换）
              TextField(
                // 根据状态变量控制是否隐藏（false=显示明文，true=隐藏）
                obscureText: !isPassVisible,
                controller: controller.passController,
                decoration: InputDecoration(
                  hintText: '请设置密码',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    // 根据状态切换图标
                    icon: Icon(
                      isPassVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // 5. 现在可以正常使用setState更新状态
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
              const SizedBox(height: 16),

              // 4. 确认密码输入（添加显示/隐藏切换）
              TextField(
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
              const SizedBox(height: 16),
              // 设置系统安全码
              TextField(
                controller: controller.safePassController,
                // 添加数字过滤规则
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
                  LengthLimitingTextInputFormatter(6), // 可选：限制最大长度（例如6位）
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
              const SizedBox(height: 16),
              // 5. 验证码输入（修改获取验证码按钮）
              Row(
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
                  // 替换ElevatedButton为GestureDetector+Container
                  GestureDetector(
                    // 只有不在倒计时时可点击
                    onTap: isCountingDown
                        ? null
                        : () => _startCountdown(controller),
                    child: Container(
                      // 按钮样式（模拟ElevatedButton）
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isCountingDown
                            ? Colors.grey[300]
                            : Colors.blue, // 倒计时时变灰
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Text(
                        // 倒计时中显示剩余秒数，否则显示"获取验证码"
                        isCountingDown ? '${countdownSeconds}s后重新获取' : '获取验证码',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 注册按钮（保持不变）
              ElevatedButton(
                onPressed: () {
                  if (ToolsSubmit.progress()) {
                    return;
                  }
                  _checkPhone(controller);
                  _checkEmail(controller);
                  _checkPass(controller);
                  _checkSafe(controller);
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

              // 协议勾选（保持不变）
              Row(
                children: [
                  const Text('我已阅读并同意'),
                  GestureDetector(
                    child: const Text(
                      '《用户协议》',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const Text('和'),
                  GestureDetector(
                    child: const Text(
                      '《隐私政策》',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const Spacer(),

              // 已有账号登录（保持不变）
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

  // 校验方法：将控制器作为参数传入（因状态类无法直接访问GetView的controller）
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

  _checkCode(LoginRegisterController controller) {
    var code = controller.codeController.text.trim();
    if (code.isEmpty) {
      throw Exception('请输入验证码');
    }
  }

  // 启动倒计时
  void _startCountdown(LoginRegisterController controller) {
    // 先校验手机号和邮箱（与原逻辑一致）
    try {
      _checkPhone(controller);
      _checkEmail(controller);
    } catch (e) {
      // 校验失败不启动倒计时（可根据需求添加提示）
      return;
    }

    // 开始倒计时
    setState(() {
      isCountingDown = true;
      countdownSeconds = 60; // 重置倒计时
    });

    // 启动定时器（每1秒执行一次）
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownSeconds > 1) {
          countdownSeconds--; // 秒数减1
        } else {
          // 倒计时结束，重置状态
          isCountingDown = false;
          countdownSeconds = 60;
          timer.cancel(); // 取消定时器
        }
      });
    });
    _isTimerInitialized = true; // 标记定时器已经初始化
    // 调用控制器发送验证码
    controller.sendCode();
  }

  // 页面销毁时清理定时器（避免内存泄漏）
  @override
  void dispose() {
    if (_isTimerInitialized && _countdownTimer.isActive) {
      _countdownTimer.cancel(); // 取消定时器
    }
    super.dispose();
  }
}
