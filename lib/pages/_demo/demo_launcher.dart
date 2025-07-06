import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoLauncher extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_launcher';
  const DemoLauncher({super.key});

  @override
  createState() => _DemoBankCardState();
}

class _DemoBankCardState extends State<DemoLauncher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('调用三方应用'),
      ),
      body: Column(
        children: [
          _build1(),
          _build2(),
          _build3(),
          _build4(),
        ],
      ),
    );
  }

  _build1() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final Uri url = Uri.parse('https://www.baidu.net/');
          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
          }
        },
        child: const Text("打开网址"),
      ),
    );
  }

  _build2() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // 收件人邮箱
          String recipient = "939313737@qq.com";
          //邮件主题
          String subject = "邮件主题";
          // 邮件内容
          String body = "邮件内容";
          String mailtoUri = "mailto:$recipient?subject=$subject&body=$body";
          final Uri url = Uri.parse(mailtoUri);
          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $mailtoUri');
          }
        },
        child: const Text("发邮件"),
      ),
    );
  }

  _build3() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          // 收件人电话
          String recipient = "10086";
          // 短信内容
          String body = "1";
          String smsUrl =
              'sms:$recipient?body=${Uri.encodeQueryComponent(body)}';
          final Uri url = Uri.parse(smsUrl);

          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $smsUrl');
          }
        },
        child: const Text("发短信"),
      ),
    );
  }

  _build4() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final Uri url = Uri.parse('weixin://');
          if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
            throw Exception('Could not launch $url');
          }
        },
        child: const Text("打开微信"),
      ),
    );
  }
}

// QQ： mqq:// 
// 微信： weixin:// 
// 京东： openapp.jdmoble:// 
// 淘宝： taobao:// 
// 美团： imeituan:// 
// 支付宝： alipay:// 
// 微博： sinaweibo:// 
// 知乎： zhihu:// 
// 豆瓣fm： doubanradio:// 
// 网易公开课： ntesopen:// 
// Chrome： googlechrome:// 
// QQ浏览器： mqqbrowser:// 
// uc浏览器： ucbrowser:// 
// 搜狗浏览器： SogouMSE:// 
// 百度地图： baidumap:// bdmap:// 
// 优酷： youku:// 
// 有道词典： yddictproapp:// 
// QQ音乐：qqmusic://
// 腾讯视频：tenvideo://
// 网易云音乐：orpheus://

// 小米商店："mimarket://details?id=com.xX.XX"
// 华为商店："appmarket://details?id=com.xx.xx"
// oppo商店："oppomarket://details?packagename=com.xx.XX"
// vivo商店：""vivomarket://details?id=com.xx.Xx"
