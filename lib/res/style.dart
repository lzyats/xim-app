import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

class PageStyle {
  static var html_qi = {
    // 配置对齐相关样式
    '.ql-align-left': Style(
      textAlign: TextAlign.left,
    ),
    '.ql-align-center': Style(
      textAlign: TextAlign.center,
    ),
    '.ql-align-right': Style(
      textAlign: TextAlign.right,
    ),
    '.ql-align-justify': Style(
      textAlign: TextAlign.justify,
    ),
    // 可以在这里添加其他全局样式
  };
  static var ts_FFFFFF_10sp = TextStyle(
    fontSize: 10,
    color: Color(0xFFFFFFFF),
  );

  // ################################
  /// 提取HTML代码中的纯文字内容
  static String extractTextFromHtml(String html) {
    if (html.isEmpty) return '';

    // 解析HTML字符串为DOM文档
    dom.Document document = html_parser.parse(html);

    // 获取文档中所有文本节点并拼接
    return document.body?.text ?? '';
  }
}
