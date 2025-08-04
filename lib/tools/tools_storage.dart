import 'package:get_storage/get_storage.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';

// 本地存储
class ToolsStorage {
  ToolsStorage._();
  static ToolsStorage? _singleton;
  factory ToolsStorage() => _singleton ??= ToolsStorage._();
  // 存储对象
  final GetStorage _storage = GetStorage();

  String token({String token = ''}) {
    // 类型
    String type = 'token';
    // 读取
    if (token.isEmpty) {
      return _storage.read(type) ?? '';
    }
    // 写入
    _storage.write(type, token);
    return token;
  }

  // status
  MiddleStatus status({MiddleStatus? value}) {
    // 类型
    String type = 'status';
    // 读取
    if (value == null) {
      String value = _storage.read(type) ?? '';
      return MiddleStatus.init(value);
    }
    // 写入
    _storage.write(type, value.value);
    if (MiddleStatus.login == value) {
      // 清空
      _storage.erase();
    }
    return value;
  }

  // 登录信息
  LocalUser local({LocalUser? value}) {
    // 类型
    String type = 'local';
    if (value != null) {
      // 写入
      _storage.write(type, value.toJson());
      // 返回
      return value;
    }
    // 读取
    Map<String, dynamic> data = _storage.read(type) ?? {};
    // 转换
    return LocalUser.fromJson(data);
  }

  // chat
  LocalChat chat({LocalChat? value}) {
    // 类型
    String type = 'chat';
    if (value != null) {
      // 写入
      _storage.write(type, value.toJson());
      // 返回
      return value;
    }
    // 读取
    Map<String, dynamic> data = _storage.read(type) ?? {};
    // 转换
    return LocalChat.fromJson(data);
  }

  // 系统配置（新增）
  SysConfig sysConfig({SysConfig? value}) {
    // 存储键名（与其他配置区分）
    String type = 'sysConfig';
    // 写入操作
    if (value != null) {
      _storage.write(type, value.toJson());
      return value;
    }
    // 读取操作
    Map<String, dynamic> data = _storage.read(type) ?? {};
    return SysConfig.fromJson(data);
  }

  // config
  LocalConfig config({LocalConfig? value}) {
    // 类型
    String type = 'config';
    if (value != null) {
      // 写入
      _storage.write(type, value.toJson());
      // 返回
      return value;
    }
    // 读取
    Map<String, dynamic> data = _storage.read(type) ?? {};
    // 转换
    return LocalConfig.fromJson(data);
  }

  // 置顶
  bool top(String key, {String value = '', bool read = false}) {
    // 类型
    String type = 'top';
    // 读取
    Map<String, dynamic> dataList = _storage.read(type) ?? {};
    // 只读
    if (read) {
      return dataList.containsKey(key);
    }
    if ('Y' == value) {
      dataList.addAll({key: key});
    } else {
      dataList.remove(key);
    }
    _storage.write(type, dataList);
    return 'Y' == value;
  }

  // 静默
  bool disturb(String key, {String value = '', bool read = false}) {
    // 类型
    String type = 'disturb';
    // 读取
    Map<String, dynamic> dataList = _storage.read(type) ?? {};
    // 只读
    if (read) {
      return dataList.containsKey(key);
    }
    if ('Y' == value) {
      dataList.addAll({key: key});
    } else {
      dataList.remove(key);
    }
    _storage.write(type, dataList);
    return 'Y' == value;
  }

  // 新增：签到状态（按日期存储，key为"yyyy-MM-dd"格式的日期）
  bool signInStatus({required String dateKey, bool? value}) {
    // 存储主键（区分其他存储数据）
    String type = 'signInStatus';
    // 读取现有签到状态集合（默认空map）
    Map<String, dynamic> statusMap = _storage.read(type) ?? {};

    // 读取操作：如果value为null，则返回该日期的签到状态（默认未签到）
    if (value == null) {
      return statusMap[dateKey] ?? false;
    }

    // 写入操作：更新该日期的签到状态，并保存完整map
    statusMap[dateKey] = value;
    _storage.write(type, statusMap);
    return value;
  }

