import 'package:alpaca/config/app_config.dart';

// 资源文件
class AppSetting {
  // 开发模式
  static dev() {
    // debug
    AppConfig.debug = true;
    // appId
    AppConfig.appId = '20240101';
    // appSecret
    AppConfig.appSecret = '3e9f44aa8eaef18e';
    // secret
    AppConfig.secret = '3c17c816846c231c';
    // 接口请求地址
    AppConfig.requestHost = 'http://192.168.124.18:8080';
    // socket地址
    AppConfig.requestSocket = 'ws://192.168.124.18:8888';
    // 请求隐私协议
    AppConfig.privacyHost = 'https://baidu.com/privacy.html';
    // 请求服务协议
    AppConfig.serviceHost = 'https://baidu.com/service.html';
    // 高德地图
    AppConfig.amapAndroid = 'ee2e45bee9d61b3a73e3b5696efa374c';
    AppConfig.amapIos = '79cdb4bfa052409bdfd386dd252b4ec6';
    // 个推推送
    AppConfig.pushId = 'PAwNNOUaZ21EYtiLkBr8EA';
    AppConfig.pushKey = 'gkVGWe6U3e4Eals5VCSDc3';
    AppConfig.pushSecret = 'lSklF6H6Yx6QiF8iiBNoW6';
    // 群主领取红包
    AppConfig.groupTrade = true;
    // 密码登录
    AppConfig.loginPwd = true;
    // 邮箱注册
    AppConfig.register = true;
    // 小程序
    AppConfig.mini = false;
  }

  // 生产模式
  static pro() {
    // debug
    AppConfig.debug = false;
    // appId
    AppConfig.appId = '20240101';
    // appSecret
    AppConfig.appSecret = '3e9f44aa8eaef18e';
    // secret
    AppConfig.secret = '3c17c816846c231c';
    // 接口请求地址
    AppConfig.requestHost = 'http://192.168.124.18:8080';
    // socket地址
    AppConfig.requestSocket = 'ws://192.168.124.18:8888';
    // 请求隐私协议
    AppConfig.privacyHost = 'https://baidu.com/privacy.html';
    // 请求服务协议
    AppConfig.serviceHost = 'https://baidu.com/service.html';
    // 高德地图
    AppConfig.amapAndroid = 'ee2e45bee9d61b3a73e3b5696efa374c';
    AppConfig.amapIos = '79cdb4bfa052409bdfd386dd252b4ec6';
    // 个推推送
    AppConfig.pushId = 'PAwNNOUaZ21EYtiLkBr8EA';
    AppConfig.pushKey = 'gkVGWe6U3e4Eals5VCSDc3';
    AppConfig.pushSecret = 'lSklF6H6Yx6QiF8iiBNoW6';
    // 群主领取红包
    AppConfig.groupTrade = false;
    // 密码登录
    AppConfig.loginPwd = true;
    // 邮箱注册
    AppConfig.register = true;
    // 小程序
    AppConfig.mini = false;
  }
}
