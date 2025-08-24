import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart'; // 引入WebView
import 'package:alpaca/pages/view/html_controller.dart';
import 'package:alpaca/tools/tools_storage.dart';

class HtmlPage extends GetView<HtmlController> {
  // 路由地址
  static const String routeName = '/sys_html';
  const HtmlPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HtmlController());
    String beian = ToolsStorage().config().beian;
    late WebViewController _controller;

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          // 如果已经弹出则直接返回
          if (didPop) return;
          Get.back();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const ui.Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC6DBF7), Color(0xFFE6EFFA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                ),
              ),
              child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Obx(
                    () => controller.title.value,
                  )),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25), // 边距设置为25
              child: Column(
                children: [
                  Expanded(
                    child: Obx(() {
                      if (controller.htmlContent.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.jump.value == 0) {
                        final webViewController = WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..setBackgroundColor(const Color(0x00000000))
                          ..loadHtmlString('''
                      <!DOCTYPE html>
                      <html>
                        <head>
                          <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
                          <style>
                            /* 全局样式重置 */
                            * {
                              margin: 0;
                              padding: 0;
                              box-sizing: border-box;
                            }
                            /* 基础字体设置 */
                            body {
                              font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                              font-size: 16px; /* 基础字体大小 */
                              line-height: 1.6; /* 行高，提升可读性 */
                              color: #333; /* 字体颜色 */
                            }
                            /* 标题样式 */
                            h1 { font-size: 24px; }
                            h2 { font-size: 22px; }
                            h3 { font-size: 20px; }
                            /* 图片自适应 */
                            img {
                              max-width: 100%;
                              height: auto;
                            }
                          </style>
                        </head>
                        <body>
                          ${controller.htmlContent.value}
                        </body>
                      </html>
                    ''');
                        return WebViewWidget(controller: webViewController);
                      } else {
                        final webViewController = WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..setBackgroundColor(const Color(0x00000000))
                          ..setNavigationDelegate(
                            NavigationDelegate(
                              onProgress: (int progress) {},
                              onPageStarted: (String url) {},
                              onPageFinished: (String url) async {},
                              onWebResourceError: (WebResourceError error) {},
                            ),
                          )
                          ..loadRequest(
                            Uri.parse(controller.url.value),
                          );
                        return WebViewWidget(controller: webViewController);
                      }
                    }),
                  ),
                  //beian.isNotEmpty ? WidgetCommon.tips(beian) : Container(),
                ],
              ),
            ),
          ),
        ));
  }
}
