import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as get_;
import 'package:alpaca/pages/login/login_banned_page.dart';
import 'package:alpaca/pages/login/login_index_page.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_encrypt.dart';

// 接口请求
class ToolsRequest {
  // 调用对象（延迟初始化，因为需要异步获取baseUrl）
  static late Dio _dio;
  static const String _post = 'post';
  static late String baseUrl;
  // 新增：用于标记Dio是否已初始化的标志位
  static bool _isInitialized = false; // 初始为未初始化

  // 私有构造函数（禁止外部直接实例化）
  ToolsRequest._() {
    // 此处不初始化Dio，因为baseUrl需要异步获取
  }

  // 单例实例
  static ToolsRequest? _singleton;

  // 工厂方法：确保首次调用时初始化，且只初始化一次
  factory ToolsRequest() {
    if (_singleton == null) {
      _singleton = ToolsRequest._();
      // 首次创建单例时，异步获取baseUrl并初始化Dio
      _initDio();
    }
    return _singleton!;
  }

  // 异步初始化Dio（核心：使用缓存的baseUrl）
  static Future<void> _initDio() async {
    // 1. 调用getapihost()获取缓存中的baseUrl
    baseUrl = await getapihost();
    // 2. 用获取到的baseUrl初始化Dio
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: AppConfig.timeout,
    );
    debugPrint("初始地址：" + baseUrl);
    _dio = Dio(options);
    _dio.interceptors.add(_AuthInterCeptor());
    // 初始化完成后，将标志位设为true
    _isInitialized = true;
  }

  // 从缓存获取API服务器配置（你的原方法）
  static Future<String> getapihost() async {
    SysConfig sysConfig = ToolsStorage().sysConfig();
    if (sysConfig.requestHost != null && sysConfig.requestHost.isNotEmpty) {
      return sysConfig.requestHost; // 返回缓存中的值
    }
    return AppConfig.requestHost; // 缓存为空时使用默认值
  }

  // 确保Dio已初始化（修改：使用自定义标志位判断）
  static Future<void> _ensureDioInitialized() async {
    if (!_isInitialized) {
      // 用标志位判断是否未初始化
      await _initDio();
    }
  }

  // get请求（增加Dio初始化检查）
  Future<AjaxData> get(
    String url, {
    bool showError = true,
    Map<String, dynamic>? param,
  }) async {
    return await _request(url, showError: showError, param: param);
  }

  // 分页请求（增加Dio初始化检查）
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

  // post请求（增加Dio初始化检查）
  Future post<AjaxData>(
    String url, {
    Map<String, dynamic>? data,
    bool showError = true,
  }) async {
    return await _request(url, data: data, method: _post, showError: showError);
  }

  // 文件上传（增加Dio初始化检查）
  Future<AjaxData> upload(
    String url,
    MultipartFile multipartFile, {
    bool showError = true,
  }) async {
    FormData data = FormData.fromMap({'file': multipartFile});
    return await _request(url, data: data, method: _post, showError: showError);
  }

  // 核心请求方法
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
        ToolsSubmit.cancel();
        EasyLoading.showToast('当前网络不可用', dismissOnTap: false);
        return Future.error('');
      }
      await _ensureDioInitialized(); // 确保Dio已初始化
      debugPrint('请求地址：$baseUrl$url'); // 打印完整地址（验证baseUrl是否正确）
      debugPrint('请求方式：$method');
      debugPrint('请求方式：$method');
      // 发起请求
      Response response;
      if (method == _post) {
        response = await _dio.post(url, data: data);
      } else {
        response = await _dio.get(url, queryParameters: param);
      }
      return AjaxData(response.data);
    } catch (ex) {
      debugPrint(ex.toString());
      if (showError) {
        ToolsSubmit.cancel();
        EasyLoading.showToast('网络开小差了，请稍后重试', dismissOnTap: false);
      }
      return Future.error('');
    }
  }
}

// 以下为原有代码（拦截器、数据模型等，无需修改）
class _AuthInterCeptor extends Interceptor {
  _AuthInterCeptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> headers = {
      'Authorization': ToolsStorage().token(),
      'version': AppConfig.version,
      'device': AppConfig.device,
    };
    options.headers.addAll(headers);
    _sign(options);
    return handler.next(options);
  }

  void _sign(RequestOptions options) {
    String appId = AppConfig.appId;
    String secret = AppConfig.appSecret;
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
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
    String sign = ToolsEncrypt.sign(appId, secret, timestamp, path);
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
      ToolsSubmit.cancel();
      EasyLoading.showToast('请检查网络连接', dismissOnTap: false);
      return;
    }
    _AjaxBase ajax = _AjaxBase.fromJson(response.data);
    if (ajax.code == LoginIndexPage.routeCode) {
      if (MiddleStatus.login == ToolsStorage().status()) {
        return;
      }
      get_.Get.offAllNamed(LoginIndexPage.routeName);
    } else if (ajax.code == LoginBannedPage.routeCode) {
      if (MiddleStatus.banned == ToolsStorage().status()) {
        return;
      }
      get_.Get.offAllNamed(LoginBannedPage.routeName);
    }
    if (ajax.code != 200) {
      ToolsSubmit.cancel();
      if ('操作成功' != ajax.msg) {
        EasyLoading.showToast(ajax.msg);
      }
      return;
    }
    return handler.next(response);
  }
}

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
  Map<String, dynamic> getJson() {
    return result['data'] ?? {};
  }

  T getData(T Function(dynamic data) function, {bool en = false}) {
    if (en) {
      // 1. 先获取原始数据并解密
      dynamic encryptedData = result['data']; // 获取原始加密数据
      String decryptedStr =
          ToolsEncrypt.decrypt(AppConfig.secret, encryptedData); // 解密为字符串
      Map<String, dynamic> decryptedData = jsonDecode(decryptedStr);
      return function(decryptedData);
    }
    return function(result['data']);
  }

  List<T> getList<T>(T Function(dynamic data) function, {bool en = false}) {
    if (result.containsKey('data')) {
      return _getList(function, 'data', en: en);
    } else if (result.containsKey('rows')) {
      return _getList<T>(function, 'rows', en: en);
    }
    return [];
  }

  List<T> _getList<T>(T Function(dynamic data) function, String param,
      {bool en = false}) {
    // 处理加密逻辑：当en=true时先解密整个列表数据
    dynamic rawData = result[param];
    List<dynamic>? dataList;

    if (en) {
      // 1. 获取原始加密数据并解密
      String decryptedStr = ToolsEncrypt.decrypt(AppConfig.secret, rawData);
      // 2. 解密后的数据应为列表，直接解析为List<dynamic>
      dataList = jsonDecode(decryptedStr) as List<dynamic>?;
    } else {
      // 非加密情况直接转换为列表
      dataList =
          rawData != null ? List<dynamic>.from(rawData.map((x) => x)) : null;
    }

    // 处理空列表情况
    if (dataList == null || dataList.isEmpty) {
      return [];
    }

    // 映射为目标类型列表
    return dataList.map((data) => function(data)).toList();
  }
}
