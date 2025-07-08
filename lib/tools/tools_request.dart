import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as get_;
import 'package:alpaca/pages/login/login_banned_page.dart';
import 'package:alpaca/pages/login/login_index_page.dart';
import 'package:alpaca/pages/login/login_pass_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

// 接口请求
class ToolsRequest {
  // 调用对象
  static late final Dio _dio;
  static const String _post = 'post';

  ToolsRequest._() {
    // 创建对象
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.requestHost,
      connectTimeout: AppConfig.timeout,
    );
    _dio = Dio(options);
    _dio.interceptors.add(_AuthInterCeptor());
  }
  static ToolsRequest? _singleton;
  factory ToolsRequest() => _singleton ??= ToolsRequest._();

  // get请求
  Future<AjaxData> get(
    String url, {
    bool showError = true,
    Map<String, dynamic>? param,
  }) async {
    return await _request(url, showError: showError, param: param);
  }

  // 分页请求
  Future page<AjaxData>(
    String url,
    int pageNum, {
    Map<String, dynamic>? data,
    int pageSize = 10,
    bool showError = true,
  }) async {
    if (pageNum < 1) {
      pageNum = 1;
    }
    Map<String, dynamic> param = {'pageNum': pageNum, 'pageSize': pageSize};
    if (data != null) {
      param.addAll(data);
    }
    return await _request(url, param: param, showError: showError);
  }

  // post请求
  Future post<AjaxData>(
    String url, {
    Map<String, dynamic>? data,
    bool showError = true,
  }) async {
    return await _request(url, data: data, method: _post, showError: showError);
  }

  // 文件上传
  Future<AjaxData> upload(
    String url,
    MultipartFile multipartFile, {
    bool showError = true,
  }) async {
    FormData data = FormData.fromMap({'file': multipartFile});
    return await _request(url, data: data, method: _post, showError: showError);
  }

  // request请求
  Future<AjaxData> _request(
    String url, {
    Object? data,
    Map<String, dynamic>? param,
    String method = 'get',
    bool showError = true,
  }) async {
    try {
      // 检查网络
      if (showError && !AppConfig.network) {
        // 取消
        ToolsSubmit.cancel();
        // 提醒
        EasyLoading.showToast('当前网络不可用', dismissOnTap: false);
        return Future.error('');
      }
      debugPrint('请求地址：$url');
      debugPrint('请求方式：$method');
      // 发起请求
      Response response;
      if (method == _post) {
        response = await _dio.post(url, data: data);
      } else {
        response = await _dio.get(url, queryParameters: param);
      }
      //debugPrint('$url返回数据：');
      // 转换
      return AjaxData(response.data);
    } catch (ex) {
      //print(ex);
      if (showError) {
        // 取消
        ToolsSubmit.cancel();
        // 提醒
        debugPrint('$url网络开小差了');
        EasyLoading.showToast('网络开小差了，请稍后重试', dismissOnTap: false);
      }
      return Future.error('');
    }
  }
}

class _AuthInterCeptor extends Interceptor {
  _AuthInterCeptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 增加headers
    Map<String, dynamic> headers = {
      // 获取token
      'Authorization': ToolsStorage().token(),
      // 接口版本号
      'version': AppConfig.version,
      // 获取设备
      'device': AppConfig.device,
    };
    // 增加headers
    options.headers.addAll(headers);
    // 计算签名
    _sign(options);
    return handler.next(options);
  }

  // 计算签名
  void _sign(RequestOptions options) {
    // appId
    String appId = AppConfig.appId;
    // secret
    String secret = AppConfig.appSecret;
    // timestamp
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    // path
    String path = options.path;
    if ('GET' == options.method) {
      Map<String, dynamic> paramets = options.queryParameters;
      if (paramets.isNotEmpty) {
        bool index = true;
        paramets.forEach((key, value) {
          if (index) {
            path += '?';
            index = false;
          } else {
            path += '&';
          }
          path += '$key=$value';
        });
      }
    }
    // 签名
    String sign = ToolsEncrypt.sign(appId, secret, timestamp, path);
    // headers
    Map<String, dynamic> headers = {
      'appId': appId,
      'timestamp': timestamp,
      'sign': sign
    };
    options.headers.addAll(headers);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != 200) {
      // 取消
      ToolsSubmit.cancel();
      // 提醒
      EasyLoading.showToast('请检查网络连接', dismissOnTap: false);
      return;
    }
    _AjaxBase ajax = _AjaxBase.fromJson(response.data);
    // 退出登录
    if (ajax.code == LoginIndexPage.routeCode) {
      if (MiddleStatus.login == ToolsStorage().status()) {
        return;
      }
      get_.Get.offAllNamed(LoginIndexPage.routeName);
    }
    // 设置密码
    else if (ajax.code == LoginPassPage.routeCode) {
      if (MiddleStatus.pass == ToolsStorage().status()) {
        return;
      }
      get_.Get.offAllNamed(LoginPassPage.routeName);
    }
    // 账号封禁
    else if (ajax.code == LoginBannedPage.routeCode) {
      if (MiddleStatus.banned == ToolsStorage().status()) {
        return;
      }
      get_.Get.offAllNamed(LoginBannedPage.routeName);
    }
    // 摊窗提示
    if (ajax.code != 200) {
      // 取消
      ToolsSubmit.cancel();
      // 提醒
      if ('操作成功' != ajax.msg) {
        EasyLoading.showToast(ajax.msg);
      }
      return;
    }
    return handler.next(response);
  }
}

// 基础对象
class _AjaxBase {
  int code;
  String msg;
  _AjaxBase(this.code, this.msg);

  factory _AjaxBase.fromJson(Map<String, dynamic> data) {
    return _AjaxBase(data['code'], data['msg']);
  }
}

class AjaxData<T> {
  Map<String, dynamic> result;
  AjaxData(this.result) {
    debugPrint('请求返回：$result');
  }

  // 获取对象
  Map<String, dynamic> getJson() {
    return result['data'] ?? {};
  }

  // 获取对象
  T getData(T Function(dynamic data) function) {
    return function(result['data']);
  }

  // 获取列表
  List<T> getList<T>(T Function(dynamic data) function) {
    if (result.containsKey('data')) {
      return _getList(function, 'data');
    } else if (result.containsKey('rows')) {
      return _getList<T>(function, 'rows');
    }
    return [];
  }

  // 获取列表
  List<T> _getList<T>(T Function(dynamic data) function, String param) {
    List<dynamic>? dataList = List<dynamic>.from(result[param]?.map((x) => x));
    if (dataList.isEmpty) {
      return [];
    }
    return dataList.map((data) => function(data)).toList();
  }
}
