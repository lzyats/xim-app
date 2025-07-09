import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/login/login_index_page.dart';
import 'package:alpaca/tools/tools_encrypt.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_request.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_upload.dart';

// 我的接口
class RequestMine {
  static String get _prefix => '/mine';

  // 获取个人详情
  static Future<LocalUser> getInfo() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get(
      '$_prefix/getInfo',
      showError: false,
    );
    // 转换
    LocalUser localUser = ajaxData.getData((data) => LocalUser.fromJson(data));
    // 存储数据
    ToolsStorage().local(value: localUser);
    // 通知
    EventSetting().event.add(SettingModel(SettingType.mine));
    return localUser;
  }

  // 设置密码
  static Future<void> setPass(
    String pass,
  ) async {
    // 密码加密
    String password = ToolsEncrypt.md5(pass);
    // 执行
    await ToolsRequest().post(
      '$_prefix/setPass',
      data: {
        'password': password,
      },
    );
    // 设置状态
    ToolsStorage().status(value: MiddleStatus.normal);
    // 提醒
    EasyLoading.showToast('设置密码成功');
  }

  // 修改昵称
  static Future<void> editNickname(String nickname) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editNickname',
      data: {
        'nickname': nickname,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改头像
  static Future<void> editPortrait(String portrait) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPortrait',
      data: {
        'portrait': portrait,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改密码
  static Future<void> editPass(String oldPwd, String newPwd) async {
    oldPwd = ToolsEncrypt.md5(oldPwd);
    newPwd = ToolsEncrypt.md5(newPwd);
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPass',
      data: {
        'oldPwd': oldPwd,
        'newPwd': newPwd,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改性别
  static Future<void> editGender(String gender) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editGender',
      data: {
        'gender': gender,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改签名
  static Future<void> editIntro(String intro) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editIntro',
      data: {
        'intro': intro,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改省市
  static Future<void> editCity(String province, String city) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editCity',
      data: {
        'province': province,
        'city': city,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 修改生日
  static Future<void> editBirthday(String birthday) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editBirthday',
      data: {
        'birthday': birthday,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 刷新用户
  static Future<void> refresh() async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/refresh',
      showError: false,
    );
  }

  // 用户注销
  static Future<void> deleted() async {
    // 执行
    await ToolsRequest().get(
      '$_prefix/deleted',
    );
    // 提醒
    EasyLoading.showToast('注销成功');
    // 跳转
    Get.offAllNamed(LoginIndexPage.routeName);
  }

  // 修改隐私
  static Future<void> editPrivacyNo(String privacyNo) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPrivacyNo',
      data: {
        'privacyNo': privacyNo,
      },
    );
  }

  // 修改隐私
  static Future<void> editPrivacyPhone(String privacyPhone) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPrivacyPhone',
      data: {
        'privacyPhone': privacyPhone,
      },
    );
  }

  // 修改隐私
  static Future<void> editPrivacyScan(String privacyScan) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPrivacyScan',
      data: {
        'privacyScan': privacyScan,
      },
    );
  }

  // 修改隐私
  static Future<void> editPrivacyCard(String privacyCard) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPrivacyCard',
      data: {
        'privacyCard': privacyCard,
      },
    );
  }

  // 修改隐私
  static Future<void> editPrivacyGroup(String privacyGroup) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editPrivacyGroup',
      data: {
        'privacyGroup': privacyGroup,
      },
    );
  }

  // 修改认证
  static Future<void> editAuth(
    String name,
    String idCard,
    String identity1,
    String identity2,
    String holdCard,
  ) async {
    identity1 = await ToolsUpload.uploadFile(identity1);
    identity2 = await ToolsUpload.uploadFile(identity2);
    if (holdCard.isNotEmpty) {
      holdCard = await ToolsUpload.uploadFile(holdCard);
    }
    // 执行
    await ToolsRequest().post(
      '$_prefix/editAuth',
      data: {
        "name": name,
        "idCard": idCard,
        "identity1": identity1,
        "identity2": identity2,
        "holdCard": holdCard
      },
    );
  }

  // 查询认证
  static Future<MineModel01> getAuth() async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().get('$_prefix/getAuth');
    // 转换
    return ajaxData.getData((data) => MineModel01.fromJson(data));
  }

  // 设置邮箱
  static Future<void> setEmail(
    String code,
    String email,
  ) async {
    // 执行
    await ToolsRequest().post(
      '$_prefix/editEmail',
      data: {
        'code': code,
        'email': email,
      },
    );
    // 提醒
    EasyLoading.showToast('修改成功');
  }

  // 发送验证码
  // 3=钱包
  // 4=邮箱
  // 5=找回
  // 9=绑定
  static Future<String> sendCode(
    String type,
  ) async {
    // 执行
    AjaxData ajaxData = await ToolsRequest().post(
      '$_prefix/sendCode',
      data: {
        'type': type,
      },
    );
    EasyLoading.showToast(ajaxData.getData((data) => data['msg']));
    // 转换
    return ajaxData.getData((data) => MineModel02.fromJson(data).code);
  }

  // 忘记密码
  static Future<void> forgot(String code, String pass) async {
    // 密码加密
    String password = ToolsEncrypt.md5(pass);
    // 执行
    await ToolsRequest().post(
      '$_prefix/forget',
      data: {
        'password': password,
        'code': code,
      },
    );
    EasyLoading.showToast('密码重置成功');
  }
}

class MineModel01 {
  // 审核状态
  String auth;
  // 审核状态
  String authLabel;
  // 审核意见
  String authReason;
  // 姓名
  String name;
  // 身份证号
  String idCard;

  MineModel01(
    this.auth,
    this.authLabel,
    this.authReason,
    this.name,
    this.idCard,
  );

  factory MineModel01.fromJson(Map<String, dynamic>? data) {
    return MineModel01(
      data?['auth'] ?? '',
      data?['authLabel'] ?? '',
      data?['authReason'] ?? '',
      data?['name'] ?? '',
      data?['idCard'] ?? '',
    );
  }
}

class MineModel02 {
  String code;
  MineModel02(this.code);

  factory MineModel02.fromJson(Map<String, dynamic>? data) {
    return MineModel02(
      data?['code'] ?? '',
    );
  }
}
