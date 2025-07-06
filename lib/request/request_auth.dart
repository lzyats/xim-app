import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/login/login_index_page.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_request.dart';

// 鉴权接口
class RequestAuth {
  static String get _prefix => '/auth';

  // 发送验证码
  // 0=注册
  // 1=登录
  // 2=忘记
  static Future<String> sendCode(
    String phone,
    String type, {
    String? email,
  }) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/sendCode',
      data: {
        'phone': phone,
        'email': email,
        'type': type,
      },
    );
    EasyLoading.showToast(ajaxData.getData((data) => data['msg']));
    // 转换
    return ajaxData.getData((data) => AuthModel01.fromJson(data).code);
  }

  // 密码登录
  static Future<AuthModel02> loginPass(String phone, String pass) async {
    // 密码加密
    String password = ToolsEncrypt.md5(pass);
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/loginByPwd',
      data: {
        'phone': phone,
        'password': password,
      },
    );
    return ajaxData.getData((data) => AuthModel02.fromJson(data));
  }

  // 验证码登录
  static Future<AuthModel02> loginCode(String phone, String code) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/loginByCode',
      data: {
        'phone': phone,
        'code': code,
      },
    );
    return ajaxData.getData((data) => AuthModel02.fromJson(data));
  }

  // 注册账号
  static Future<AuthModel02> register(
    String phone,
    String email,
    String code,
  ) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/register',
      data: {
        'phone': phone,
        'email': email,
        'code': code,
      },
    );
    return ajaxData.getData((data) => AuthModel02.fromJson(data));
  }

  // 忘记密码
  static Future<void> forgot(String phone, String code, String pass) async {
    // 密码加密
    String password = ToolsEncrypt.md5(pass);
    // 执行
    await ToolsRequest().post(
      '$_prefix/forget',
      data: {
        'phone': phone,
        'password': password,
        'code': code,
      },
    );
    EasyLoading.showToast('密码重置成功，请重新登录');
  }

  // 扫码登录
  static Future<void> loginScan(String token) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/confirmQrCode',
      data: {
        'token': token,
      },
    );
    EasyLoading.showToast('登录成功');
  }

  // 退出登录
  static Future<void> logout() async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/logout',
    );
    // 跳转
    Get.offAllNamed(LoginIndexPage.routeName);
    // 提醒
    EasyLoading.showToast('退出成功');
  }
}

class AuthModel01 {
  String code;
  AuthModel01(this.code);

  factory AuthModel01.fromJson(Map<String, dynamic>? data) {
    return AuthModel01(
      data?['code'] ?? '',
    );
  }
}

class AuthModel02 {
  String token;
  String banned;
  AuthModel02(
    this.token,
    this.banned,
  );

  factory AuthModel02.fromJson(Map<String, dynamic>? data) {
    return AuthModel02(
      data?['token'] ?? '',
      data?['banned'] ?? 'N',
    );
  }
}