  // 备注
  String remark(String key, {String value = '', bool read = false}) {
    // 类型
    String type = 'remark';
    // 读取
    Map<String, dynamic> dataList = _storage.read(type) ?? {};
    // 只读
    if (read) {
      return dataList[key] ?? value;
    }
    if (value.isEmpty) {
      dataList.remove(key);
    } else {
      dataList.addAll({key: value});
    }
    _storage.write(type, dataList);
    return value;
  }

  // 草稿
  String draft(String key, {String value = '', bool read = false}) {
    // 类型
    String type = 'draft';
    // 读取
    Map<String, dynamic> dataList = _storage.read(type) ?? {};
    // 只读
    if (read) {
      return dataList[key] ?? value;
    }
    if (value.isEmpty) {
      dataList.remove(key);
    } else {
      dataList.addAll({key: value});
    }
    _storage.write(type, dataList);
    return value;
  }

  // 引用
  Map<String, dynamic> reply(
    String key, {
    Map<String, dynamic>? value,
    bool read = false,
  }) {
    // 类型
    String type = 'reply';
    // 读取
    Map<String, dynamic> dataList = _storage.read(type) ?? {};
    // 只读
    if (read) {
      return dataList[key] ?? (value ?? {});
    }
    if (value == null) {
      dataList.remove(key);
    } else {
      dataList.addAll({key: value});
    }
    _storage.write(type, dataList);
    return value ?? {};
  }

  // 设置
  ChatConfig setting({ChatConfig? value}) {
    // 类型
    String type = 'setting';
    // 数据
    ChatConfig config;
    // 写入
    if (value != null) {
      _storage.write(type, value.toJson());
      config = value;
    }
    // 读取
    else {
      Map<String, dynamic> data = _storage.read(type) ?? {};
      config = ChatConfig.fromJson(data);
    }
    return config;
  }
}

class LocalChat {
  String chatId;
  String portrait;
  String title;
  String nickname;
  ChatTalk chatTalk;

  LocalChat({
    required this.chatId,
    required this.portrait,
    required this.title,
    required this.nickname,
    required this.chatTalk,
  });

  factory LocalChat.fromJson(Map<String, dynamic> data) {
    return LocalChat(
      chatId: data['chatId'],
      portrait: data['portrait'],
      nickname: data['nickname'],
      title: data['title'],
      chatTalk: ChatTalk.init(data['chatTalk']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'portrait': portrait,
      'title': title,
      'nickname': nickname,
      'chatTalk': chatTalk.value,
    };
  }
}

class LocalUser {
  String userId;
  String nickname;
  String portrait;
  String sign;
  String gender;
  String genderLabel;
  String phone;
  String email;
  String userNo;
  String intro;
  String province;
  String city;
  String birthday;
  String privacyNo;
  String privacyPhone;
  String privacyScan;
  String privacyCard;
  String privacyGroup;
  String payment;
  String pass;
  String safestr;
  String incode;
  AuthType auth;

  LocalUser(
    this.userId,
    this.nickname,
    this.portrait,
    this.sign,
    this.gender,
    this.genderLabel,
    this.phone,
    this.email,
    this.userNo,
    this.intro,
    this.province,
    this.city,
    this.birthday,
    this.privacyNo,
    this.privacyPhone,
    this.privacyScan,
    this.privacyCard,
    this.privacyGroup,
    this.payment,
    this.pass,
    this.safestr,
    this.incode,
    this.auth,
  );

  factory LocalUser.fromJson(Map<String, dynamic>? data) {
    return LocalUser(
      data?['userId'] ?? '',
      data?['nickname'] ?? '',
      data?['portrait'] ?? '',
      data?['sign'] ?? '',
      data?['gender'] ?? '',
      data?['gender'] == '1' ? '男' : '女',
      data?['phone'] ?? '',
      data?['email'] ?? '',
      data?['userNo'] ?? '',
      data?['intro'] ?? '',
      data?['province'] ?? '',
      data?['city'] ?? '',
      data?['birthday'] ?? '',
      data?['privacyNo'] ?? '',
      data?['privacyPhone'] ?? '',
      data?['privacyScan'] ?? '',
      data?['privacyCard'] ?? '',
      data?['privacyGroup'] ?? '',
      data?['payment'] ?? 'N',
      data?['pass'] ?? 'N',
      data?['safestr'] ?? '',
      data?['incode'] ?? '',
      AuthType.init(data?['auth'] ?? '0'),
    );
  }

