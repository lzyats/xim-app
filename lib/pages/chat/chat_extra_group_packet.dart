import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:alpaca/config/app_fonts.dart';
import 'package:alpaca/event/event_message.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/chat/chat_extra.dart';
import 'package:alpaca/request/request_group.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_regex.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';

import 'package:alpaca/widgets/widget_button.dart';
import 'package:alpaca/widgets/widget_common.dart';
import 'package:alpaca/widgets/widget_contact.dart';

double maxCount = 2000;
double totalAmount = 999999;

// 聊天=扩展=红包
class ChatExtraGroupPacket extends StatelessWidget {
  const ChatExtraGroupPacket({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtraItem(
      label: '红包',
      icon: AppFonts.e679,
      onTap: () {
        Get.to(const ChatExtraGroupPacketItem());
      },
    ).buildItem();
  }
}

class ChatExtraGroupPacketItem extends StatefulWidget {
  const ChatExtraGroupPacketItem({super.key});

  @override
  createState() => _ChatExtraGroupPacketItemState();
}

class _ChatExtraGroupPacketItemState extends State<ChatExtraGroupPacketItem> {
  late int index = 0;
  late String receiveId;
  late String nickname;

  @override
  void initState() {
    super.initState();
    dynamic result = Get.arguments;
    if (result != null) {
      index = 2;
      receiveId = result['userId'];
      nickname = result['nickname'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '发群红包',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Column(
          children: [
            WidgetCommon.customRedClipper(),
            Expanded(
              child: _buildTabs(),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabs() {
    return DefaultTabController(
      length: 3,
      initialIndex: index,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: const TabBar(
            indicatorColor: Colors.red,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: "手气红包",
              ),
              Tab(
                text: "普通红包",
              ),
              Tab(
                text: "专属红包",
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              _ChatExtraPacketLuck(),
              _ChatExtraPacketNormal(),
              _ChatExtraPacketAssign(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatExtraPacketLuck extends StatefulWidget {
  const _ChatExtraPacketLuck();

  @override
  createState() => _ChatExtraPacketLuckState();
}

class _ChatExtraPacketLuckState extends State<_ChatExtraPacketLuck> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _countController =
      TextEditingController(text: '1');
  final TextEditingController _remarkController = TextEditingController();
  double amount = 0;
  int count = 1;
  double packet = ToolsStorage().config().packet;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      String text = _amountController.text.trim();
      if (text.isEmpty) {
        amount = 0;
      } else {
        amount = double.parse(text);
        if (amount > totalAmount) {
          amount = 0;
          _amountController.clear();
        }
      }
      setState(() {});
    });
    _countController.addListener(() {
      String text = _countController.text.trim();
      if (text.isEmpty) {
        count = 0;
      } else {
        count = int.parse(text);
        if (count > maxCount) {
          count = 0;
          _countController.clear();
        }
      }
      setState(() {});
    });
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      Get.back();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      _countController.dispose();
      _amountController.dispose();
      _remarkController.dispose();
      _subscription?.cancel();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildArea(),
      ),
    );
  }

  _buildArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildCount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          WidgetCommon.tips(
            '单个红包最大金额¥ ${packet.toStringAsFixed(2)} 元',
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '¥ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
          _buildSubmit(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '红包超过24小时未领取将会自动退回',
          ),
        ],
      ),
    );
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        AmountFormatter(),
      ],
      textAlign: TextAlign.right,
      controller: _amountController,
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包总额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  _buildCount() {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        AmountFormatter(digit: 0),
      ],
      textAlign: TextAlign.right,
      controller: _countController,
      decoration: const InputDecoration(
        hintText: '请输入红包个数',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包个数',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  // 备注
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: _remarkController,
      decoration: const InputDecoration(
        hintText: '恭喜发财，大吉大利',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包备注',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      maxLength: 15,
    );
  }

  _buildSubmit() {
    return WidgetButton(
      label: '塞进红包',
      color: Colors.red,
      onTap: () {
        if (ToolsSubmit.progress()) {
          return;
        }
        if (amount < 0.01) {
          throw Exception('红包总额不能为空');
        }
        if (count < 1) {
          throw Exception('红包个数不能为空');
        }
        if (amount * 100 < count || amount > count * packet) {
          throw Exception('红包总额不正确');
        }
        WidgetCommon.showKeyboard(
          context,
          onPressed: (value) {
            if (ToolsSubmit.call(millisecond: 10000)) {
              _submit(amount, count, value);
            }
          },
        );
      },
    );
  }

  _submit(double amount, int count, String password) {
    String remark = _remarkController.text.trim();
    if (remark.isEmpty) {
      remark = '恭喜发财，大吉大利';
    }
    // 消息类型
    MsgType msgType = MsgType.groupLuck;
    // 组装消息
    Map<String, dynamic> content = {
      'data': amount,
      'count': count,
      'remark': remark,
      'password': password,
    };
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
      handle: false,
      write: false,
      result: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}

class _ChatExtraPacketNormal extends StatefulWidget {
  const _ChatExtraPacketNormal();

  @override
  createState() => _ChatExtraPacketNormalState();
}

class _ChatExtraPacketNormalState extends State<_ChatExtraPacketNormal> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  double amount = 0;
  int count = 0;
  StreamSubscription? _subscription;
  double packet = ToolsStorage().config().packet;
  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      String text = _amountController.text.trim();
      if (text.isEmpty) {
        amount = 0;
      } else {
        amount = double.parse(text);
        if (amount > packet) {
          amount = 0;
          _amountController.clear();
        }
      }
      setState(() {});
    });
    _countController.addListener(() {
      String text = _countController.text.trim();
      if (text.isEmpty) {
        count = 0;
      } else {
        count = int.parse(text);
        if (count > maxCount) {
          count = 0;
          _countController.clear();
        }
      }
      setState(() {});
    });
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      Get.back();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _countController.dispose();
    _remarkController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildArea(),
      ),
    );
  }

  _buildArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildCount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          WidgetCommon.tips(
            '单个红包最大金额¥ ${packet.toStringAsFixed(2)} 元',
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '¥ ${count == 0 ? amount.toStringAsFixed(2) : (amount * count).toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
          _buildSubmit(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '红包超过24小时未领取将会自动退回',
          ),
        ],
      ),
    );
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        AmountFormatter(),
      ],
      textAlign: TextAlign.right,
      controller: _amountController,
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '单个金额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  _buildCount() {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        AmountFormatter(digit: 0),
      ],
      textAlign: TextAlign.right,
      controller: _countController,
      decoration: const InputDecoration(
        hintText: '请输入红包个数',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包个数',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  // 备注
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: _remarkController,
      decoration: const InputDecoration(
        hintText: '恭喜发财，大吉大利',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包备注',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      maxLength: 15,
    );
  }

  _buildSubmit() {
    return WidgetButton(
        label: '塞进红包',
        color: Colors.red,
        onTap: () {
          if (ToolsSubmit.progress()) {
            return;
          }
          if (amount < 0.01) {
            throw Exception('红包金额不能为空');
          }
          if (count < 1) {
            throw Exception('红包个数不能为空');
          }
          WidgetCommon.showKeyboard(
            context,
            onPressed: (value) {
              if (ToolsSubmit.call(millisecond: 10000)) {
                _submit(amount * count, count, value);
              }
            },
          );
        });
  }

  _submit(double amount, int count, String password) {
    String remark = _remarkController.text.trim();
    if (remark.isEmpty) {
      remark = '恭喜发财，大吉大利';
    }
    // 消息类型
    MsgType msgType = MsgType.groupPacket;
    // 组装消息
    Map<String, dynamic> content = {
      'data': amount,
      'count': count,
      'remark': remark,
      'password': password,
    };
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
      handle: false,
      write: false,
      result: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}

