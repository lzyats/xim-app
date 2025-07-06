import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui_;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/pages/friend/friend_search_page.dart';
import 'package:alpaca/pages/group/group_create_page.dart';
import 'package:alpaca/pages/group/group_search_page.dart';
import 'package:alpaca/pages/wallet/wallet_payment_page.dart';
import 'package:alpaca/pages/wallet/wallet_qrcode_page.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_time.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:alpaca/widgets/widget_keyboard.dart';
import 'package:alpaca/widgets/widget_popup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;
import 'package:video_compress/video_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

double _iconSize = 20;

// 公共组件
class WidgetCommon {
  // 扩展
  static WidgetPopup buildAction() {
    return WidgetPopup(
      dataList: [
        PopupModel(
          '添加好友',
          Icon(
            AppFonts.ec84,
            color: Colors.indigo,
            size: _iconSize,
          ),
          onTap: () {
            Get.toNamed(FriendSearchPage.routeName);
          },
        ),
        PopupModel(
          '搜索群聊',
          Icon(
            AppFonts.e601,
            color: Colors.purple,
            size: _iconSize,
          ),
          onTap: () {
            Get.toNamed(GroupSearchPage.routeName);
          },
        ),
        PopupModel(
          '新建群聊',
          Icon(
            AppFonts.e630,
            color: Colors.green,
            size: _iconSize,
          ),
          onTap: () {
            Get.toNamed(GroupCreatePage.routeName);
          },
        ),
        PopupModel(
          '扫一扫',
          Icon(
            AppFonts.e60c,
            color: Colors.orange,
            size: _iconSize,
          ),
          onTap: () async {
            bool result = await ToolsPerms.camera();
            if (!result) {
              return;
            }
            ToolsScan.scan();
          },
        ),
        PopupModel(
          '收款码',
          Icon(
            AppFonts.e66c,
            color: Colors.blue,
            size: _iconSize,
          ),
          onTap: () {
            Get.toNamed(WalletQrCodePage.routeName);
          },
        ),
      ],
    );
  }

  // widgit转图片
  static Future<Uint8List> widgetToImage(GlobalKey globalKey) async {
    Completer<Uint8List> completer = Completer();
    BuildContext? context = globalKey.currentContext;
    RenderRepaintBoundary render =
        context!.findRenderObject() as RenderRepaintBoundary;
    ui_.Image image =
        await render.toImage(pixelRatio: View.of(context).devicePixelRatio);
    ByteData? byteData =
        await image.toByteData(format: ui_.ImageByteFormat.png);
    completer.complete(byteData?.buffer.asUint8List());
    return completer.future;
  }

  // 保存图片
  static Future<String> saveImage(
    String filePath, {
    String suffix = 'png',
  }) async {
    var appDocDir = await getTemporaryDirectory();
    String savePath = '${appDocDir.path}/${const Uuid().v8()}.$suffix';
    // 网络地址
    await Dio().download(filePath, savePath);
    // 保存
    await ImageGallerySaver.saveFile(savePath);
    return savePath;
  }

  // 保存文件
  static Future<String> saveFile(String filePath) async {
    var appDocDir = await getApplicationDocumentsDirectory();
    String savePath = '${appDocDir.path}/${const Uuid().v8()}';
    // 网络地址
    if (ToolsRegex.isUrl(filePath)) {
      await Dio().download(filePath, savePath);
    }
    // 本地地址
    else {
      await File(filePath).copy(savePath);
    }
    return savePath;
  }

  // 计算大小
  static Future<Map<String, dynamic>> calculateImage(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    int? height = image?.height;
    int? width = image?.width;
    return {'height': height ?? 200, 'width': width ?? 200};
  }

  // 计算大小
  static Future<Map<String, dynamic>> calculateBytes(Uint8List bytes) async {
    final image = img.decodeImage(bytes);
    int? height = image?.height;
    int? width = image?.width;
    return {'height': height ?? 200, 'width': width ?? 200};
  }

  // 计算大小
  static Future<Map<String, dynamic>> calculateVideo(String filePath) async {
    MediaInfo info = await VideoCompress.getMediaInfo(filePath);
    if (info.filesize! > AppConfig.videoSize * 1024 * 1024) {
      // 提醒
      String errmsg = '视频文件不能大于${AppConfig.videoSize}M哦';
      EasyLoading.showToast(errmsg);
      throw Exception(errmsg);
    }
    int? height = info.height;
    int? width = info.width;
    return {'height': height ?? 200, 'width': width ?? 200};
  }

  // 加载中
  static Widget loading() {
    return const Center(child: CircularProgressIndicator());
  }

  // 没有数据
  static Widget none() {
    return const Center(
      child: Icon(
        AppFonts.e610,
        color: Colors.black26,
        size: 40,
      ),
    );
  }

  // 箭头
  static Widget arrow() {
    return const Opacity(
      opacity: 0.3,
      child: Icon(Icons.keyboard_arrow_right),
    );
  }

