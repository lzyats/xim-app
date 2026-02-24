import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui_;

import 'package:alpaca/config/app_resource.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:alpaca/tools/tools_format.dart';
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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
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
  static Widget divider(
      {double indent = 15.0,
      double height = 0.5,
      double thickness = 0.5,
      color = const Color.fromARGB(255, 232, 228, 228)}) {
    return Divider(
      color: color, // 设置分割线的颜色
      height: height, // 设置分割线的高度为2.0像素
      thickness: thickness, // 设置分割线的粗细为1.0像素
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
  static Widget timeFormat(DateTime dateTime, bool show) {
    if (!show) {
      return const Text(
        '',
      );
    }
    timeago.setLocaleMessages('en', ToolsFormat());
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
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.bold,
    double vertical = 10, // 新增vertical参数，默认值10与原padding一致
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical), // 使用vertical参数
      child: Align(
        alignment: alignment,
        child: Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }

  // 提醒文字
  static Widget tips(String value,
      {TextAlign textAlign = TextAlign.center,
      Color color = const Color(0xFF969695)}) {
    // 参数名统一为 color，默认值合法
    if (value.isEmpty) {
      return Container();
    }
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
        style: TextStyle(
            // 移除 const 修饰，允许引用变量
            color: color,
            fontSize: 12),
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
  static showAvatar(String avatar, {double size = 50, double yj = 30}) {
    if (avatar.isEmpty) {
      return SizedBox(
        height: size + 10,
        width: size + 10,
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(yj),
      child: WidgetImage(
        avatar,
        ImageType.network,
        fit: BoxFit.cover,
        height: size,
        width: size,
      ),
    );
  }

  // 显示二维码
  static showQrCode(
      {required String data,
      required String avatar,
      double? width,
      double? height}) {
    if (width != null) {
      return Container(
        //margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: PrettyQrView.data(
          data: data,
          errorCorrectLevel: QrErrorCorrectLevel.Q,
          decoration: PrettyQrDecoration(
            image: PrettyQrDecorationImage(
              image: WidgetImage.provider(avatar),
              padding: const EdgeInsets.all(10),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) => Image.asset(AppImage.error),
            ),
          ),
        ),
      );
    } else {
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
              onError: (exception, stackTrace) => Image.asset(AppImage.error),
            ),
          ),
        ),
      );
    }
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
  static Widget customRedClipper({Color color = Colors.red}) {
    // 椭圆区域
    return ClipPath(
      clipper: const _CustomClipper(search: true),
      child: Container(
        color: color,
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

/// 完全匹配UI的自定义弹窗（替代CupertinoDialogAction，实现轻度渐变）
class CustomStatusDialog extends StatelessWidget {
  final String status;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onButtonTap;

  const CustomStatusDialog({
    super.key,
    required this.status,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onButtonTap,
  });

  // 渐变/标题色逻辑（保持之前的设置）
  Decoration _getUiMatchGradientDecoration() {
    switch (status) {
      case "success":
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4, 1.0],
            colors: [Color(0xFFEBF5FF), Color(0xFFF5F9FF), Colors.white],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))
          ],
        );
      case "review":
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4, 1.0],
            colors: [Color(0xFFFFF7EB), Color(0xFFFFFAF0), Colors.white],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))
          ],
        );
      case "failed":
        return BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.4, 1.0],
            colors: [Color(0xFFF8F8F8), Color(0xFFFAFAFA), Colors.white],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))
          ],
        );
      default:
        return BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2))
            ]);
    }
  }

  Color _getTitleColor() {
    switch (status) {
      case "success":
        return const Color(0xFF1677FF);
      case "review":
        return const Color(0xFFFF9900);
      case "failed":
        return const Color(0xFF333333);
      default:
        return const Color(0xFF333333);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // 用Center+Container替代CupertinoAlertDialog的默认容器，彻底消除多余间距
      child: Container(
        // 宽度适配内容（或固定宽度，根据UI需求调整）
        width: MediaQuery.of(context).size.width * 0.85, // 占屏幕85%宽度，更紧凑
        constraints: const BoxConstraints(maxWidth: 320), // 最大宽度限制
        decoration: _getUiMatchGradientDecoration(),
        // 仅保留必要内边距（去掉多余空间）
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 高度随内容自适应
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: _getTitleColor(),
                  height: 1.2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12), // 缩小标题与描述的间距
            Text(
              description,
              style: const TextStyle(
                  fontSize: 14, color: Color(0xFF666666), height: 1.4),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // 缩小描述与按钮的间距
            SizedBox(
              width: double.infinity,
              height: 44,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                color: const Color(0xFF000000),
                borderRadius: BorderRadius.circular(18),
                onPressed: () {
                  Navigator.pop(context);
                  onButtonTap();
                },
                child: Text(buttonText,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 通用圆角框组件
class RoundedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? circular;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  const RoundedContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.circular,
    this.color,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(20),
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(circular ?? 12),
        boxShadow: boxShadow ??
            const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 2),
              )
            ],
      ),
      child: child,
    );
  }
}

class eConfirmDialog extends StatelessWidget {
  // 1. 新增可配置文本变量，设置合理预设值（与原固定文本一致）
  final String warningTitle; // 警告标题：默认"警告：清空后将无法恢复"
  final String confirmDesc; // 确认描述：默认"确定清空朋友圈所有记录？"
  final String cancelText; // 取消按钮文本：默认"取消"
  final String confirmText; // 清空按钮文本：默认"清空"

  // 确认/取消回调（保留原有逻辑）
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  // 2. 构造函数：添加新变量并设置预设值，确保兼容性
  const eConfirmDialog({
    super.key,
    // 文本变量预设值：默认使用原有固定文本，外部可按需修改
    this.warningTitle = "警告：清空后将无法恢复",
    this.confirmDesc = "确定清空朋友圈所有记录？",
    this.cancelText = "取消",
    this.confirmText = "清空",
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        constraints: const BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 3. 替换为变量：警告标题
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    warningTitle, // 原固定文本 → 变量
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  // 4. 替换为变量：确认描述
                  Text(
                    confirmDesc, // 原固定文本 → 变量
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(height: 1, color: const Color(0xFFE0E0E0)),
            Row(
              children: [
                // 5. 替换为变量：取消按钮文本
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onCancel();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8)),
                      ),
                    ),
                    child: Text(
                      cancelText, // 原固定文本 → 变量
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                ),
                Container(width: 1, height: 48, color: const Color(0xFFE0E0E0)),
                // 6. 替换为变量：清空按钮文本
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onConfirm();
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(8)),
                      ),
                    ),
                    child: Text(
                      confirmText, // 原固定文本 → 变量
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF00ABFF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
