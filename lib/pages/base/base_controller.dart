import 'dart:async';

import 'package:get/get.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseController<T> extends GetxController {
  // 刷新组件
  final RefreshController refreshController = RefreshController();
  // 当前页码
  int refreshPageIndex = 1;
  // 当前数据
  List<T> refreshList = [];
  // 当前数据
  T? refreshData;
  // 计时器
  Timer? refreshTimer;

  // 下拉刷新
  superRefresh(Future future) async {
    // 延迟加载
    Future.delayed(AppConfig.timeout, () {
      refreshController.refreshCompleted();
    });
    // 偏移页码
    refreshPageIndex = 1;
    // 执行方法
    dynamic data = await future;
    if (data != null) {
      refreshList = data;
    }
    // 刷新
    update();
    // 加载完成
    refreshController.refreshCompleted();
  }

  // 上滑加载
  superLoading(Future future) async {
    // 延迟加载
    Future.delayed(AppConfig.timeout, () {
      refreshController.loadComplete();
    });
    // 执行方法
    List<T> dataList = await future;
    if (dataList.isNotEmpty) {
      refreshPageIndex++;
      refreshList.addAll(dataList);
      // 刷新
      update();
    }
    // 加载完成
    refreshController.loadComplete();
  }

  StreamSubscription? subscription1;
  StreamSubscription? subscription2;
  StreamSubscription? subscription3;

  @override
  void onClose() {
    refreshController.dispose();
    subscription1?.cancel();
    subscription2?.cancel();
    subscription3?.cancel();
    refreshTimer?.cancel();
    super.onClose();
  }
}
