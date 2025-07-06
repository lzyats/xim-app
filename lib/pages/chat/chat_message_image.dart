import 'dart:io';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_perms.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_scan.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_upload.dart';
import 'package:alpaca/widgets/widget_bottom.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_image.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scan/scan.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

double maxHeight = 400;
double minHeight = 50;
double maxWidth = 180;

// 聊天=消息=图片
class ChatMessageImage extends StatelessWidget {
  final Map<String, dynamic> content;
  final String status;
  final String msgId;
  final double? size;
  final List<ChatHis>? messageList;

  const ChatMessageImage(
    this.content, {
    super.key,
    this.messageList,
    this.status = 'Y',
    this.msgId = '0',
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (size != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: WidgetImage(
          content['data'],
          ImageType.network,
          fit: BoxFit.cover,
          width: size!,
          height: size!,
          gallery: true,
        ),
      );
    }
    String data = _formatData(content);
    return InkWell(
      onTap: () {
        List<Map<String, dynamic>> dataList = [];
        int initialPage = 1;
        if (messageList != null) {
          for (var message in messageList!) {
            if (MsgType.image == message.msgType) {
              dataList.insert(0, message.content);
              if (msgId == message.msgId) {
                initialPage = dataList.length;
              }
            }
          }
        } else {
          dataList.add(content);
        }
        Get.to(
          ChatMessageImageShow(dataList, dataList.length - initialPage),
          transition: Transition.topLevel,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                minHeight: minHeight,
              ),
              width: maxWidth,
              child: WidgetImage(
                data,
                ToolsRegex.isUrl(data) ? ImageType.network : ImageType.file,
                fit: BoxFit.contain,
                width: double.infinity,
                height: _calculate(content),
              ),
            ),
          ),
          if ('R' == status)
            const Positioned(
              child: TDLoading(
                size: TDLoadingSize.large,
                icon: TDLoadingIcon.circle,
              ),
            ),
        ],
      ),
    );
  }

  // 计算
  _calculate(Map<String, dynamic> content) {
    if (content['width'] == null) {
      return null;
    }
    if (content['height'] == null) {
      return null;
    }
    int width = content['width'] ?? 1;
    int height = content['height'] ?? 1;
    double value = height / width * maxWidth;
    if (value > maxHeight) {
      return maxHeight;
    }
    if (value < minHeight) {
      return minHeight;
    }
    return value;
  }

  _formatData(Map<String, dynamic> content) {
    String data = content['data'];
    if (content['thumbnail'] != null) {
      File file = File(content['thumbnail']);
      if (file.existsSync()) {
        data = content['thumbnail'];
      }
    }
    return data;
  }
}

// 图片组件
class ChatMessageImageShow extends StatefulWidget {
  final List<Map<String, dynamic>> dataList;
  final int initialPage;
  const ChatMessageImageShow(this.dataList, this.initialPage, {super.key});

  @override
  createState() => _ShowImageState();
}

class _ShowImageState extends State<ChatMessageImageShow> {
  int initialPage = 0;
  @override
  void initState() {
    super.initState();
    initialPage = widget.initialPage;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.back();
        },
        onLongPress: () {
          // 内容
          Map<String, dynamic> content = widget.dataList[initialPage];
          WidgetBottom([
            BottomModel(
              '保存',
              onTap: () async {
                // 关闭
                Get.back();
                // 权限
                bool result = await ToolsPerms.storage();
                if (!result) {
                  return;
                }
                // 保存
                await WidgetCommon.saveImage(content['data']);
                // 弹框提示
                EasyLoading.showToast('保存成功');
              },
            ),
            BottomModel(
              '转发',
              onTap: () async {
                // 关闭
                Get.back();
                // 转发
                await Get.toNamed(
                  MsgForwardPage.routeName,
                  arguments: [
                    ForwardModel(MsgType.image, content),
                  ],
                );
              },
            ),
            BottomModel(
              '编辑',
              onTap: () async {
                // 关闭
                Get.back();
                // 在使用图像编辑器之前
                await ImageEditor.setI18n({
                  'Crop': '裁剪',
                  'Brush': '画笔',
                  'Flip': '翻转',
                  'Rotate left': '左转',
                  'Rotate right': '右转',
                  'Emoji': '表情',
                  'Freeform': '比例',
                });
                // 获取应用的缓存目录
                ImageProvider provider = WidgetImage.provider(content['data']);
                Uint8List image = await provider.toImageData(
                  const ImageConfiguration(),
                );
                final bytes = await Get.to(
                  ImageEditor(
                    image: image,
                    textOption: null,
                    blurOption: null,
                    filtersOption: null,
                  ),
                );
                if (bytes == null) {
                  return;
                }
                // 打开
                WidgetBottom([
                  BottomModel(
                    '保存',
                    onTap: () async {
                      // 关闭
                      Get.back();
                      // 权限
                      bool result = await ToolsPerms.storage();
                      if (!result) {
                        return;
                      }
                      // 保存图片到本地
                      await ImageGallerySaver.saveImage(bytes);
                      // 弹框提示
                      EasyLoading.showToast('保存成功');
                    },
                  ),
                  BottomModel(
                    '转发',
                    onTap: () async {
                      // 关闭
                      Get.back();
                      // 上传
                      String path = await ToolsUpload.uploadBytesData(
                        bytes,
                      );
                      // 组装消息
                      Map<String, dynamic> content = {
                        'data': path,
                      };
                      // 计算宽高
                      content.addAll(await WidgetCommon.calculateBytes(bytes));
                      // 识别二维码
                      content['scan'] = await Scan.parse(path);
                      // 转发
                      await Get.toNamed(
                        MsgForwardPage.routeName,
                        arguments: [
                          ForwardModel(MsgType.image, content),
                        ],
                      );
                    },
                  ),
                ]);
              },
            ),
            if (content['scan'] != null)
              BottomModel(
                '识别二维码',
                onTap: () async {
                  // 关闭
                  Get.back();
                  // 执行扫码
                  ToolsScan.doScan(content['scan']);
                },
              ),
          ]);
        },
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              itemCount: widget.dataList.length,
              builder: (context, index) {
                Map<String, dynamic> content = widget.dataList[index];
                String data = _formatData(content);
                ImageProvider provider;
                if (ToolsRegex.isUrl(data)) {
                  provider = WidgetImage.provider(data);
                } else {
                  provider = FileImage(File(data));
                }
                return PhotoViewGalleryPageOptions(
                  imageProvider: provider,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: const BoxDecoration(
                color: Colors.white,
              ),
              pageController: PageController(
                initialPage: widget.initialPage,
              ),
              onPageChanged: (index) {
                setState(() {
                  initialPage = index;
                });
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${initialPage + 1} / ${widget.dataList.length}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _formatData(Map<String, dynamic> content) {
    String data = content['data'];
    if (content['thumbnail'] != null) {
      File file = File(content['thumbnail']);
      if (file.existsSync()) {
        data = content['thumbnail'];
      }
    }
    return data;
  }
}
