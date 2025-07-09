import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_theme.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

String flag = '↑';

// 通讯录组件
class WidgetContact extends StatefulWidget {
  // 搜索框
  final bool search;
  // 选中文字
  final String mark;
  // 头部部分
  final Widget? header;
  // 数据列表
  final List<ContactModel> dataList;
  // 选中列表
  final List<String>? selectList;
  // 单击事件
  final Function(ContactModel model)? onTap;
  // 多选事件
  final Function(List<String> selectList)? onSelect;
  const WidgetContact({
    super.key,
    this.search = true,
    this.mark = '选中',
    this.header,
    required this.dataList,
    this.selectList,
    this.onTap,
    this.onSelect,
  });

  @override
  createState() => _WidgetContactState();
}

class _WidgetContactState extends State<WidgetContact> {
  List<ContactModel> displayList = [];
  List<String> selectList = [];
  bool showHeader = true;
  @override
  void initState() {
    super.initState();
    displayList = widget.dataList;
    selectList = widget.selectList ?? [];
  }

  @override
  Widget build(BuildContext context) {
    List<ContactModel> dataList = _handle(displayList);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanDown: (details) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          _buildSearch(),
          _header(show: dataList.length == 1),
          Expanded(
            child: _listView(dataList),
          ),
        ],
      ),
    );
  }

  _buildSearch() {
    if (!widget.search) {
      return Container();
    }
    return TDSearchBar(
      placeHolder: '请输内容',
      onTextChanged: (values) {
        setState(() {
          // 显示头部
          showHeader = values.isEmpty;
          // 过滤数据
          displayList = widget.dataList.where((data) {
            if (data.select) {
              return true;
            }
            String nickname = data.nickname.toLowerCase();
            String extend = data.extend.toLowerCase();
            String value = values.toLowerCase();
            return nickname.contains(value) || extend.contains(value);
          }).toList();
        });
      },
    );
  }

  _header({bool show = true}) {
    if (widget.header == null) {
      return Container();
    }
    if (widget.search && !showHeader) {
      return Container();
    }
    if (show) {
      return widget.header;
    }
    return Container();
  }

  _listView(List<ContactModel> dataList) {
    if (dataList.length == 1) {
      return WidgetCommon.none();
    }
    return AzListView(
      data: dataList,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _header();
        }
        bool divider = true;
        if (index + 1 < dataList.length) {
          divider = dataList[index].tag == dataList[index + 1].tag;
        }
        return _getDataItem(dataList[index], divider);
      },
      susItemBuilder: (BuildContext context, int index) {
        ContactModel model = dataList[index];
        return _getTagItem(model.getSuspensionTag());
      },
      indexBarData: widget.search ? [] : [flag, ...kIndexBarData],
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        downTextStyle: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        downItemDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
        ),
        indexHintWidth: 120 / 2,
        indexHintHeight: 100 / 2,
        indexHintAlignment: Alignment.centerRight,
        indexHintChildAlignment: Alignment(-0.25, 0.0),
        indexHintOffset: Offset(-20, 0),
      ),
    );
  }

  _getTagItem(String tag) {
    if (flag == tag) {
      return Container();
    }
    return Container(
      height: 40,
      width: context.width,
      padding: const EdgeInsets.only(left: 16.0),
      color: const Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        tag,
        softWrap: false,
        style: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  // 组装参数
  List<ContactModel> _handle(List<ContactModel> displayList) {
    List<ContactModel> dataList = [];
    if (displayList.isNotEmpty) {
      for (int i = 0, length = displayList.length; i < length; i++) {
        String userId = displayList[i].userId;
        String nickname = displayList[i].nickname;
        String pinyin = PinyinHelper.getPinyinE(nickname);
        String tag = pinyin.substring(0, 1).toUpperCase();
        if (displayList[i].select) {
          tag = widget.mark;
        }
        // 所有人
        else if ('0' == userId) {
          tag = '@所有人';
        }
        // 其他
        else if (!RegExp("[A-Z$flag]").hasMatch(tag)) {
          tag = '#';
        }
        displayList[i].pinyin = pinyin;
        displayList[i].tag = tag;
      }
      // A-Z sort.
      sortListBySuspensionTag(displayList, widget.mark);
      // show sus tag.
      SuspensionUtil.setShowSuspensionStatus(displayList);
      // 放入列表
      dataList.addAll(displayList);
    }
    // header部分
    dataList.insert(0, ContactModel.init());
    setState(() {});
    return dataList;
  }

  static void sortListBySuspensionTag(
    List<ContactModel> dataList,
    String mark,
  ) {
    if (dataList.isNotEmpty) {
      dataList.sort((a, b) {
        // 所有人
        if (a.userId == "0") {
          return -1;
        }
        // 选中
        else if (a.getSuspensionTag() == mark) {
          return -1;
        }
        // 选中
        else if (b.getSuspensionTag() == "#") {
          return -1;
        }
        // 选中
        else if (a.getSuspensionTag() == "#") {
          return 1;
        }
        // 选中
        else if (b.getSuspensionTag() == mark) {
          return 1;
        }
        int sort = a.getSuspensionTag().compareTo(b.getSuspensionTag());
        if (sort == 0) {
          return a.userId.compareTo(b.userId);
        }
        return sort;
      });
    }
  }

  _getDataItem(ContactModel model, bool divider) {
    if (flag == model.tag) {
      return Container();
    }
    String portrait = model.portrait;
    String nickname = model.nickname;
    String userId = model.userId;
    String extend = model.extend;
    return Column(
      children: [
        ListTile(
          leading: WidgetCommon.showAvatar(
            portrait,
            size: 40,
          ),
          title: Text(nickname),
          subtitle: extend.isEmpty ? null : Text(extend),
          trailing: widget.onSelect != null
              ? Checkbox(
                  value: model.select,
                  fillColor: WidgetStateColor.resolveWith((states) {
                    // 开启状态
                    if (states.contains(WidgetState.selected)) {
                      // 选中
                      if (model.select) {
                        return AppTheme.color;
                      }
                      // 未选中
                      return Colors.grey;
                    }
                    // 关闭状态
                    return Colors.white;
                  }),
                  onChanged: (value) {
                    model.select = value!;
                    if (value) {
                      selectList.add(userId);
                    } else {
                      selectList.remove(userId);
                    }
                    setState(() {});
                    widget.onSelect?.call(selectList);
                  },
                )
              : null,
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap?.call(
                ContactModel(
                  userId: userId,
                  nickname: nickname,
                  portrait: portrait,
                ),
              );
            }
          },
        ),
        if (divider) WidgetCommon.divider()
      ],
    );
  }
}

class ContactModel extends ISuspensionBean {
  String userId;
  String nickname;
  String portrait;
  bool select;
  String extend;
  String? pinyin;
  String? tag;

  ContactModel({
    required this.userId,
    required this.nickname,
    required this.portrait,
    this.pinyin,
    this.select = false,
    this.extend = '',
    String remark = '',
    this.tag,
  }) {
    if (remark.isNotEmpty) {
      nickname = remark;
    }
  }

  factory ContactModel.init() {
    return ContactModel(
      userId: flag,
      nickname: flag,
      portrait: flag,
      tag: flag,
    );
  }

  @override
  String getSuspensionTag() => tag!;

  @override
  String toString() => json.encode(this);
}
