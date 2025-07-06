import 'dart:convert';

import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_;

// 数据库操作
class ToolsSqlite {
  ToolsSqlite._();
  static ToolsSqlite? _singleton;
  factory ToolsSqlite() => _singleton ??= ToolsSqlite._();

  Database? _database;

  // 初始化
  Future<Database> _initDB() async {
    String databasesPath = await getDatabasesPath();
    return await openDatabase(
      path_.join(databasesPath, AppConfig.dbName),
      version: 6,
      onCreate: (Database db, int version) async {
        var batch = db.batch();
        // 创建消息表
        await db.execute(
            'CREATE TABLE chat_msg (chatId TEXT, nickname TEXT, portrait TEXT, msgId TEXT, msgType TEXT, content TEXT, chatTalk TEXT, current TEXT, createTime TEXT, PRIMARY KEY(chatId, current))');
        // 创建历史表
        await db.execute(
            'CREATE TABLE chat_his (msgId TEXT, syncId TEXT, chatId TEXT, current TEXT, portrait TEXT , nickname TEXT, source TEXT, msgType TEXT, content TEXT, chatTalk TEXT, createTime TEXT, status TEXT, badger TEXT, requestId TEXT, PRIMARY KEY(msgId, current))');
        // 创建好友表
        await db.execute(
            'CREATE TABLE chat_friend (userId TEXT, groupId TEXT, portrait TEXT, nickname TEXT, userNo TEXT, remark TEXT, gender TEXT, intro TEXT, top TEXT, disturb TEXT, black TEXT, friendType TEXT, friendSource TEXT, current TEXT, PRIMARY KEY(userId, current))');
        // 创建群聊表
        await db.execute(
            'CREATE TABLE chat_group (groupId TEXT, groupName TEXT, groupNo TEXT, portrait TEXT, notice TEXT, noticeTop TEXT, configMember TEXT, configInvite TEXT, configSpeak TEXT, configTitle TEXT, configAudit TEXT, configMedia TEXT, configAssign TEXT, configNickname TEXT, configPacket TEXT, configAmount TEXT, configScan TEXT, configReceive TEXT, privacyNo TEXT, privacyScan TEXT, privacyName TEXT, current TEXT, memberTop TEXT, memberDisturb TEXT, memberType TEXT, memberSpeak TEXT, memberWhite TEXT, memberRemark TEXT, memberSize TEXT, memberTotal TEXT, PRIMARY KEY(groupId, current))');
        // 创建设置表
        await db.execute('CREATE TABLE chat_config (audio TEXT, notice TEXT)');
        // 创建账号表
        await db.execute(
            'CREATE TABLE chat_phone (phone TEXT, token TEXT, PRIMARY KEY(phone))');
        // 创建服务表
        await db.execute(
            'CREATE TABLE chat_robot (robotId TEXT, nickname TEXT, portrait TEXT, menu TEXT, top TEXT, disturb TEXT, PRIMARY KEY(robotId))');
        batch.commit();
      },
      onUpgrade: (Database db, int v1, int v2) async {
        if (v1 == v2) {
          return;
        }
        // 开启事物
        var batch = db.batch();
        if (v1 < 2) {
          await db.execute(
              'CREATE TABLE chat_phone (phone TEXT, token TEXT, PRIMARY KEY(phone))');
        }
        if (v1 < 4) {
          await db.execute('ALTER TABLE chat_group ADD COLUMN privacyName');
        }
        if (v1 < 5) {
          await db.execute(
              'CREATE TABLE chat_robot (robotId TEXT, nickname TEXT, portrait TEXT, menu TEXT, top TEXT, disturb TEXT, PRIMARY KEY(robotId))');
        }
        if (v1 < 6) {
          await db.execute('ALTER TABLE chat_group ADD COLUMN configScan');
        }
        // 提交事物
        batch.commit();
      },
      // eg:
      // String sql1 = 'ALTER TABLE chat_msg ADD COLUMN abc TEXT DEFAULT “123”;';
      // await db.execute(sql1);
    );
  }

  // 获取数据源
  Future<Database> get database async {
    if (_database == null || !_database!.isOpen) {
      _database = await _initDB();
    }
    return _database!;
  }

  // 聊天消息
  get msg {
    return _ChatMsgHander();
  }

  // 历史消息
  get his {
    return _ChatHisHander();
  }

  // 好友列表
  get friend {
    return _ChatFriendHander();
  }