  // 分割线
  static Widget divider({double indent = 15.0}) {
    return Divider(
      color: const Color.fromARGB(255, 232, 228, 228), // 设置分割线的颜色
      height: 0.5, // 设置分割线的高度为2.0像素
      thickness: 0.5, // 设置分割线的粗细为1.0像素
      indent: indent, // 设置分割线的缩进为16.0像素
      endIndent: indent, // 设置分割线结束位置的缩进为16.0像素
    );
  }

  // 边框
  static Widget border({bool enable = true}) {
    if (!enable) {
      return Container();
    }
    return Container(
      height: 10,
      color: Colors.grey[100],
    );
  }

  // 时间
  static Widget time(DateTime dateTime, bool show) {
    if (!show) {
      return const Text(
        '',
      );
    }
    timeago.setLocaleMessages('en', ToolsTime());
    return Text(
      timeago.format(dateTime),
      style: const TextStyle(fontSize: 12, color: Color(0xFFa9a9a9)),
    );
  }

  // 相册汉化
  static String pathName(AssetPathEntity path) {
    String label;
    switch (path.name) {
      case 'Screenshots':
        label = '最近';
        break;
      case 'Recents':
      case 'Recent':
        label = '全部';
        break;
      case 'Videos':
      case 'Movies':
        label = '视频';
        break;
      case 'Camera':
        label = '相机';
        break;
      case 'Pictures':
      case 'paintpad':
        label = '相册';
        break;
      case 'Selfies':
        label = '自拍';
        break;
      case 'Live Photos':
        label = '实况图片';
        break;
      case 'Animated':
        label = '动图';
        break;
      case 'Alipay':
        label = '支付宝';
        break;
      case 'WeiXin':
        label = '微信';
        break;
      case 'WeixinWork':
        label = '企业微信';
        break;
      default:
        label = '其他';
        break;
    }

    return label;
  }

  // 计算长度
  static double textSize(String text, {double width = 20.00}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width + width;
  }

  // 提醒文字
  static Widget label(
    String value, {
    Alignment alignment = Alignment.centerLeft,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: alignment,
        child: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // 提醒文字
  static Widget tips(
    String value, {
    TextAlign textAlign = TextAlign.center,
  }) {
    Alignment alignment = Alignment.center;
    if (textAlign == TextAlign.left) {
      alignment = Alignment.centerLeft;
    } else if (textAlign == TextAlign.right) {
      alignment = Alignment.centerRight;
    }
    return Align(
      alignment: alignment,
      child: Text(
        value,
        style: const TextStyle(
          color: ui_.Color.fromARGB(255, 150, 150, 149),
        ),
        textAlign: textAlign,
      ),
    );
  }

  // 无样式
  static PickerStyle pickerStyle() {
    PickerStyle style = PickerStyle();
    style.commitButton = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        left: 12,
        right: 22,
      ),
      child: const Text(
        '确定',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
    style.textSize = 20.0;
    return style;
  }

  // 显示头像
  static showAvatar(String avatar, {double size = 50}) {
    if (avatar.isEmpty) {
      return SizedBox(
        height: size + 10,
        width: size + 10,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: WidgetImage(
        avatar,
        ImageType.network,
        fit: BoxFit.cover,
        width: size,
        height: size,
      ),
    );
  }

  // 显示二维码
  static showQrCode({required String data, required String avatar}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: PrettyQrView.data(
        data: data,
        errorCorrectLevel: QrErrorCorrectLevel.Q,
        decoration: PrettyQrDecoration(
          image: PrettyQrDecorationImage(
            image: WidgetImage.provider(avatar),
            padding: const EdgeInsets.all(10),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // 显示安全键盘
  static showKeyboard(
    BuildContext context, {
    String title = '',
    bool verify = true,
    bool operate = true,
    required Function(String) onPressed,
  }) {
    if (verify && 'N' == ToolsStorage().local().payment) {
      Get.toNamed(WalletPaymentPage.routeName);
      // 提醒
      EasyLoading.showToast('请先设置支付密码');
      return;
    }
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: WidgetKeyboard(
            operate: operate,
            title: title,
            onPressed: onPressed,
          ),
        );
      },
    );
  }

  // 自定义椭圆区域
  static Widget customRedClipper() {
    // 椭圆区域
    return ClipPath(
      clipper: const _CustomClipper(search: true),
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: 50,
      ),
    );
  }

  // 自定义椭圆区域
  static Widget customClipper() {
    return ClipPath(
      // 椭圆区域
      clipper: const _CustomClipper(),
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: 100,
        child: const Icon(
          AppFonts.e664,
          size: 35,
        ),
      ),
    );
  }
}

// 椭圆区域
class _CustomClipper extends CustomClipper<Path> {
  final bool search;
  const _CustomClipper({
    this.search = false,
  });
  @override
  Path getClip(Size size) {
    var path = Path();
    if (search) {
      path.lineTo(0, size.height - 35);
      path.quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 35,
      );
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(0, 35);
      // 上面的半圆
      path.quadraticBezierTo(
        size.width / 2,
        -35,
        size.width,
        35,
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
