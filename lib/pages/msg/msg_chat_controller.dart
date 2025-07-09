import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/msg/msg_index_controller.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class MsgChatController extends BaseController {
  // 键盘
  final KeyboardVisibilityController keyboard = KeyboardVisibilityController();
  // 文本输入
  final TextEditingController textController = TextEditingController();
  // 消息存储
  late Map<String, ChatHis> _dataMap;
  // 消息存储
  final Map<String, DateTime> _timeMap = {};
  // 当前对象
  late LocalChat localChat;
  // 当前对象
  LocalUser localUser = ToolsStorage().local();
  // 初始化声音
  final AudioPlayer audioPlayer = AudioPlayer();
  // 滚动组件
  final AutoScrollController scrollController = AutoScrollController();
  // 刷新组件
  final PagingController<int, ChatHis> pagingController = PagingController(
    firstPageKey: 1,
  );
  // 通知标题
  late Rx<RichText> chatTitle = RichText(text: const TextSpan()).obs;
  // @组件
  final RxList<String> atList = RxList();
  // 通知组件
  late RxString configNotice = ''.obs;
  // 头衔组件
  late RxString configTitle = ''.obs;
  // 金额组件
  late RxString configAmount = ''.obs;
  // 禁言组件
  late RxString configSpeak = ''.obs;
  // 输入框组件
  late RxString configInput = ''.obs;
  // 媒体组件
  late RxString configMedia = ''.obs;
  // 红包组件
  late RxString configPacket = ''.obs;
  // 可领组件
  late RxString configReceive = ''.obs;
  // 管理组件
  late RxString configManager = ''.obs;
  // 详情组件
  late RxString configDetails = ''.obs;
  // 菜单组件
  late RxString configMenu = '[]'.obs;
  // 多选
  late RxBool configCheckBox = false.obs;
  // 引用
  final RxMap<String, dynamic> configReply = RxMap();
  // 多选集合
  final RxMap<String, ChatHis> checkboxList = RxMap();

  @override
  void onInit() {
    super.onInit();
    // 初始化
    _init();
    // 监听分页
    _listenPage();
    // 监听消息
    _listenMessage();
    // 监听设置
    _listenSetting();
  }

  // 初始化
  _init({bool refresh = true}) {
    // 通知组件
    configNotice.value = '';
    // 头衔组件
    configTitle.value = 'N';
    // 金额组件
    configAmount.value = 'Y';
    // 禁言组件
    configSpeak.value = 'N';
    // 媒体组件
    configMedia.value = 'Y';
    // 红包组件
    configPacket.value = 'Y';
    // 可领组件
    configReceive.value = 'Y';
    // 管理组件
    configManager.value = 'N';
    // 详情组件
    configDetails.value = 'Y';
    // 输入框组件
    configInput.value = 'Y';
    // 自定义菜单
    configMenu.value = '[]';
    // 刷新
    if (refresh) {
      // 清空
      _dataMap = {};
      // 清空
      atList.clear();
      // 清空
      checkboxList.clear();
      // 清空
      localChat = ToolsStorage().chat();
      // 清空
      pagingController.refresh();
      // 草稿
      textController.text = ToolsStorage().draft(localChat.chatId, read: true);
      // 引用
      configReply.value = ToolsStorage().reply(localChat.chatId, read: true);
      // 标题组件
      _setTitle(localChat.chatTalk, localChat.title);
    }
  }

  // 退回
  _doBack() {
    // 刷新
    if (Get.isRegistered<MsgIndexController>()) {
      MsgIndexController controller = Get.find<MsgIndexController>();
      controller.doRead(localChat.chatId);
    }
    // 草稿
    String text = textController.text.trim();
    if (text.isNotEmpty) {
      ToolsStorage().draft(localChat.chatId, value: text);
    } else {
      ToolsStorage().draft(localChat.chatId);
    }
    // 引用
    if (configReply.isNotEmpty) {
      ToolsStorage().reply(localChat.chatId, value: configReply);
    } else {
      ToolsStorage().reply(localChat.chatId);
    }
    textController.dispose();
  }

  // 监听分页
  _listenPage() {
    pagingController.addPageRequestListener((pageKey) async {
      List<ChatHis> dataList = await ToolsSqlite().his.getPager(
            localChat.chatId,
            pageKey,
          );
      // 没有数据了
      if (dataList.isEmpty) {
        pagingController.appendLastPage([]);
        return;
      }
      // 组织数据
      for (var chatHis in dataList) {
        _dataMap[chatHis.msgId] = chatHis;
        // 增加@消息
        _addFloating(chatHis);
      }
      // 追加数据
      pagingController.appendPage(dataList, pageKey + 1);
    });
  }

  // 监听消息
  _listenMessage() {
    subscription1?.cancel();
    subscription1 = EventMessage().listenHis.stream.listen((chatHis) {
      // 其他消息
      if (localChat.chatId != chatHis.chatId) {
        return;
      }
      // 获取索引
      int index = -1;
      // 获取数据
      List<ChatHis> dataList = pagingController.itemList ?? [];
      // Y成功N失败
      if ('R' != chatHis.status) {
        // 查询
        ChatHis? chatHis0 = _dataMap[chatHis.requestId];
        if (chatHis0 != null) {
          // 获取索引
          index = dataList.indexOf(chatHis0);
        }
        // 查询
        DateTime? createTime = _timeMap[chatHis.requestId];
        if (createTime != null) {
          chatHis.createTime = createTime;
          _timeMap.remove(chatHis.requestId);
        }
        // 查询
        chatHis0 = _dataMap[chatHis.msgId];
        if (chatHis0 != null) {
          // 获取索引
          index = dataList.indexOf(chatHis0);
        }
        // 查询
        createTime = _timeMap[chatHis.msgId];
        if (createTime != null) {
          chatHis.createTime = createTime;
          _timeMap.remove(chatHis.msgId);
        }
      }
      // 处理
      else {
        _timeMap[chatHis.requestId] = chatHis.createTime;
      }
      // 放入map
      _dataMap[chatHis.msgId] = chatHis;
      // 新消息
      if (index == -1) {
        // 放入列表
        pagingController.itemList = [chatHis] + dataList;
        // 增加@消息
        _addFloating(chatHis);
      }
      // 更新消息
      else {
        dataList[index] = chatHis;
        dataList = List.from(dataList);
        pagingController.itemList = dataList;
      }
      // 提醒
      if (chatHis.status == 'N') {
        EasyLoading.showToast(chatHis.statusLabel);
      }
    });
  }

  // 处理@消息
  _addFloating(ChatHis chatHis) {
    if (MsgType.at != chatHis.msgType) {
      return;
    }
    if (chatHis.content['status'] == 'Y') {
      atList.add(chatHis.msgId);
    }
  }

  // 处理@消息
  doFloating() async {
    // 判断
    if (atList.isEmpty) {
      return;
    }
    String msgId = atList.removeLast();
    // 查找
    ChatHis? chatHis = _dataMap[msgId];
    if (chatHis == null) {
      return;
    }
    // 获取数据
    List<ChatHis> dataList = pagingController.itemList ?? [];
    int index = dataList.indexOf(chatHis);

    if (index == -1) {
      return;
    }
    // 处理消息
    chatHis.content['status'] = 'N';
    // 更新数据
    await ToolsSqlite().his.add(chatHis);
    // 跳转
    scrollController.scrollToIndex(index);
  }

  // 监听设置
  _listenSetting() async {
    // 群组
    if (ChatTalk.group == localChat.chatTalk) {
      // 设置群聊
      _setGroup(localChat.chatId);
    }
    // 服务号
    else if (ChatTalk.robot == localChat.chatTalk) {
      // 设置群聊
      _setRobot(localChat.chatId);
    }
    // 订阅
    subscription2?.cancel();
    subscription2 = EventSetting().event.stream.listen((model) async {
      // 删除消息
      if (SettingType.remove == model.setting) {
        String chatId = model.primary;
        if (chatId != localChat.chatId) {
          return;
        }
        // 获取数据
        List<ChatHis> dataList = pagingController.itemList ?? [];
        List<String>? messageList = model.dataList;
        for (var msgId in messageList!) {
          // 重复消息
          if (!_dataMap.containsKey(msgId)) {
            continue;
          }
          // 移除
          dataList.remove(_dataMap[msgId]);
          // 移除
          _dataMap.remove(msgId);
        }
        pagingController.itemList = List.from(dataList);
      }
      // 清空消息
      else if (SettingType.clear == model.setting) {
        String current = ToolsStorage().chat().chatId;
        String chatId = model.primary;
        // 校验
        if (chatId != current) {
          return;
        }
        // 移除
        pagingController.itemList?.clear();
        // 移除
        _dataMap.clear();
        // 刷新
        pagingController.refresh();
      }
      // 我的
      else if (SettingType.mine == model.setting) {
        // 重置信息
        localUser = ToolsStorage().local();
        // 更新对象
        if (localUser.userId != localChat.chatId) {
          return;
        }
        _setTitle(ChatTalk.friend, localUser.nickname);
      }
      // 好友
      else if (SettingType.friend == model.setting) {
        if (localChat.chatId != model.primary) {
          return;
        }
        // 查询好友
        ChatFriend? friend = await ToolsSqlite().friend.getById(model.primary);
        if (friend == null) {
          return;
        }
        // 更新对象
        String nickname = ToolsStorage().remark(
          friend.userId,
          value: friend.nickname,
          read: true,
        );
        _setTitle(ChatTalk.friend, nickname);
      }
      // 群聊
      else if (SettingType.group == model.setting) {
        if (localChat.chatId != model.primary) {
          return;
        }
        // 设置群聊
        _setGroup(model.primary);
      }
    });
  }

  // 设置群聊
  _setGroup(String groupId) async {
    // 加载
    _init(refresh: false);
    // 查询群聊
    ChatGroup? group = await ToolsSqlite().group.getById(groupId);
    if (group == null) {
      return;
    }
    // 通知标题
    _setTitle(ChatTalk.group, group.groupName);
    // 通知组件
    if ('Y' == group.noticeTop) {
      configNotice.value = group.notice;
    }
    // 头衔组件
    configTitle.value = group.configTitle;
    // 金额组件
    configAmount.value = group.configAmount;
    // 禁言组件
    if (MemberType.normal == group.memberType) {
      if ('Y' == group.configSpeak || 'Y' == group.memberSpeak) {
        configSpeak.value = 'Y';
      }
    }
    // 媒体组件
    if (MemberType.normal == group.memberType) {
      configMedia.value = group.configMedia;
    }
    // 红包组件
    if (MemberType.normal == group.memberType) {
      configPacket.value = group.configPacket;
    }
    // 可领组件
    if (MemberType.normal == group.memberType) {
      if ('Y' == group.configReceive) {
        configReceive.value = group.memberWhite;
      }
    }
    // 管理组件
    if (MemberType.normal != group.memberType) {
      configManager.value = 'Y';
    }
    // 详情组件
    if (MemberType.normal != group.memberType) {
      configDetails.value = 'Y';
    } else {
      configDetails.value = group.configMember == 'Y' ? 'N' : 'Y';
    }
  }

  // 设置服务号
  _setRobot(String robotId) async {
    // 查询服务号
    ChatRobot? robot = await ToolsSqlite().robot.getById(robotId);
    if (robot == null) {
      return;
    }
    // 在线客服
    if (AppConfig.robotId == localChat.chatId) {
      return;
    }
    configInput.value = 'N';
    configMenu.value = robot.menu;
    // 通知标题
    _setTitle(ChatTalk.robot, robot.nickname);
  }

  // 通知标题
  _setTitle(ChatTalk chatTalk, String title) {
    // 重置
    localChat = ToolsStorage().chat();
    // 标题
    chatTitle.value = RichText(
      text: TextSpan(
        children: [
          if (ChatTalk.group == chatTalk)
            const TextSpan(
              text: '[群] ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          if (ChatTalk.robot == chatTalk)
            const TextSpan(
              text: '[官] ',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          TextSpan(
            text: title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    scrollController.dispose();
    pagingController.dispose();
    // 返回
    _doBack();
    // 关闭
    super.onClose();
  }
}
