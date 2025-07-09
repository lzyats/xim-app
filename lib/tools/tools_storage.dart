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
  );

  static LocalConfig fromJson(Map<String, dynamic> data) {
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
    };
  }
}
