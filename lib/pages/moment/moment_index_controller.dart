// lib/pages/moment/moment_index_controller.dart
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
//添加通用网络请求
import 'package:alpaca/request/request_moment.dart';

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

  // 重新加载数据
  Future<void> reloadData() async {
    isLoading.value = true;
    momentList.clear(); // 清空当前数据
    // 调用 API 重新加载数据
    // 示例代码，需要根据实际情况修改
    currentPage = 1;
    final newData = await getMoments(1, 10);
    momentList.addAll(newData);
    isLoading.value = false;
  }

  // 下滑加载更多（确保此方法存在）
  Future<void> onLoadMore() async {
    if (isLoadingMore.value) return;
    isLoadingMore.value = true;
    update();
    try {
      List<MomentModel> newMoments = await getMoments(currentPage, pageSize);
      if (newMoments.isNotEmpty) {
        momentList.addAll(newMoments);
      } else {
        currentPage--;
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

  // 模拟API请求（确保参数正确）
  Future<List<MomentModel>> getMoments(int page, int pageSize) async {
    print('当前请求页：' + page.toString());
    dynamic responseDataa = await RequestMoment.getMomentList(page, pageSize);
    // 处理分页信息
    List<dynamic> responseData = responseDataa['list'];
    //判断是否存在下一页
    if (responseDataa['hasNextPage']) {
      currentPage++;
    } else {
      isLoadingMore.value = true;
    }
    if (responseData != null && responseData is List) {
      List<MomentModel> list =
          responseData.map((item) => MomentModel.fromJson(item)).toList();
      return list;
    }
    return [];
  }
}
