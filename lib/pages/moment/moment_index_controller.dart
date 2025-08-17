import 'dart:async';

import 'package:alpaca/event/event_moment.dart';
import 'package:alpaca/request/request_common.dart';
import 'package:alpaca/request/request_moment.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:alpaca/event/event_setting.dart';
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/request/request_moment.dart';
import 'package:alpaca/tools/tools_badger.dart';
import 'package:alpaca/tools/tools_enum.dart';
import 'package:alpaca/tools/tools_sqlite.dart';
import 'package:alpaca/tools/tools_storage.dart';
import 'package:alpaca/tools/tools_submit.dart';
import 'dart:convert';

class MomentIndexController extends BaseController {
  // 朋友圈列表
  final RxList<MomentModel> momentList = RxList<MomentModel>([]);

  LocalUser localUser = ToolsStorage().local();

  final RxBool isLoading = true.obs;

  String userId = ToolsStorage().local().userId;
  RxString notice = ''.obs;
  final Map<String, MomentModel> _dataMap = {};

  // 添加是否有更多数据的标志
  final RxBool _hasMore = true.obs;
  bool get hasMore => _hasMore.value;

  /**
   * 发起点赞
   */
  Future<bool> likeMoment(int momentId) async {
    print('点赞开始');
    // 假设 API 调用成功后返回 true
    await RequestMoment.likeMoment(momentId);
    return true;
  }

  //发起评论
  Future<bool> addComment(int momentId, int replyTo, String content) async {
    print('评论开始');
    // 假设 API 调用成功后返回 true
    await RequestMoment.addComment(momentId, replyTo, content);
    return true;
  }

  /**
 * 删除指定momentId的朋友圈信息
 */
  Future<bool> deleteMoment(int momentId) async {
    print('开始删除朋友圈: $momentId');
    try {
      // 调用删除接口
      bool deleteSuccess = await RequestMoment.deleteMoment(momentId);
      if (deleteSuccess) {
        // 从内存列表中移除
        momentList.removeWhere((model) => model.momentId == momentId);
        // 从数据映射中移除
        _dataMap.remove(momentId.toString());
        // 从数据库中删除
        await ToolsSqlite().moment.delete(momentId.toString());
        // 更新未读徽章数量
        int momentbadger = ToolsStorage().momentbadger(update: -1);
        updateMomentBadger(momentbadger);
        // 通知UI更新
        update();
        print('删除朋友圈成功: $momentId');
        return true;
      }
    } catch (e) {
      print('删除朋友圈失败: $e');
    }
    return false;
  }

  // 消息刷新
  Future onRefresh() async {
    //print("开始获取数据");
    // 更新
    refreshList = await ToolsSqlite().moment.getList();
    momentList.clear();
    int momentbadger = 0;
    for (Moment data in refreshList) {
      //print("媒体文件：" + data.images);
      MomentModel momentModel = addMomentToModelList(data);
      // 添加到列表
      _dataMap[data.momentId] = momentModel;
      momentList.add(momentModel);
    }
    momentbadger = ToolsStorage().momentbadger();
    updateMomentBadger(momentbadger);
    update();
  }

  /**
   * 更新朋友圈未读徽章数量
   * @param count 未读数量
   */
  void updateMomentBadger(int count) {
    EventSetting().handle(SettingModel(
      SettingType.badger,
      label: 'moment',
      value: count.toString(),
    ));
  }

  // 新增：将Moment转换为MomentModel并添加到列表的方法
  MomentModel addMomentToModelList(Moment data) {
    // 解析图片JSON并转换为Media列表
    List<dynamic> jsonList = json.decode(data.images);
    List<Media> media = jsonList.map((json) => Media.fromJson(json)).toList();
    // 解析评论
    jsonList = json.decode(data.comments);
    List<FriendCommentModel> comment =
        jsonList.map((json) => FriendCommentModel.fromJson(json)).toList();
    // 解析点赞
    // 解析点赞（修复类型转换问题）
    List<dynamic> likeDynamicList = json.decode(data.likes);
    List<String> like = likeDynamicList.map((item) => item.toString()).toList();

    // 创建MomentModel
    MomentModel momentModel = MomentModel(
        momentId: int.parse(data.momentId),
        userId: int.parse(data.userId),
        portrait: data.portrait,
        nickname: data.nickname,
        content: data.content,
        createTime: DateTime.parse(data.createTime),
        location: data.location,
        visibility: int.parse(data.visibility),
        images: media,
        comments: comment,
        likes: like);
    return momentModel;
  }

  @override
  void onInit() {
    super.onInit();
    // 监听消息
    _listenMessage();
    _listenSetting();
    // 消息刷新
    //onRefresh();
    // 定时任务
    _listenTimer();
  }

  // 监听设置（处理最新通知/处理消息刷新）
  _listenSetting() {
    // 监听通知
    subscription2 = EventSetting().event.stream.listen((model) {
      if (SettingType.message == model.setting) {
        // 消息刷新
        onRefresh();
      }
    });
  }

  // 监听消息（当有新消息，显示到消息顶部）
  _listenMessage() {
    subscription1 = EventMoment().listenMoment.stream.listen((moment) async {
      // 对信息进行判断，看是更新还是新增
      // 判断 _dataMap 中是否存在 moment.momentId 这个键
      bool exists = _dataMap.containsKey(moment.momentId);
      MomentModel momentModel = addMomentToModelList(moment);
      String isdel = moment.isDeleted;
      if (exists) {
        print("已有数据:" + moment.momentId);
        // 如果存在，说明是更新操作，先移除旧数据
        refreshList.remove(_dataMap[moment.momentId]);
        // 获取要移除数据的索引
        int index = momentList.indexOf(_dataMap[moment.momentId]);
        if (index != -1) {
          // 更新数据库记录
          await ToolsSqlite().moment.update(moment.momentId, moment.toJson());
          bool removed = momentList.remove(_dataMap[moment.momentId]);
          if (removed) {
            print("被移除元素的序列号（索引）是：$index");
            print("删除该记录：$isdel");
            if (isdel == "0")
              momentList.insert(index, momentModel); // 最新数据显示在最前面
          }
        }
      } else {
        // 如果不存在，说明是新增操作（可选：添加新增逻辑）
        momentList.insert(0, momentModel); // 最新数据显示在最前面
        refreshList.add(moment);
        print("新增数据: ${moment.momentId}");
        int momentbadger = ToolsStorage().momentbadger(update: 1);
        updateMomentBadger(momentbadger);
      }
      // 插入
      // 添加到列表
      if (isdel == "0") _dataMap[moment.momentId] = momentModel;
      // 更新

      update();
    });
  }

  // 定时任务（每间隔1分钟，刷新一次页面时间显示）
  _listenTimer() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      update();
    });
  }

  // 下拉刷新
  Future onRefresh1() async {
    // 获取配置
    RequestCommon.getConfig();
    print('onRefresh method called');
    // 获取消息
    superRefresh(
      RequestMoment.pullMsg(),
    );
  }
}