  // 群聊列表
  get group {
    return _ChatGroupHander();
  }

  // 服务列表
  get robot {
    return _ChatRobotHander();
  }

  // 配置列表
  get config {
    return _ChatConfigHander();
  }

  // 账号列表
  get phone {
    return _ChatPhoneHander();
  }

  // 扩展处理
  get extend {
    return _ChatExtendHander();
  }
}

// 聊天消息
class _ChatMsgHander {
  // 聊天消息表
  static String tableName = 'chat_msg';
  // 写入消息
  add(ChatMsg chatMsg) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 新增
    await db.insert(
      tableName,
      chatMsg.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 删除消息
  delete(String chatId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 删除
    await db.delete(
      tableName,
      where: 'chatId = ? and current = ?',
      whereArgs: [chatId, current],
    );
  }

  // 更新详情
  update(String chatId, Map<String, Object?> values) async {
    // 查询
    String current = ToolsStorage().local().userId;
    // 连接
    Database db = await ToolsSqlite().database;
    // 更新
    await db.update(
      tableName,
      values,
      where: 'chatId = ? and current = ?',
      whereArgs: [chatId, current],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // 获取全部
  Future<List<ChatMsg>> getList() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 执行
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      columns: [
        'chatId',
        'nickname',
        'portrait',
        'msgId',
        'msgType',
        'content',
        'chatTalk',
        'createTime',
      ],
      where: 'current = ?',
      whereArgs: [current],
      orderBy: 'createTime',
    );
    if (dataList.isEmpty) {
      return [];
    }
    return dataList.map((data) => ChatMsg.fromJson(data)).toList();
  }
}

// 消息表
class ChatMsg {
  // 聊天对象
  String chatId;
  // 昵称
  String nickname;
  // 头像
  String portrait;
  // 消息id
  String msgId;
  // 消息类型
  MsgType msgType;
  // 消息内容
  Map<String, dynamic> content;
  // 聊天对象类型
  ChatTalk chatTalk;
  // 置顶
  bool top;
  // 静默
  bool disturb;
  // 自己
  bool self;
  // 创建时间
  DateTime createTime;
  // 消息对象
  Map<String, dynamic>? pushData;

  ChatMsg(
    this.chatId,
    this.nickname,
    this.portrait,
    this.msgId,
    this.msgType,
    this.content,
    this.chatTalk,
    this.createTime, {
    this.pushData,
    this.top = false,
    this.disturb = false,
    this.self = false,
  }) {
    top = ToolsStorage().top(chatId, read: true);
    disturb = ToolsStorage().disturb(chatId, read: true);
    self = ToolsStorage().local().userId == chatId;
  }

  factory ChatMsg.fromJson(Map<String, dynamic> data) {
    return ChatMsg(
      data['chatId'],
      data['nickname'],
      data['portrait'],
      data['msgId'],
      MsgType.init(data['msgType']),
      jsonDecode(data['content']),
      ChatTalk.init(data['chatTalk']),
      DateTime.fromMillisecondsSinceEpoch(int.parse(data['createTime'])),
    );
  }

  factory ChatMsg.fromChatHis(ChatHis chatHis) {
    return ChatMsg(
      chatHis.chatId,
      chatHis.nickname,
      chatHis.portrait,
      chatHis.msgId,
      chatHis.msgType,
      chatHis.content,
      chatHis.chatTalk,
      chatHis.createTime,
      pushData: chatHis.pushData,
      self: chatHis.self,
    );
  }

  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'nickname': nickname,
        'portrait': portrait,
        'msgId': msgId,
        'content': jsonEncode(content),
        'chatTalk': chatTalk.value,
        'current': ToolsStorage().local().userId,
        'createTime': createTime.millisecondsSinceEpoch.toString(),
        'msgType': pushData != null ? pushData!['msgType'] : msgType.value,
      };
}

// 历史处理
class _ChatHisHander {
  static String tableName = 'chat_his';