class _ChatExtraPacketAssign extends StatefulWidget {
  const _ChatExtraPacketAssign();

  @override
  createState() => _ChatExtraPacketAssignState();
}

class _ChatExtraPacketAssignState extends State<_ChatExtraPacketAssign> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();
  double amount = 0;
  String? receiveId;
  double packet = ToolsStorage().config().packet;
  StreamSubscription? _subscription;
  @override
  void initState() {
    super.initState();
    dynamic result = Get.arguments;
    if (result != null) {
      receiveId = result['userId'];
      _receiverController.text = result['nickname']!;
    }
    _amountController.addListener(() {
      String text = _amountController.text.trim();
      if (text.isEmpty) {
        amount = 0;
      } else {
        amount = double.parse(text);
        if (amount > packet) {
          amount = 0;
          _amountController.clear();
        }
      }
      setState(() {});
    });
    // 监听关闭
    _subscription = EventSetting().event.stream.listen((model) {
      if (SettingType.close != model.setting) {
        return;
      }
      Get.back();
    });
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: _buildArea(),
      ),
    );
  }

  _buildArea() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildReceiver(),
          const SizedBox(
            height: 10,
          ),
          _buildAmount(),
          const SizedBox(
            height: 10,
          ),
          _buildRemark(),
          WidgetCommon.tips(
            '红包最大金额¥ ${packet.toStringAsFixed(2)} 元',
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '¥ ${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 36,
            ),
          ),
          _buildSubmit(),
          const SizedBox(
            height: 10,
          ),
          WidgetCommon.tips(
            '红包超过24小时未领取将会自动退回',
          ),
        ],
      ),
    );
  }

  _buildAmount() {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        AmountFormatter(),
      ],
      textAlign: TextAlign.right,
      controller: _amountController,
      decoration: const InputDecoration(
        hintText: '¥ 0.00',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包金额',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
    );
  }

  _buildReceiver() {
    return TextField(
      keyboardType: TextInputType.number,
      onTap: () async {
        // 查询群聊人员
        String groupId = ToolsStorage().chat().chatId;
        List<GroupModel02> memberList =
            await RequestGroup.getMemberList(groupId);
        Get.to(_ChatExtraGroupMember(
          memberList,
          onTap: (value) {
            GroupModel02 friend = memberList.firstWhere(
              (element) => value == element.userId,
            );
            receiveId = friend.userId;
            _receiverController.text = friend.nickname;
            setState(() {});
          },
        ));
      },
      readOnly: true,
      controller: _receiverController,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: WidgetCommon.arrow(),
        ),
        suffixIconColor: Colors.black,
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '领取成员',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(),
      ),
    );
  }

  // 备注
  _buildRemark() {
    return TextField(
      keyboardType: TextInputType.text,
      textAlign: TextAlign.right,
      maxLines: null,
      controller: _remarkController,
      decoration: const InputDecoration(
        hintText: '恭喜发财，大吉大利',
        prefixIcon: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            '红包备注',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        prefixIconConstraints: BoxConstraints(),
      ),
      maxLength: 15,
    );
  }

  _buildSubmit() {
    return WidgetButton(
      label: '塞进红包',
      color: Colors.red,
      onTap: () {
        if (ToolsSubmit.progress()) {
          return;
        }
        if (amount < 0.01) {
          throw Exception('红包金额不能为空');
        }
        if (receiveId == null) {
          throw Exception('领取成员不能为空');
        }
        WidgetCommon.showKeyboard(
          context,
          onPressed: (value) {
            if (ToolsSubmit.call(millisecond: 10000)) {
              _submit(amount, receiveId!, value);
            }
          },
        );
      },
    );
  }

  _submit(double amount, String receiveId, String password) {
    String remark = _remarkController.text.trim();
    if (remark.isEmpty) {
      remark = '恭喜发财，大吉大利';
    }
    // 消息类型
    MsgType msgType = MsgType.groupAssign;
    // 组装消息
    Map<String, dynamic> content = {
      'data': amount,
      'receiveId': receiveId,
      'remark': remark,
      'password': password,
    };
    // 组装对象
    EventChatModel model = EventChatModel(
      ToolsStorage().chat(),
      msgType,
      content,
      handle: false,
      write: false,
      result: false,
    );
    // 发布消息
    EventMessage().listenSend.add(model);
  }
}

class _ChatExtraGroupMember extends StatelessWidget {
  final List<GroupModel02> memberList;
  final Function(String value) onTap;
  const _ChatExtraGroupMember(this.memberList, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    // 联系人列表
    List<ContactModel> dataList = [];
    String userId = ToolsStorage().local().userId;
    // 转换数据
    for (var data in memberList) {
      if (userId == data.userId) {
        continue;
      }
      bool manager = MemberType.normal != data.memberType;
      dataList.add(
        ContactModel(
          userId: data.userId,
          nickname: data.nickname,
          remark: ToolsStorage().remark(
            data.userId,
            value: data.nickname,
            read: true,
          ),
          portrait: data.portrait,
          extend: manager ? data.memberType.label : '',
          select: manager,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择成员'),
      ),
      body: WidgetContact(
        dataList: dataList,
        mark: '管理员',
        onTap: (ContactModel value) {
          onTap(value.userId);
          Get.back();
        },
      ),
    );
  }
}
