// lib/pages/moment/moment_index_controller.dart
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
//添加通用网络请求
//import 'package:alpaca/request/request_moment.dart';

import 'package:alpaca/config/app_config.dart';

import 'package:dio/dio.dart';
import 'package:alpaca/tools/tools_storage.dart';

class MomentIndexController extends BaseController {
  // 朋友圈列表
  //List<Moment> momentList = [];
  final RxList<MomentModel> momentList = RxList<MomentModel>([]);

  // 数据加载状态
  final Rx<bool> isLoading = Rx<bool>(false);

  // 下滑加载状态
  final Rx<bool> isLoadingMore = Rx<bool>(false);
  LocalUser localUser = ToolsStorage().local();

  // 当前页码
  int currentPage = 1;

  // 每页数量
  int pageSize = 10;

  // 刷新
  Future<void> _onRefresh() async {
    currentPage = 1;
    isLoading.value = true;
    update();

    try {
      momentList.value = await getMoments(currentPage, pageSize);
    } catch (e) {
      print('Error loading moments: $e');
    } finally {
      isLoading.value = false;
      update();
    }
  }

  // 下滑加载更多（确保此方法存在）
  Future<void> onLoadMore() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    update();

    try {
      currentPage++;
      List<MomentModel> newMoments = await getMoments(currentPage, pageSize);
      if (newMoments.isNotEmpty) {
        momentList.addAll(newMoments);
      }
    } catch (e) {
      print('Error loading more moments: $e');
      currentPage--;
    } finally {
      isLoadingMore.value = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    update();
    _onRefresh();
    print(momentList.isEmpty);

    Future.delayed(Duration.zero, () {
      isLoading.value = false;
      update();
    });
  }
}

// 模拟API请求（确保参数正确）
Future<List<MomentModel>> getMoments(int page, int pageSize) async {
  print('朋友圈信息0：');
  LocalUser localUser = ToolsStorage().local();
  print('朋友圈信息2：' + localUser.userId);
  dynamic responseData =
      await getData('/t.php', page, pageSize, localUser.userId);
  print('朋友圈信息1：' + responseData.toString());
  if (responseData != null && responseData is List) {
    List<MomentModel> list =
        responseData.map((item) => MomentModel.fromJson(item)).toList();
    print('朋友圈信息1：' + list.toString());
    return list;
  }
  return [];
}

// 定义get方法
Future<dynamic> getData(
    String url, int page, int pageSize, String user_id) async {
  Dio dio = Dio();
  try {
    Response response = await dio.get(
      AppConfig.commentHost + url,
      data: {'user_id': user_id, 'page': page, 'page_size': pageSize},
      options: Options(
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      ),
    );
    print(response.data);
    return response.data;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}
