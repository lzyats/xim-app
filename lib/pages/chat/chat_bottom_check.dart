import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/msg/msg_forward_controller.dart';
import 'package:alpaca/pages/msg/msg_forward_page.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/widgets/widget_bottom.dart';

class ChatBottomCheck extends StatefulWidget {
  final RxBool configCheckBox;
  final RxMap<String, ChatHis> checkboxList;
  const ChatBottomCheck({
    super.key,
    required this.configCheckBox,
    required this.checkboxList,
  });

  @override
  createState() => _ChatBottomCheckState();
}

class _ChatBottomCheckState extends State<ChatBottomCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 阴影颜色
            blurRadius: 2, // 模糊半径
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              child: _buildMenu('转发'),
              onTap: () async {
                Map<String, ChatHis> checkboxList = widget.checkboxList;
                if (checkboxList.isEmpty) {
                  // 弹框提示
                  EasyLoading.showToast('请先选择消息');
                  return;
                }
                // 转发消息
                List<ForwardModel> dataList = [];
                // 处理消息
                for (var chatHis in checkboxList.values) {
                  // 发送中
                  if ('R' == chatHis.status) {
                    continue;
                  }
                  if (chatHis.msgType.isForward) {
                    dataList.add(
                      ForwardModel(
                        chatHis.msgType,
                        chatHis.content,
                        createTime: chatHis.createTime,
                        source: chatHis.source,
                      ),
                    );
                  }
                }
                // 校验
                if (dataList.isEmpty) {
                  // 弹框提示
                  EasyLoading.showToast('包含不可转发消息');
                  return;
                }
                WidgetBottom([
                  BottomModel(
                    '逐条转发',
                    onTap: () async {
                      // 关闭
                      Get.back();
                      // 转发
                      dynamic result = await Get.toNamed(
                        MsgForwardPage.routeName,
                        arguments: dataList,
                      );
                      if (result != null) {
                        // 取消
                        widget.configCheckBox.value = false;
                        // 清空
                        widget.checkboxList.value = {};
                      }
                    },
                  ),
                  BottomModel(
                    '合并转发',
                    onTap: () async {
                      // 关闭
                      Get.back();
                      // 处理
                      dataList.first.forward = true;
                      // 转发
                      dynamic result = await Get.toNamed(
                        MsgForwardPage.routeName,
                        arguments: dataList,
                      );
                      if (result != null) {
                        // 取消
                        widget.configCheckBox.value = false;
                        // 清空
                        widget.checkboxList.value = {};
                      }
                    },
                  ),
                ]);
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: _buildMenu('删除'),
              onTap: () {
                Map<String, ChatHis> checkboxList = widget.checkboxList;
                if (checkboxList.isEmpty) {
                  // 弹框提示
                  EasyLoading.showToast('请先选择消息');
                  return;
                }
                List<String> dataList = [];
                for (var checkbox in checkboxList.values) {
                  dataList.add(checkbox.msgId);
                  dataList.add(checkbox.syncId);
                }
                WidgetBottom([
                  BottomModel(
                    '确认删除',
                    onTap: () async {
                      // 关闭
                      Get.back();
                      // 删除消息
                      EventSetting().handle(
                        SettingModel(
                          SettingType.remove,
                          primary: checkboxList.values.first.chatId,
                          label: 'remove',
                          dataList: dataList,
                        ),
                      );
                      // 取消
                      widget.configCheckBox.value = false;
                      // 清空
                      widget.checkboxList.value = {};
                    },
                  ),
                ]);
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: _buildMenu('取消'),
              onTap: () {
                // 取消
                widget.configCheckBox.value = false;
                // 清空
                widget.checkboxList.value = {};
              },
            ),
          ),
        ],
      ),
    );
  }

  // 构建菜单
  _buildMenu(String label) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
