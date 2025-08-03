import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:alpaca/pages/moment/moment_info_page.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:alpaca/request/request_moment.dart';
import 'package:alpaca/pages/base/base_controller.dart';

class MomentInfoController extends BaseController {
  final RxList<MapEntry<DateTime, List<MomentModel>>> groupedPosts =
      <MapEntry<DateTime, List<MomentModel>>>[].obs;

  // 数据加载状态
  final Rx<bool> isLoading = Rx<bool>(false);

  // 下滑加载状态
  final Rx<bool> isLoadingMore = Rx<bool>(false);

  // 当前页码
  int currentPage = 1;

  // 每页数量
  int pageSize = 10;

  // 记录已经加载过的页码
  final Set<int> loadedPages = Set<int>();

  // 接收从页面传递的userId（必传参数）
  final String userId;

  // 构造函数：要求必须传入userId
  MomentInfoController({required this.userId});

  @override
  void onReady() {
    super.onReady();
    _loadMoments(1, isRefresh: true);
  }

  void groupPosts(List<MomentModel> posts) {
    Map<DateTime, List<MomentModel>> grouped = {};
    for (var post in posts) {
      DateTime? postDateTime;
      if (post.createTime != null) {
        try {
          postDateTime = post.createTime!;
        } catch (e) {
          postDateTime = DateTime.now();
          print('解析时间失败: ${post.createTime}, 错误: $e');
        }
      } else {
        postDateTime = DateTime.now();
      }

      DateTime date = DateTime(
        postDateTime.year,
        postDateTime.month,
        postDateTime.day,
      );

      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(post);
    }

    groupedPosts.value = grouped.entries.toList();
    groupedPosts.sort((a, b) => b.key.compareTo(a.key));
  }

  Future<void> onRefresh() async {
    try {
      await _loadMoments(1, isRefresh: true);
      refreshController.refreshCompleted(); // 使用父类控制器
    } catch (e) {
      // 修改：刷新失败提示（中文）
      refreshController.refreshFailed(); // 使用父类控制器
    }
  }

  Future<void> onLoad() async {
    if (isLoadingMore.value) return;
    update();
    try {
      await _loadMoments(currentPage, isRefresh: false);
      // 判断是否有更多数据
      bool hasMore = !isLoadingMore.value;
      if (isLoadingMore.value) {
        refreshController.loadNoData(); // 使用父类控制器
      } else {
        refreshController.loadComplete(); // 使用父类控制器
      }
      // 修改：加载成功提示（中文逻辑）
    } catch (e) {
      // 修改：加载失败提示（中文）
      refreshController.loadFailed();
    }
  }

  Future<void> _loadMoments(int page, {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      loadedPages.clear();
      isLoading.value = true;
      groupedPosts.clear();
      refreshList.clear(); // 复用父类列表
    } else {
      isLoadingMore.value = true;
    }
    update();

    try {
      if (!loadedPages.contains(page)) {
        List<MomentModel> newMoments =
            await getMomentListbyid(page, pageSize, userId);
        if (isRefresh) {
          groupPosts(newMoments);
        } else {
          final allPosts = [
            ...groupedPosts.expand((e) => e.value),
            ...newMoments
          ];
          groupPosts(allPosts);
        }
        loadedPages.add(page);
      }
    } catch (e) {
      print('加载动态失败: $e');
      if (!isRefresh) {
        currentPage--;
      }
    } finally {
      if (isRefresh) {
        isLoading.value = false;
      } else {
        isLoadingMore.value = false;
      }
      update();
    }
  }

  Future<List<MomentModel>> getMomentListbyid(
      int page, int pageSize, String userId) async {
    print('当前请求页：$page，用户ID：$userId');
    dynamic responseDataa =
        await RequestMoment.getMomentListbyid(userId, page, pageSize);
    List<dynamic> responseData = responseDataa['list'] ?? [];
    if (responseData is List) {
      List<MomentModel> list =
          responseData.map((item) => MomentModel.fromJson(item)).toList();
      if (responseDataa['hasNextPage'] == true) {
        currentPage++;
        print('下一页请求页：$currentPage');
        isLoadingMore.value = false;
      } else {
        isLoadingMore.value = true;
      }
      return list;
    }
    isLoadingMore.value = true;
    return [];
  }
}
