// lib/pages/moment/moment_index_controller.dart
import 'package:alpaca/pages/base/base_controller.dart';
import 'package:alpaca/tools/tools_comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
//添加通用网络请求
import 'package:alpaca/request/request_moment.dart';

import 'package:alpaca/tools/tools_storage.dart';

class MomentIndexController extends BaseController {
  // 朋友圈列表
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

  // 记录已经加载过的页码
  final Set<int> loadedPages = Set<int>();

  @override
  void onInit() {
    super.onInit();
    //_loadMoments(1, isRefresh: true);
  }

  // 刷新
  Future<void> onRefresh() async {
    await _loadMoments(1, isRefresh: true);
  }

  // 重新加载数据
  Future<void> reloadData() async {
    await _loadMoments(1, isRefresh: true);
  }

  // 下滑加载更多（确保此方法存在）
  Future<void> onLoadMore() async {
    if (isLoadingMore.value) return;
    await _loadMoments(currentPage, isRefresh: false);
  }

  // 统一的加载数据方法
  Future<void> _loadMoments(int page, {bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      loadedPages.clear();
      isLoading.value = true;
      momentList.clear();
    } else {
      isLoadingMore.value = true;
    }
    update();

    try {
      if (!loadedPages.contains(page)) {
        List<MomentModel> newMoments = await getMoments(page, pageSize);
        if (isRefresh) {
          momentList.value = newMoments;
        } else {
          momentList.addAll(newMoments);
        }
        loadedPages.add(page);
      }
    } catch (e) {
      debugPrint('Error loading moments: $e');
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

  /**
   * 发起点赞
   */
  Future<bool> likeMoment(int momentId) async {
    debugPrint('点赞开始');
    // 假设 API 调用成功后返回 true
    await RequestMoment.likeMoment(momentId);
    return true;
  }

  //发起评论
  Future<bool> addComment(int momentId, int replyTo, String content) async {
    debugPrint('评论开始');
    // 假设 API 调用成功后返回 true
    await RequestMoment.addComment(momentId, replyTo, content);
    return true;
  }

  /**
   * 模拟API请求（确保参数正确）
   */
  Future<List<MomentModel>> getMoments(int page, int pageSize) async {
    debugPrint('当前请求页：' + page.toString());
    dynamic responseDataa = await RequestMoment.getMomentList(page, pageSize);
    // 处理分页信息
    List<dynamic> responseData = responseDataa['list'];
    if (responseData != null && responseData is List) {
      List<MomentModel> list =
          responseData.map((item) => MomentModel.fromJson(item)).toList();
      //判断是否存在下一页
      if (responseDataa['hasNextPage']) {
        currentPage++;
        debugPrint('下个请求页：' + currentPage.toString());
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
