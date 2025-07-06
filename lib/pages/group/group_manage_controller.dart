import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/pages/main/main_page.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_route.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_submit.dart';

class GroupManageController extends BaseController {
  TextEditingController nameController = TextEditingController();
  TextEditingController noticeController = TextEditingController();
  ChatGroup chatGroup = ChatGroup.init();
  late String groupId;
  // 成员总数
  String memberSize = '0';

  // 获取详情
  _onRefresh1() async {
    chatGroup = await ToolsSqlite().group.getById(groupId);
    // 更新
    _update();
  }

  // 获取详情
  _onRefresh2() async {
    chatGroup = await RequestGroup.getInfo(groupId);
    memberSize = chatGroup.memberSize;
    // 更新
    _update();
  }

  // 更新
  _update() {
    nameController.text = chatGroup.groupName;
    noticeController.text = chatGroup.notice;
    update();
  }

  // 修改头像
  Future<void> editPortrait(String portrait) async {
    if (portrait.isNotEmpty) {
      chatGroup.portrait = portrait;
      update();
      // 执行
      await RequestGroup.editPortrait(chatGroup.groupId, portrait);
    }
    // 取消
    ToolsSubmit.cancel();
  }

  // 修改群名
  Future<void> editGroupName() async {
    String groupName = nameController.text.trim();
    // 更新
    chatGroup.groupName = groupName;
    update();
    // 执行
    await RequestGroup.editGroupName(chatGroup.groupId, groupName);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 修改公告
  Future<void> editNotice() async {
    String notice = noticeController.text.trim();
    // 更新
    chatGroup.notice = notice;
    update();
    // 执行
    await RequestGroup.editNotice(chatGroup.groupId, notice);
    // 取消
    ToolsSubmit.cancel();
    // 返回
    Get.back();
  }

  // 修改公告置顶
  Future<void> editNoticeTop(String noticeTop) async {
    // 执行
    chatGroup.noticeTop = noticeTop;
    update();
    await RequestGroup.editNoticeTop(chatGroup.groupId, noticeTop);
    // 取消
    ToolsSubmit.cancel();
  }

  // 进群审核
  Future<void> editConfigAudit(String configAudit) async {
    // 执行
    chatGroup.configAudit = configAudit;
    update();
    await RequestGroup.editConfigAudit(chatGroup.groupId, configAudit);
    // 取消
    ToolsSubmit.cancel();
  }

  // 扫码进群
  Future<void> editPrivacyScan(String privacyScan) async {
    // 执行
    chatGroup.privacyScan = privacyScan;
    update();
    await RequestGroup.editPrivacyScan(chatGroup.groupId, privacyScan);
    // 取消
    ToolsSubmit.cancel();
  }

  // 搜索进群
  Future<void> editPrivacyNo(String privacyNo) async {
    // 执行
    chatGroup.privacyNo = privacyNo;
    update();
    await RequestGroup.editPrivacyNo(chatGroup.groupId, privacyNo);
    // 取消
    ToolsSubmit.cancel();
  }

  // 搜索进群
  Future<void> editPrivacyName(String privacyName) async {
    // 执行
    chatGroup.privacyName = privacyName;
    update();
    await RequestGroup.editPrivacyName(chatGroup.groupId, privacyName);
    // 取消
    ToolsSubmit.cancel();
  }

  // 禁止昵称开关
  Future<void> editConfigNickname(String configNickname) async {
    // 执行
    chatGroup.configNickname = configNickname;
    update();
    await RequestGroup.editConfigNickname(chatGroup.groupId, configNickname);
    // 取消
    ToolsSubmit.cancel();
  }

  // 全员禁言
  Future<void> editConfigSpeak(String configSpeak) async {
    // 执行
    chatGroup.configSpeak = configSpeak;
    update();
    await RequestGroup.editConfigSpeak(chatGroup.groupId, configSpeak);
    // 取消
    ToolsSubmit.cancel();
  }

  // 资源开关
  Future<void> editConfigMedia(String configMedia) async {
    // 执行
    chatGroup.configMedia = configMedia;
    update();
    await RequestGroup.editConfigMedia(chatGroup.groupId, configMedia);
    // 取消
    ToolsSubmit.cancel();
  }

  // 专属可见
  Future<void> editConfigAssign(String configAssign) async {
    // 执行
    chatGroup.configAssign = configAssign;
    update();
    await RequestGroup.editConfigAssign(chatGroup.groupId, configAssign);
    // 取消
    ToolsSubmit.cancel();
  }

  // 红包开关
  Future<void> editConfigPacket(String configPacket) async {
    // 执行
    chatGroup.configPacket = configPacket;
    update();
    await RequestGroup.editConfigPacket(chatGroup.groupId, configPacket);
    // 取消
    ToolsSubmit.cancel();
  }

  // 红包禁抢
  Future<void> editConfigReceive(String configReceive) async {
    // 执行
    chatGroup.configReceive = configReceive;
    update();
    await RequestGroup.editConfigReceive(chatGroup.groupId, configReceive);
    // 取消
    ToolsSubmit.cancel();
  }

  // 显示金额
  Future<void> editConfigAmount(String configAmount) async {
    // 执行
    chatGroup.configAmount = configAmount;
    update();
    await RequestGroup.editConfigAmount(chatGroup.groupId, configAmount);
    // 取消
    ToolsSubmit.cancel();
  }

  // 群聊头衔
  Future<void> editConfigTitle(String configTitle) async {
    // 执行
    chatGroup.configTitle = configTitle;
    update();
    await RequestGroup.editConfigTitle(chatGroup.groupId, configTitle);
    // 取消
    ToolsSubmit.cancel();
  }

  // 允许邀请
  Future<void> editConfigInvite(String configInvite) async {
    // 执行
    chatGroup.configInvite = configInvite;
    update();
    await RequestGroup.editConfigInvite(chatGroup.groupId, configInvite);
    // 取消
    ToolsSubmit.cancel();
  }

  // 成员保护
  Future<void> editConfigMember(String configMember) async {
    // 执行
    chatGroup.configMember = configMember;
    update();
    await RequestGroup.editConfigMember(chatGroup.groupId, configMember);
    // 取消
    ToolsSubmit.cancel();
  }

  // 二维码
  Future<void> editConfigScan(String configScan) async {
    // 执行
    chatGroup.configScan = configScan;
    update();
    await RequestGroup.editConfigScan(chatGroup.groupId, configScan);
    // 取消
    ToolsSubmit.cancel();
  }

  // 解散
  Future<void> dissolve() async {
    // 执行
    await RequestGroup.dissolve(chatGroup.groupId);
    // 返回
    ToolsRoute().toPage(MainPage.routeName);
    // 取消
    ToolsSubmit.cancel();
    // 提醒
    EasyLoading.showToast('解散成功');
  }

  @override
  void onInit() {
    super.onInit();
    groupId = Get.arguments;
    _onRefresh1();
    _onRefresh2();
    // 监听群聊
    subscription1 = EventSetting().event.stream.listen((model) {
      if (SettingType.group != model.setting) {
        return;
      }
      _onRefresh1();
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    noticeController.dispose();
    super.onClose();
  }
}