  // 新增消息
  add(ChatHis chatHis) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 新增
    await db.insert(
      tableName,
      chatHis.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 更新详情
  update(String chatId, Map<String, Object?> values) async {
    // 查询
    String current = ToolsStorage().local().userId;
    // 连接
    Database db = await ToolsSqlite().database;
    // 更新
    await db.update(
      tableName,
      values,
      where: 'chatId = ? and current = ?',
      whereArgs: [chatId, current],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // 通过ID查询
  Future<ChatHis?> getById(String msgId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: 'current = ? and msgId = ?',
      whereArgs: [current, msgId],
      orderBy: 'msgId desc',
      limit: 1,
    );
    if (dataList.isEmpty) {
      return null;
    }
    return ChatHis.fromJson(dataList.first);
  }

  // 分页查询
  Future<List<ChatHis>> getPager(String chatId, int page) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: 'current = ? and chatId = ?',
      whereArgs: [current, chatId],
      orderBy: 'msgId desc',
      limit: 50,
      offset: (page - 1) * 50,
    );
    if (dataList.isEmpty) {
      return [];
    }
    return dataList.map((data) => ChatHis.fromJson(data)).toList();
  }

  // 历史记录
  Future<List<ChatHis>> getRecords(
    String chatId,
    MsgType msgType,
    int page, {
    int limit = 10,
    String content = '',
  }) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    String where = 'current = ? and chatId = ? and msgType = ?';
    List<Object> whereArgs = [current, chatId, msgType.value];
    // 添加内容模糊查询
    if (content.isNotEmpty) {
      where += ' and content LIKE ?';
      whereArgs.add('%$content%');
    }
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      orderBy: 'msgId desc',
      limit: limit,
      offset: (page - 1) * limit,
    );
    if (dataList.isEmpty) {
      return [];
    }
    return dataList.map((data) => ChatHis.fromJson(data)).toList();
  }
}

class ChatHis {
  // 消息id
  String msgId;
  // 请求id
  String requestId;
  // 同步id
  String syncId;
  // 对象id
  String chatId;
  // 对象头像
  String portrait;
  // 对象昵称
  String nickname;
  // 红点（Y=红点）
  String badger;
  // 消息来源
  Map<String, dynamic> source;
  // 消息类型
  MsgType msgType;
  // 消息内容
  Map<String, dynamic> content;
  // 聊天对象类型
  ChatTalk chatTalk;
  // 消息状态（Y成功N失败R处理）
  String status;
  // 消息状态
  String statusLabel;
  // 创建时间
  DateTime createTime;
  // 是否是自己
  bool self;
  // 消息对象
  Map<String, dynamic>? pushData;

  ChatHis(
    this.msgId,
    this.requestId,
    this.syncId,
    this.chatId,
    this.portrait,
    this.nickname,
    this.source,
    this.msgType,
    this.content,
    this.chatTalk,
    this.createTime, {
    this.self = true,
    this.pushData,
    this.status = 'Y',
    this.badger = 'N',
    this.statusLabel = '成功',
  }) {
    // 群组
    if (ChatTalk.group == chatTalk) {
      String userId = source['userId'];
      String nickname = source['nickname'];
      nickname = ToolsStorage().remark(userId, value: nickname, read: true);
      source['nickname'] = nickname;
    }
  }

  factory ChatHis.fromJson(Map<String, dynamic> data) {
    String userId = ToolsStorage().local().userId;
    Map<String, dynamic> source = jsonDecode(data['source']);
    return ChatHis(
      data['msgId'],
      data['requestId'] ?? data['msgId'],
      data['syncId'],
      data['chatId'],
      data['portrait'],
      data['nickname'],
      source,
      MsgType.init(data['msgType']),
      jsonDecode(data['content']),
      ChatTalk.init(data['chatTalk']),
      DateTime.fromMillisecondsSinceEpoch(int.parse(data['createTime'])),
      self: userId == source['userId'],
      status: data['status'],
      badger: data['badger'] ?? 'N',
    );
  }

  Map<String, dynamic> toJson() => {
        'msgId': msgId,
        'requestId': requestId,
        'syncId': syncId,
        'chatId': chatId,
        'source': jsonEncode(source),
        'status': status,
        'portrait': portrait,
        'nickname': nickname,
        'badger': badger,
        'content': jsonEncode(content),
        'createTime': createTime.millisecondsSinceEpoch.toString(),
        'current': ToolsStorage().local().userId,
        'msgType': pushData != null ? pushData!['msgType'] : msgType.value,
        'chatTalk': pushData != null ? pushData!['chatTalk'] : chatTalk.value,
      };
}

// 好友表
class _ChatFriendHander {
  static String tableName = 'chat_friend';

