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
    AppConfig.secret = 'YTY9FRenXiJNeE2x';
    // 接口请求地址
    AppConfig.requestHost = 'http://api.amoa.cn';
    //AppConfig.requestHost = 'http://192.168.109.131:8080';
    // socket地址
    AppConfig.requestSocket = 'ws://ws.amoa.cn';
    //AppConfig.requestSocket = 'ws://43.225.157.91:8888';
    // 请求隐私协议
    AppConfig.privacyHost = 'https://work.weixin.qq.com/nl/eula';
    // 请求服务协议
    AppConfig.serviceHost = 'https://work.weixin.qq.com/nl/eula';
    // 高德地图
    AppConfig.amapAndroid = 'b88f06525690d65c776f102243bde5e4';
    AppConfig.amapIos = '1d3634f089bad2aa2ace7176d29c6878';
    // 个推推送
    AppConfig.pushId = '0RbcZP7qpW85LeTKqhtDw1';
    AppConfig.pushKey = 'Tscywps0VSAKcjI4B1rEr3';
    AppConfig.pushSecret = 'm0wOSAPWOp6F7ormKOvD08';
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
    AppConfig.requestHost = 'http://api.amoa.cn';
    // socket地址
    AppConfig.requestSocket = 'ws://ws.amoa.cn';
    // 请求隐私协议
    AppConfig.privacyHost = 'https://baidu.com/privacy.html';
    // 请求服务协议
    AppConfig.serviceHost = 'https://baidu.com/service.html';
    // 高德地图
    AppConfig.amapAndroid = 'b88f06525690d65c776f102243bde5e4';
    AppConfig.amapIos = '1d3634f089bad2aa2ace7176d29c6878';
    // 个推推送
    AppConfig.pushId = '0RbcZP7qpW85LeTKqhtDw1';
    AppConfig.pushKey = 'Tscywps0VSAKcjI4B1rEr3';
    AppConfig.pushSecret = 'm0wOSAPWOp6F7ormKOvD08';
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
