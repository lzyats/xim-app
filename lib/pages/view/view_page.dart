import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 视图页面
class ViewPage extends StatefulWidget {
  // 路由地址
  static const String routeName = '/view';
  const ViewPage({super.key});

  @override
  createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  late WebViewController _controller;
  ViewData viewData = Get.arguments;
  RxString title = ''.obs;
  @override
  Widget build(BuildContext context) {
    title.value = viewData.title;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) async {
            if (title.isNotEmpty) {
              return;
            }
            String? title_ = await _controller.getTitle();
            title.value = title_!;
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return viewData.navigation;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(viewData.url),
      );

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        // 如果已经弹出则直接返回
        if (didPop) return;
        if (await _controller.canGoBack()) {
          _controller.goBack();
        } else {
          Get.back();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.close_rounded,
                  size: 30,
                ),
              ),
              onTap: () {
                // 返回
                Get.back();
              },
            ),
          ],
          title: Obx(() => Text(title.value)),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (viewData.warn)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: 30,
                  color: const Color.fromARGB(255, 245, 233, 128),
                  child: const Center(
                    child: Text(
                      '您正在访问外部地址，请务必提高警惕，以防上当受骗',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ViewData {
  String title;
  String url;
  bool warn;
  NavigationDecision navigation;

  ViewData(
    this.url, {
    this.title = '',
    this.warn = true,
    this.navigation = NavigationDecision.navigate,
  });
}