  // 新增好友
  add(ChatFriend chatFriend) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 新增
    await db.insert(
      tableName,
      chatFriend.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 通过ID查询
  Future<ChatFriend?> getById(String userId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: 'current = ? and userId = ?',
      whereArgs: [current, userId],
      limit: 1,
    );
    if (dataList.isEmpty) {
      return null;
    }
    return ChatFriend.fromJson(dataList.first);
  }

  // 更新信息
  update(String userId, Map<String, Object?> values) async {
    // 查询
    String current = ToolsStorage().local().userId;
    // 连接
    Database db = await ToolsSqlite().database;
    // 更新
    await db.update(
      tableName,
      values,
      where: 'userId = ? and current = ?',
      whereArgs: [userId, current],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // 批量新增
  addBatch(List<ChatFriend> dataList) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 删除
    batch.delete(
      tableName,
      where: 'current = ?',
      whereArgs: [current],
    );
    // 添加
    for (var data in dataList) {
      batch.insert(
        tableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // 提交
    await batch.commit();
  }

  // 列表查询
  Future<List<ChatFriend>> getList() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> resultList = await db.query(
      tableName,
      where: 'current = ?',
      whereArgs: [current],
    );
    List<ChatFriend> dataList = [];
    if (resultList.isEmpty) {
      return dataList;
    }
    for (var data in resultList) {
      dataList.add(ChatFriend.fromJson(data));
    }
    return dataList;
  }

  // 删除
  delete(String userId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 删除
    await db.delete(
      tableName,
      where: 'userId = ? and current = ?',
      whereArgs: [userId, current],
    );
  }
}

class ChatFriend {
  // id
  String userId;
  // groupId
  String groupId;
  // 头像
  String portrait;
  // 昵称
  String nickname;
  // no
  String userNo;
  // 备注
  String remark;
  // 性别
  String gender;
  // 性别
  String genderLabel;
  // 签名
  String intro;
  // 置顶
  String top;
  // 静默
  String disturb;
  // 黑名单
  String black;
  // 好友类型
  FriendType friendType;
  // 好友来源
  FriendSource friendSource;
  // 自己
  bool self;

  ChatFriend(
    this.userId,
    this.groupId,
    this.portrait,
    this.nickname,
    this.userNo,
    this.remark,
    this.gender,
    this.genderLabel,
    this.intro,
    this.top,
    this.disturb,
    this.black,
    this.friendType,
    this.friendSource, {
    this.self = false,
  });

  factory ChatFriend.fromJson(Map<String, dynamic>? data) {
    String current = ToolsStorage().local().userId;
    String gender = data?['gender'] ?? '';
    return ChatFriend(
      data?['userId'] ?? '',
      data?['groupId'] ?? '',
      data?['portrait'] ?? '',
      data?['nickname'] ?? '',
      data?['userNo'] ?? '',
      data?['remark'] ?? '',
      gender,
      gender == '1' ? '男' : '女',
      data?['intro'] ?? '',
      data?['top'] ?? '',
      data?['disturb'] ?? '',
      data?['black'] ?? '',
      FriendType.init(data?['friendType'] ?? ''),
      FriendSource.init(data?['friendSource'] ?? ''),
      self: current == data?['userId'],
    );
  }

  factory ChatFriend.init() {
    return ChatFriend.fromJson({});
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'groupId': groupId,
        'portrait': portrait,
        'nickname': nickname,
        'userNo': userNo,
        'remark': remark,
        'gender': gender,
        'intro': intro,
        'top': top,
        'disturb': disturb,
        'black': black,
        'friendType': friendType.value,
        'friendSource': friendSource.value,
        'current': ToolsStorage().local().userId,
      };
}

// 群聊表
class _ChatGroupHander {
  static String tableName = 'chat_group';

  // 新增群聊
  add(ChatGroup chatGroup) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 添加
    await db.insert(
      tableName,
      chatGroup.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 列表查询
  Future<List<ChatGroup>> getList() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> resultList = await db.query(
      tableName,
      where: 'current = ?',
      whereArgs: [current],
    );
    List<ChatGroup> dataList = [];
    if (resultList.isEmpty) {
      return dataList;
    }
    for (var data in resultList) {
      dataList.add(ChatGroup.fromJson(data));
    }
    return dataList;
  }

  // 更新信息
  update(String groupId, Map<String, Object?> values) async {
    // 查询
    String current = ToolsStorage().local().userId;
    // 连接
    Database db = await ToolsSqlite().database;
    // 更新
    await db.update(
      tableName,
      values,
      where: 'groupId = ? and current = ?',
      whereArgs: [groupId, current],
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // 通过ID查询
  Future<ChatGroup?> getById(String groupId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: 'current = ? and groupId = ?',
      whereArgs: [current, groupId],
      limit: 1,
    );
    if (dataList.isEmpty) {
      return null;
    }
    return ChatGroup.fromJson(dataList.first);
  }

  // 批量新增
  addBatch(List<ChatGroup> dataList) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 删除
    batch.delete(
      tableName,
      where: 'current = ?',
      whereArgs: [current],
    );
    // 添加
    for (var data in dataList) {
      batch.insert(
        tableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // 提交
    await batch.commit();
  }

  // 删除
  delete(String groupId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 删除
    await db.delete(
      tableName,
      where: 'groupId = ? and current = ?',
      whereArgs: [groupId, current],
    );
  }
}

class ChatGroup {
  // 群聊ID
  String groupId;
  // 群聊名称
  String groupName;
  // 群聊编号
  String groupNo;
  // 群聊头像
  String portrait;
  // 通知公告
  String notice;
  // 公告置顶
  String noticeTop;
  // 成员保护
  String configMember;
  // 成员邀请
  String configInvite;
  // 全员禁言
  String configSpeak;
  // 群聊头衔
  String configTitle;
  // 群聊审核
  String configAudit;
  // 多媒体开关
  String configMedia;
  // 专属可见
  String configAssign;
  // 昵称开关
  String configNickname;
  // 红包开关
  String configPacket;
  // 金额显示
  String configAmount;
  // 红包禁抢
  String configScan;
  // 二维码
  String configReceive;
  // 隐私开关
  String privacyNo;
  // 隐私开关
  String privacyScan;
  // 隐私开关
  String privacyName;
  // 置顶
  String memberTop;
  // 静默
  String memberDisturb;
  // 成员
  MemberType memberType;
  // 禁言
  String memberSpeak;
  // 白名单
  String memberWhite;
  // 备注
  String memberRemark;
  // 成员总数
  String memberSize;
  // 成员容量
  String memberTotal;

  ChatGroup(
    this.groupId,
    this.groupName,
    this.groupNo,
    this.portrait,
    this.notice,
    this.noticeTop,
    this.configMember,
    this.configInvite,
    this.configSpeak,
    this.configTitle,
    this.configAudit,
    this.configMedia,
    this.configAssign,
    this.configNickname,
    this.configPacket,
    this.configAmount,
    this.configScan,
    this.configReceive,
    this.privacyNo,
    this.privacyScan,
    this.privacyName,
    this.memberTop,
    this.memberDisturb,
    this.memberType,
    this.memberSpeak,
    this.memberWhite,
    this.memberRemark,
    this.memberSize,
    this.memberTotal,
  );

  factory ChatGroup.fromJson(Map<String, dynamic>? data) {
    return ChatGroup(
      data?['groupId'] ?? '',
      data?['groupName'] ?? '',
      data?['groupNo'] ?? '',
      data?['portrait'] ?? '',
      data?['notice'] ?? '',
      data?['noticeTop'] ?? 'N',
      data?['configMember'] ?? '',
      data?['configInvite'] ?? '',
      data?['configSpeak'] ?? '',
      data?['configTitle'] ?? '',
      data?['configAudit'] ?? '',
      data?['configMedia'] ?? '',
      data?['configAssign'] ?? '',
      data?['configNickname'] ?? '',
      data?['configPacket'] ?? '',
      data?['configAmount'] ?? '',
      data?['configScan'] ?? 'Y',
      data?['configReceive'] ?? '',
      data?['privacyNo'] ?? '',
      data?['privacyScan'] ?? '',
      data?['privacyName'] ?? '',
      data?['memberTop'] ?? '',
      data?['memberDisturb'] ?? '',
      MemberType.init(data?['memberType'] ?? ''),
      data?['memberSpeak'] ?? '',
      data?['memberWhite'] ?? '',
      data?['memberRemark'] ?? '',
      data?['memberSize'] ?? '0',
      data?['memberTotal'] ?? '0',
    );
  }

  factory ChatGroup.init() {
    return ChatGroup.fromJson({});
  }

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'groupName': groupName,
        'groupNo': groupNo,
        'portrait': portrait,
        'notice': notice,
        'noticeTop': noticeTop,
        'configMember': configMember,
        'configInvite': configInvite,
        'configSpeak': configSpeak,
        'configTitle': configTitle,
        'configAudit': configAudit,
        'configMedia': configMedia,
        'configAssign': configAssign,
        'configNickname': configNickname,
        'configPacket': configPacket,
        'configAmount': configAmount,
        'configScan': configScan,
        'configReceive': configReceive,
        'privacyNo': privacyNo,
        'privacyScan': privacyScan,
        'privacyName': privacyName,
        'current': ToolsStorage().local().userId,
        "memberTop": memberTop,
        "memberDisturb": memberDisturb,
        "memberType": memberType.value,
        "memberSpeak": memberSpeak,
        "memberWhite": memberWhite,
        "memberRemark": memberRemark,
        "memberSize": memberSize,
        "memberTotal": memberTotal
      };
}

// 服务表
class _ChatRobotHander {
  static String tableName = 'chat_robot';

  // 列表查询
  Future<List<ChatRobot>> getList() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    List<Map<String, dynamic>> resultList = await db.query(
      tableName,
    );
    List<ChatRobot> dataList = [];
    if (resultList.isEmpty) {
      return dataList;
    }
    for (var data in resultList) {
      dataList.add(ChatRobot.fromJson(data));
    }
    return dataList;
  }

  // 通过ID查询
  Future<ChatRobot?> getById(String robotId) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    List<Map<String, dynamic>> dataList = await db.query(
      tableName,
      where: 'robotId = ?',
      whereArgs: [robotId],
      limit: 1,
    );
    if (dataList.isEmpty) {
      return null;
    }
    return ChatRobot.fromJson(dataList.first);
  }

  // 批量新增
  addBatch(List<ChatRobot> dataList) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 批量
    Batch batch = db.batch();
    // 删除
    batch.delete(
      tableName,
    );
    // 添加
    for (var data in dataList) {
      batch.insert(
        tableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    // 提交
    await batch.commit();
  }
}

class ChatRobot {
  String robotId;
  String nickname;
  String portrait;
  String menu;
  String top;
  String disturb;

  ChatRobot(
    this.robotId,
    this.nickname,
    this.portrait,
    this.menu,
    this.top,
    this.disturb,
  );

  factory ChatRobot.fromJson(Map<String, dynamic> data) {
    return ChatRobot(
      data['robotId'] ?? '',
      data['nickname'] ?? '',
      data['portrait'] ?? '',
      data['menu'] ?? '[]',
      data['top'] ?? 'N',
      data['disturb'] ?? 'N',
    );
  }

  Map<String, dynamic> toJson() => {
        'robotId': robotId,
        'nickname': nickname,
        'portrait': portrait,
        'menu': menu,
        'top': top,
        'disturb': disturb,
      };
}

// 设置表
class _ChatConfigHander {
  static String tableName = 'chat_config';

  // 查询
  Future<ChatConfig> getConfig() async {
    // 连接
    Database db = await ToolsSqlite().database;
    List<Map<String, dynamic>> resultList = await db.query(
      tableName,
    );
    ChatConfig config = ChatConfig.fromJson({});
    if (resultList.isEmpty) {
      return config;
    }
    return ChatConfig.fromJson(resultList.first);
  }

  // 更新信息
  update(String label, String value) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 更新
    await db.update(
      tableName,
      {label: value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

class ChatConfig {
  // 声音
  String audio;
  // 通知
  String notice;

  ChatConfig(
    this.audio,
    this.notice,
  );

  factory ChatConfig.fromJson(Map<String, dynamic> data) {
    return ChatConfig(
      data['audio'] ?? 'Y',
      data['notice'] ?? 'Y',
    );
  }

  Map<String, dynamic> toJson() => {
        'audio': audio,
        'notice': notice,
      };
}

class _ChatPhoneHander {
  //
  // static String tableName = 'chat_phone';
}

class ChatPhone {
  // 声音
  String phone;
  // 通知
  String token;

  ChatPhone(
    this.phone,
    this.token,
  );

  factory ChatPhone.fromJson(Map<String, dynamic> data) {
    return ChatPhone(
      data['phone'] ?? '',
      data['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'token': token,
      };
}

class _ChatExtendHander {
  static String tableHis = 'chat_his';
  static String tableMsg = 'chat_msg';

  // 清空消息
  clearMsg(String chatId, {bool delete = true}) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 删除
    batch.delete(
      tableHis,
      where: 'chatId = ? and current = ?',
      whereArgs: [chatId, current],
    );
    // 删除
    if (delete) {
      batch.delete(
        tableMsg,
        where: 'chatId = ? and current = ?',
        whereArgs: [chatId, current],
      );
    }
    // 更新
    else {
      batch.update(
        tableMsg,
        {
          'msgType': MsgType.text.value,
          'content': jsonEncode({'data': ''}),
        },
        where: 'chatId = ? and current = ?',
        whereArgs: [chatId, current],
      );
    }
    // 提交
    await batch.commit();
  }

  // 删除消息
  deleteMsg(String chatId, List<String> messageList) async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 删除
    for (var msgId in messageList) {
      batch.delete(
        tableHis,
        where: 'msgId = ? and current = ?',
        whereArgs: [msgId, current],
      );
    }
    await batch.commit();
    // 刷新消息
    await _refreshMsg([chatId]);
  }

  // 批量新增
  void addBatch(List<ChatHis> messageList, String requestId) async {
    if (messageList.isEmpty) {
      return;
    }
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 添加
    for (var chatHis in messageList) {
      batch.insert(
        tableHis,
        chatHis.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    // 提交
    await batch.commit();
    // 查询
    List<Map<String, dynamic>> requestList = await db.query(
      tableHis,
      columns: ['chatId'],
      where: 'current = ? and requestId = ?',
      whereArgs: [current, requestId],
      groupBy: 'chatId',
    );
    Set<String> chatList = {};
    for (var request in requestList) {
      chatList.add(request['chatId']);
    }
    // 刷新消息
    await _refreshMsg(chatList.toList());
  }

  // 刷新消息
  _refreshMsg(List<String> chatList) async {
    if (chatList.isEmpty) {
      return;
    }
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 条件
    String query = chatList.map((chatId) => chatId).join(',');
    // 查询
    List<Map<String, dynamic>> dataList = await db.query(
      tableHis,
      groupBy: 'chatId',
      columns: [
        'chatId',
        'nickname',
        'portrait',
        'max(msgId) as msgId',
        'msgType',
        'content',
        'chatTalk',
        'createTime',
        '$current as current',
      ],
      where: 'current = ? and chatId in ($query)',
      whereArgs: [current],
    );
    Map<String, Map<String, Object?>> dataMap = {};
    for (var data in dataList) {
      dataMap[data['chatId']] = data;
    }
    // 时间
    String createTime = DateTime.now().millisecondsSinceEpoch.toString();
    // 批量
    Batch batch = db.batch();
    for (var chatId in chatList) {
      if (dataMap.containsKey(chatId)) {
        // 插入
        batch.insert(
          tableMsg,
          dataMap[chatId]!,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        // 更新
        batch.update(
          tableMsg,
          {
            'msgType': MsgType.text.value,
            'content': jsonEncode({'data': ''}),
            'createTime': createTime,
          },
          where: 'current = ? and chatId = ?',
          whereArgs: [current, chatId],
          conflictAlgorithm: ConflictAlgorithm.ignore,
        );
      }
    }
    // 提交
    await batch.commit();
  }

  // 获取脚标
  Future<List<Map<String, dynamic>>> getBadger() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 查询
    List<Map<String, dynamic>> messageList = await db.query(
      tableMsg,
      columns: [
        'chatId',
      ],
      where: 'current = ?',
      whereArgs: [current],
    );
    String query = messageList.map((map) => map['chatId']).join(',');
    // 查询
    List<Map<String, dynamic>> dataList = await db.query(
      tableHis,
      columns: [
        'chatId',
        'count(msgId) as value',
      ],
      where: 'current = ? and badger = ? and chatId in ($query)',
      whereArgs: [current, 'Y'],
      groupBy: 'chatId',
    );
    return dataList;
  }

  // 清空消息
  clearAll() async {
    // 连接
    Database db = await ToolsSqlite().database;
    // 查询
    String current = ToolsStorage().local().userId;
    // 批量
    Batch batch = db.batch();
    // 删除
    batch.delete(
      tableHis,
      where: 'current = ?',
      whereArgs: [current],
    );
    // 删除
    batch.delete(
      tableMsg,
      where: 'current = ?',
      whereArgs: [current],
    );
    // 提交
    await batch.commit();
  }
}