  factory LocalUser.init() {
    return LocalUser.fromJson({});
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'sign': sign,
      'gender': gender,
      'phone': phone,
      'email': email,
      'userNo': userNo,
      'intro': intro,
      'province': province,
      'city': city,
      'birthday': birthday,
      'privacyNo': privacyNo,
      'privacyPhone': privacyPhone,
      'privacyScan': privacyScan,
      'privacyCard': privacyCard,
      'privacyGroup': privacyGroup,
      'payment': payment,
      'pass': pass,
      'safestr': safestr,
      'incode': incode,
      'auth': auth.value,
    };
  }
}

class LocalConfig {
  String sharePath;
  String watermark;
  String screenshot;
  String notice;
  double packet;
  String callKit;
  String groupSearch;
  String holdCard;
  String beian;
  int messageLimit;
  double invo; //邀请奖励
  double sign; //签到奖励

  LocalConfig(
    this.sharePath,
    this.watermark,
    this.screenshot,
    this.notice,
    this.packet,
    this.callKit,
    this.groupSearch,
    this.holdCard,
    this.beian,
    this.messageLimit,
    this.invo,
    this.sign,
  );

  static LocalConfig fromJson(Map<String, dynamic> data) {
    // 工具方法：将 dynamic 类型安全转换为 double
    double _toDouble(dynamic value) {
      if (value == null) return 0.00; // 空值默认0
      if (value is double) return value; // 已经是double，直接返回
      if (value is String) {
        // 是字符串，尝试解析为double（处理空字符串或非数字的情况）
        return double.tryParse(value) ?? 0.00;
      }
      if (value is int) return value.toDouble(); // 整数转double
      return 0.00; // 其他类型默认0
    }

    return LocalConfig(
      data['sharePath'] ?? '',
      data['watermark'] ?? '',
      data['screenshot'] ?? 'Y',
      data['notice'] ?? '',
      double.parse(data['packet'] ?? '0.00'),
      data['callKit'] ?? '',
      data['groupSearch'] ?? 'N',
      data['holdCard'] ?? 'Y',
      data['beian'] ?? '',
      data['messageLimit'] ?? 1000,
      _toDouble(data['invo']), // 用工具方法转换
      _toDouble(data['sign']), // 用工具方法转换
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sharePath': sharePath,
      'watermark': watermark,
      'screenshot': screenshot,
      'notice': notice,
      'packet': packet.toString(),
      'callKit': callKit,
      'groupSearch': groupSearch,
      'holdCard': holdCard,
      'beian': beian,
      'messageLimit': messageLimit,
      'invo': invo,
      'sign': sign,
    };
  }
}

//软件基本配置类
class SysConfig {
  String requestHost; // 接口请求主机地址（如 HTTP 接口域名）
  String requestSocket; // Socket 连接地址（如 WebSocket 地址）

  // 构造函数
  SysConfig({
    required this.requestHost,
    required this.requestSocket,
  });

  // 从 JSON 数据初始化实例
  factory SysConfig.fromJson(Map<String, dynamic> data) {
    return SysConfig(
      requestHost: data['requestHost'] ?? '', // 默认为空字符串
      requestSocket: data['requestSocket'] ?? '', // 默认为空字符串
    );
  }

  // 转换为 JSON 数据（用于存储）
  Map<String, dynamic> toJson() {
    return {
      'requestHost': requestHost,
      'requestSocket': requestSocket,
    };
  }

  // 初始化一个默认空配置的实例
  factory SysConfig.init() {
    return SysConfig.fromJson({});
  }
}
